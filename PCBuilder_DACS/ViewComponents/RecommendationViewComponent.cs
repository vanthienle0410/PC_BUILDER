using Microsoft.AspNetCore.Mvc;
using PCBuilder_DACS.Services;
using PCBuilder_DACS.Models;
using Microsoft.EntityFrameworkCore;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace PCBuilder_DACS.ViewComponents
{
    public class RecommendationViewComponent : ViewComponent
    {
        private readonly IRecommendationService _recommendationService;
        private readonly PcBuilderContext _context;

        public RecommendationViewComponent(IRecommendationService recommendationService, PcBuilderContext context)
        {
            _recommendationService = recommendationService;
            _context = context;
        }

        public async Task<IViewComponentResult> InvokeAsync(int userId)
        {
            // SỬA LỖI CS0019: Vế trái trả về List<Product> thì vế phải cũng phải là List<Product>
            var products = _recommendationService.GetRecommendations(userId) ?? new List<Product>();

            // Nếu AI không có kết quả, lấy sản phẩm mới nhất thay thế (Cold Start)
            if (!products.Any())
            {
                products = await _context.Products
                    .OrderByDescending(p => p.ProductId)
                    .Take(4)
                    .ToListAsync();
            }

            return View(products);
        }
    }
}