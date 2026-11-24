using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using PCBuilder_DACS.Models;
using PCBuilder_DACS.Services;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
using System.Threading.Tasks;

namespace PCBuilder_DACS.Controllers
{
    public class ProductController : Controller
    {
        private readonly PcBuilderContext _context;
        private readonly ISentimentAnalysisService _sentimentService;

        public ProductController(PcBuilderContext context, ISentimentAnalysisService sentimentService)
        {
            _context = context;
            _sentimentService = sentimentService;
        }

        // GET: /Products?category=CPU&brand=Intel&search=ryzen&sort=price_asc&minPrice=&maxPrice=
        public async Task<IActionResult> Index(
            string? category, string? brand, string? search, string? sort,
            decimal? minPrice, decimal? maxPrice,
            int page = 1)
        {
            const int pageSize = 20;
            var query = _context.Products
                .Include(p => p.Category)
                .Where(p => p.IsActive)
                .AsQueryable();

            // Filter by category name
            if (!string.IsNullOrEmpty(category))
                query = query.Where(p => p.Category != null && p.Category.CategoryName == category);

            // Filter by brand (case-insensitive contains for flexibility)
            if (!string.IsNullOrEmpty(brand))
                query = query.Where(p => p.Brand != null && p.Brand.Contains(brand));

            // Filter by price range
            if (minPrice.HasValue)
                query = query.Where(p => p.Price >= minPrice.Value);
            if (maxPrice.HasValue)
                query = query.Where(p => p.Price <= maxPrice.Value);

            // Search by product name or brand
            if (!string.IsNullOrEmpty(search))
                query = query.Where(p =>
                    p.ProductName.Contains(search) ||
                    (p.Brand != null && p.Brand.Contains(search)));

            // Sort
            query = sort switch
            {
                "price_asc"  => query.OrderBy(p => p.Price),
                "price_desc" => query.OrderByDescending(p => p.Price),
                "name_asc"   => query.OrderBy(p => p.ProductName),
                _            => query.OrderByDescending(p => p.ProductId) // newest first
            };

            int totalItems = await query.CountAsync();
            var products   = await query.Skip((page - 1) * pageSize).Take(pageSize).ToListAsync();
            var categories = await _context.Categories.ToListAsync();

            // Lấy danh sách thương hiệu có sẵn cho danh mục hiện tại (để hiện sidebar)
            var brandQuery = _context.Products
                .Include(p => p.Category)
                .Where(p => p.IsActive && p.Brand != null && p.Brand != "");
            if (!string.IsNullOrEmpty(category))
                brandQuery = brandQuery.Where(p => p.Category != null && p.Category.CategoryName == category);

            var availableBrands = await brandQuery
                .GroupBy(p => p.Brand)
                .Select(g => new { Brand = g.Key!, Count = g.Count() })
                .OrderByDescending(x => x.Count)
                .Take(15) // Tối đa 15 thương hiệu
                .ToListAsync();

            ViewBag.Categories    = categories;
            ViewBag.CurrentCat    = category;
            ViewBag.CurrentBrand  = brand;
            ViewBag.CurrentSearch = search;
            ViewBag.CurrentSort   = sort;
            ViewBag.CurrentMin    = minPrice;
            ViewBag.CurrentMax    = maxPrice;
            ViewBag.TotalItems    = totalItems;
            ViewBag.TotalPages    = (int)Math.Ceiling((double)totalItems / pageSize);
            ViewBag.CurrentPage   = page;
            ViewBag.AvailableBrands = availableBrands;

            return View(products);
        }

        // GET: Product/Details/5
        public async Task<IActionResult> Details(int id)
        {
            var product = await _context.Products
                .Include(p => p.Category)
                .Include(p => p.CpuSpec)
                .Include(p => p.GpuSpec)
                .Include(p => p.MainboardSpec)
                .Include(p => p.RamSpec)
                .FirstOrDefaultAsync(m => m.ProductId == id);

            if (product == null)
            {
                return NotFound();
            }

            // Lấy danh sách bình luận (Bao gồm cả bị ẩn để tính điểm trung bình)
            ViewBag.Reviews = await _context.ProductReviews
                .Include(r => r.User)
                .Where(r => r.ProductId == id)
                .OrderByDescending(r => r.CreatedAt)
                .ToListAsync();

            // Kiểm tra quyền đánh giá: user phải đã mua và đơn hàng Completed
            ViewBag.HasPurchased = false;
            ViewBag.AlreadyReviewed = false;

            if (User.Identity != null && User.Identity.IsAuthenticated)
            {
                var userIdClaim = User.FindFirst(ClaimTypes.NameIdentifier);
                if (userIdClaim != null && int.TryParse(userIdClaim.Value, out int userId))
                {
                    ViewBag.HasPurchased = await _context.Orders
                        .Where(o => o.UserId == userId && o.Status == "Completed")
                        .AnyAsync(o => o.OrderDetails.Any(od => od.ProductId == id));

                    ViewBag.AlreadyReviewed = await _context.ProductReviews
                        .AnyAsync(r => r.ProductId == id && r.UserId == userId);
                }
            }

            return View(product);
        }

        // POST: Product/PostReview
        [HttpPost]
        public async Task<IActionResult> PostReview([FromBody] ReviewSubmission model)
        {
            if (User.Identity == null || !User.Identity.IsAuthenticated)
            {
                return Unauthorized(new { message = "Vui lòng đăng nhập" });
            }

            if (string.IsNullOrEmpty(model.Content))
            {
                return BadRequest(new { message = "Nội dung không được để trống" });
            }

            var userIdClaim = User.FindFirst(ClaimTypes.NameIdentifier);
            if (userIdClaim == null) return Unauthorized(new { message = "Không tìm thấy thông tin người dùng" });
            int userId = int.Parse(userIdClaim.Value);

            // === TASK 2: Kiểm tra quyền đánh giá (chỉ khách đã mua & hoàn tất) ===
            bool hasPurchased = await _context.Orders
                .Where(o => o.UserId == userId && o.Status == "Completed")
                .AnyAsync(o => o.OrderDetails.Any(od => od.ProductId == model.ProductId));

            if (!hasPurchased)
            {
                return BadRequest(new { message = "Bạn cần mua và nhận sản phẩm (đơn hàng Hoàn thành) trước khi đánh giá." });
            }

            // Ngăn đánh giá trùng lặp
            bool alreadyReviewed = await _context.ProductReviews
                .AnyAsync(r => r.ProductId == model.ProductId && r.UserId == userId);

            if (alreadyReviewed)
            {
                return BadRequest(new { message = "Bạn đã đánh giá sản phẩm này rồi." });
            }

            // === Phân tích cảm xúc bằng AI ===
            string sentiment = _sentimentService.AnalyzeSentiment(model.Content);

            // Nếu rating <= 2 sao, ép kết quả AI thành Negative
            if (model.Rating <= 2)
            {
                sentiment = "Negative";
            }

            var review = new ProductReview
            {
                ProductId = model.ProductId,
                UserId = userId,
                Content = model.Content,
                Rating = model.Rating,
                Sentiment = sentiment,
                CreatedAt = DateTime.Now
            };

            _context.ProductReviews.Add(review);

            // Ghi lại tương tác cho Recommender System
            float interactionRating = sentiment == "Positive" ? 5.0f : 1.0f;

            var interaction = new UserInteraction
            {
                UserId = userId,
                ProductId = model.ProductId,
                InteractionType = "Review",
                Rating = interactionRating,
                InteractionDate = DateTime.Now
            };
            _context.UserInteractions.Add(interaction);

            await _context.SaveChangesAsync();

            // === TASK 1: Auto-Hide Logic ===
            // Đếm số đánh giá tiêu cực của sản phẩm này
            var allReviews = await _context.ProductReviews
                .Where(r => r.ProductId == model.ProductId)
                .ToListAsync();

            int totalReviews = allReviews.Count;
            int negativeCount = allReviews.Count(r => r.Sentiment == "Negative");

            // Ngưỡng: >= 3 đánh giá tiêu cực VÀ tỷ lệ > 60%
            bool shouldAutoHide = negativeCount >= 3 && (double)negativeCount / totalReviews > 0.6;

            if (shouldAutoHide)
            {
                var product = await _context.Products.FindAsync(model.ProductId);
                if (product != null && !product.IsHiddenFromRecommendation)
                {
                    product.IsHiddenFromRecommendation = true;
                    await _context.SaveChangesAsync();
                }
            }

            return Ok(new
            {
                message = "Đã gửi đánh giá thành công!",
                sentiment = sentiment,
                autoHidden = shouldAutoHide
            });
        }
    }

    public class ReviewSubmission
    {
        public int ProductId { get; set; }
        public string Content { get; set; } = string.Empty;
        public int Rating { get; set; } = 5;
    }
}
