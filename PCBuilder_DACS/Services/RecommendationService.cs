using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.ML;
using Microsoft.ML.Trainers;
using Microsoft.EntityFrameworkCore;
using PCBuilder_DACS.MLModels;
using PCBuilder_DACS.Models;

namespace PCBuilder_DACS.Services
{
    public class RecommendationService : IRecommendationService
    {
        private readonly IServiceScopeFactory _scopeFactory;
        private readonly IWebHostEnvironment _env;
        private static string _modelPath = string.Empty;
        private readonly MLContext _mlContext;
        private ITransformer? _model;

        public RecommendationService(IServiceScopeFactory scopeFactory, IWebHostEnvironment env)
        {
            _scopeFactory = scopeFactory;
            _env = env;
            _modelPath = Path.Combine(_env.ContentRootPath, "MLModels", "ProductRecommenderModel.zip");
            _mlContext = new MLContext(seed: 0);

            // Try load model if exists
            if (File.Exists(_modelPath))
            {
                _model = _mlContext.Model.Load(_modelPath, out var modelInputSchema);
            }
        }

        public async Task TrainModelAsync()
        {
            using var scope = _scopeFactory.CreateScope();
            var dbContext = scope.ServiceProvider.GetRequiredService<PcBuilderContext>();

            // 1. Load Data from Database
            var interactions = await dbContext.UserInteractions
                .Where(u => u.UserId.HasValue && u.ProductId.HasValue)
                .Select(u => new ProductInteraction
                {
                    UserId = (float)u.UserId.Value,
                    ProductId = (float)u.ProductId.Value,
                    Label = 1.0f // Simple implicit feedback: interacted = 1
                })
                .ToListAsync();

            if (!interactions.Any())
            {
                throw new Exception("No user interaction data available for training.");
            }

            // Load data into IDataView
            IDataView trainingDataView = _mlContext.Data.LoadFromEnumerable(interactions);

            // 2. Build Pipeline
            var pipeline = _mlContext.Transforms.Conversion.MapValueToKey(outputColumnName: "userIdEncoded", inputColumnName: nameof(ProductInteraction.UserId))
                .Append(_mlContext.Transforms.Conversion.MapValueToKey(outputColumnName: "productIdEncoded", inputColumnName: nameof(ProductInteraction.ProductId)))
                .Append(_mlContext.Recommendation().Trainers.MatrixFactorization(new MatrixFactorizationTrainer.Options
                {
                    MatrixColumnIndexColumnName = "userIdEncoded",
                    MatrixRowIndexColumnName = "productIdEncoded",
                    LabelColumnName = nameof(ProductInteraction.Label),
                    NumberOfIterations = 20,
                    ApproximationRank = 100
                }));

            // 3. Train Model
            _model = pipeline.Fit(trainingDataView);

            // 4. Save Model
            var modelDir = Path.GetDirectoryName(_modelPath);
            if (modelDir != null && !Directory.Exists(modelDir))
            {
                Directory.CreateDirectory(modelDir);
            }
            _mlContext.Model.Save(_model, trainingDataView.Schema, _modelPath);
        }

        public IEnumerable<Product> GetRecommendations(int userId, int count = 5)
        {
            if (_model == null)
            {
                return new List<Product>(); // Model not trained yet
            }

            using var scope = _scopeFactory.CreateScope();
            var dbContext = scope.ServiceProvider.GetRequiredService<PcBuilderContext>();

            // Get all products to score (chỉ sản phẩm đang active và chưa bị ẩn)
            var allProducts = dbContext.Products.Where(p => p.IsActive && !p.IsHiddenFromRecommendation).ToList();

            // Create prediction engine
            var predictionEngine = _mlContext.Model.CreatePredictionEngine<ProductInteraction, ProductRecommendation>(_model);

            // Predict score for each product
            var recommendations = allProducts.Select(p => new
            {
                Product = p,
                Score = predictionEngine.Predict(new ProductInteraction
                {
                    UserId = (float)userId,
                    ProductId = (float)p.ProductId
                }).Score
            })
            .OrderByDescending(x => float.IsNaN(x.Score) ? float.MinValue : x.Score)
            .Take(count)
            .Select(x => x.Product)
            .ToList();

            return recommendations;
        }

        // =========================================================
        // HÀM MỚI ĐƯỢC THÊM VÀO: ĐỂ CHẤM ĐIỂM CHO TỪNG LINH KIỆN TƯƠNG THÍCH
        // =========================================================
        public ProductPrediction GetPrediction(int userId, int productId)
        {
            // Nếu AI chưa được Train (chưa có model.zip), trả về điểm 0 mặc định
            if (_model == null)
            {
                return new ProductPrediction { Score = 0f };
            }

            // Tạo bộ máy dự đoán từ model đã lưu
            var predictionEngine = _mlContext.Model.CreatePredictionEngine<ProductInteraction, ProductRecommendation>(_model);

            // AI tính toán điểm số xem User này thích Product này cỡ nào
            var prediction = predictionEngine.Predict(new ProductInteraction
            {
                UserId = (float)userId,
                ProductId = (float)productId
            });

            // Trả kết quả về cho Controller (Xử lý luôn trường hợp AI tính ra lỗi NaN)
            return new ProductPrediction
            {
                Score = float.IsNaN(prediction.Score) ? 0f : prediction.Score
            };
        }
    }
}