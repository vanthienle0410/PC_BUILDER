using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using PCBuilder_DACS.Models;
using System.Linq;
using System.Threading.Tasks;

namespace PCBuilder_DACS.Areas.Admin.Controllers
{
    [Area("Admin")]
    [Authorize(Roles = "Admin")]
    public class ReviewsModerationController : Controller
    {
        private readonly PcBuilderContext _context;

        public ReviewsModerationController(PcBuilderContext context)
        {
            _context = context;
        }

        public async Task<IActionResult> Index()
        {
            var productStats = await _context.Products
                .Include(p => p.Category)
                .Select(p => new
                {
                    Product = p,
                    TotalReviews = _context.ProductReviews.Count(r => r.ProductId == p.ProductId),
                    NegativeReviews = _context.ProductReviews.Count(r => r.ProductId == p.ProductId && r.Sentiment == "Negative")
                })
                .Where(p => p.TotalReviews > 0)
                .ToListAsync();

            var alerts = productStats.Select(p => new ProductReviewAlertViewModel
            {
                ProductId = p.Product.ProductId,
                ProductName = p.Product.ProductName,
                CategoryName = p.Product.Category?.CategoryName ?? "Unknown",
                TotalReviews = p.TotalReviews,
                NegativeReviews = p.NegativeReviews,
                NegativePercentage = (double)p.NegativeReviews / p.TotalReviews * 100,
                IsHiddenFromRecommendation = p.Product.IsHiddenFromRecommendation
            }).OrderByDescending(p => p.NegativePercentage).ToList();

            return View(alerts);
        }

        [HttpPost]
        public async Task<IActionResult> ToggleRecommendationVisibility(int productId)
        {
            var product = await _context.Products.FindAsync(productId);
            if (product != null)
            {
                product.IsHiddenFromRecommendation = !product.IsHiddenFromRecommendation;
                await _context.SaveChangesAsync();
            }
            return RedirectToAction(nameof(Index));
        }

        public async Task<IActionResult> ProductReviews(int id)
        {
            var product = await _context.Products.FindAsync(id);
            if (product == null) return NotFound();

            var reviews = await _context.ProductReviews
                .Include(r => r.User)
                .Where(r => r.ProductId == id)
                .OrderByDescending(r => r.CreatedAt)
                .ToListAsync();

            ViewBag.ProductName = product.ProductName;
            ViewBag.ProductId = product.ProductId;
            
            return View(reviews);
        }

        [HttpPost]
        public async Task<IActionResult> ToggleReviewVisibility(int id, int productId)
        {
            var review = await _context.ProductReviews.FindAsync(id);
            if (review != null)
            {
                review.IsHidden = !review.IsHidden;
                await _context.SaveChangesAsync();
            }
            return RedirectToAction(nameof(ProductReviews), new { id = productId });
        }
    }

    public class ProductReviewAlertViewModel
    {
        public int ProductId { get; set; }
        public string ProductName { get; set; }
        public string CategoryName { get; set; }
        public int TotalReviews { get; set; }
        public int NegativeReviews { get; set; }
        public double NegativePercentage { get; set; }
        public bool IsHiddenFromRecommendation { get; set; }
    }
}
