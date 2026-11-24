using Microsoft.ML;
using PCBuilder_DACS.MLModels;
using System.Collections.Generic;

namespace PCBuilder_DACS.Services
{
    public class SentimentAnalysisService : ISentimentAnalysisService
    {
        private readonly MLContext _mlContext;
        private ITransformer? _model;
        private PredictionEngine<SentimentData, SentimentPrediction>? _predictionEngine;

        public SentimentAnalysisService()
        {
            _mlContext = new MLContext();
            TrainModel();
        }

        public void TrainModel()
        {
            var samples = new List<SentimentData>
            {
                new SentimentData { SentimentText = "Sản phẩm rất tốt", Sentiment = true },
                new SentimentData { SentimentText = "Tuyệt vời", Sentiment = true },
                new SentimentData { SentimentText = "Rất đáng tiền", Sentiment = true },
                new SentimentData { SentimentText = "Hài lòng", Sentiment = true },
                new SentimentData { SentimentText = "Chất lượng cao", Sentiment = true },
                new SentimentData { SentimentText = "Đẹp xuất sắc", Sentiment = true },
                new SentimentData { SentimentText = "Dùng rất mượt", Sentiment = true },
                new SentimentData { SentimentText = "Giao hàng nhanh", Sentiment = true },
                
                new SentimentData { SentimentText = "Hàng dở tệ", Sentiment = false },
                new SentimentData { SentimentText = "Thất vọng", Sentiment = false },
                new SentimentData { SentimentText = "Quá kém", Sentiment = false },
                new SentimentData { SentimentText = "Không đáng mua", Sentiment = false },
                new SentimentData { SentimentText = "Lỗi liên tục", Sentiment = false },
                new SentimentData { SentimentText = "Kém chất lượng", Sentiment = false },
                new SentimentData { SentimentText = "Thái độ phục vụ tệ", Sentiment = false },
                new SentimentData { SentimentText = "Hàng giả", Sentiment = false }
            };

            var trainData = _mlContext.Data.LoadFromEnumerable(samples);

            var pipeline = _mlContext.Transforms.Text.FeaturizeText(outputColumnName: "Features", inputColumnName: nameof(SentimentData.SentimentText))
                .Append(_mlContext.BinaryClassification.Trainers.SdcaLogisticRegression(labelColumnName: "Label", featureColumnName: "Features"));

            _model = pipeline.Fit(trainData);
            _predictionEngine = _mlContext.Model.CreatePredictionEngine<SentimentData, SentimentPrediction>(_model);
        }

        public string AnalyzeSentiment(string text)
        {
            if (_predictionEngine == null)
            {
                return "Neutral";
            }

            var prediction = _predictionEngine.Predict(new SentimentData { SentimentText = text });
            return prediction.Prediction ? "Positive" : "Negative";
        }
    }
}
