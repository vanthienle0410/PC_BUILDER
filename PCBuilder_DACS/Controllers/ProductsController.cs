using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using PCBuilder_DACS.Models;

namespace PCBuilder_DACS.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ProductsController : ControllerBase
    {
        private readonly PcBuilderContext _context;

        public ProductsController(PcBuilderContext context)
        {
            _context = context;
        }

        // GET: api/Products
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Product>>> GetProducts()
        {
            if (_context.Products == null)
            {
                return NotFound();
            }
            return await _context.Products.Where(p => p.IsActive).ToListAsync();
        }

        // GET: api/Products/5
        [HttpGet("{id}")]
        public async Task<ActionResult<Product>> GetProduct(int id)
        {
            if (_context.Products == null)
            {
                return NotFound();
            }

            var product = await _context.Products.FindAsync(id);

            if (product == null)
            {
                return NotFound();
            }

            // ======================================================
            // BƯỚC NÂNG CẤP: GHI LẠI TƯƠNG TÁC ĐỂ AI HỌC TẬP
            // ======================================================
            try
            {
                // Bạn giả sử UserId = 1 để kiểm tra tính năng gợi ý.
                // Khi làm xong chức năng Đăng nhập, Bạn hãy lấy ID thật từ User.Identity
                // Tìm đoạn ghi tương tác và sửa lại dòng ngày tháng
                var interaction = new UserInteraction
                {
                    UserId = 1,
                    ProductId = product.ProductId,
                    Rating = 4.0f,
                    InteractionType = "View",
                    // Đổi CreatedAt thành InteractionDate ở đây
                    InteractionDate = DateTime.Now
                };

                _context.UserInteractions.Add(interaction);
                await _context.SaveChangesAsync();
            }
            catch (Exception ex)
            {
                // Chỉ log lỗi nếu cần, không làm gián đoạn việc xem sản phẩm của khách
                Console.WriteLine("Lỗi ghi tương tác AI: " + ex.Message);
            }
            // ======================================================

            return product;
        }

        // ======================================================
        // API MỚI: LẤY DANH SÁCH SẢN PHẨM THEO DANH MỤC (CPU, MAIN, RAM...)
        // ======================================================
        [HttpGet("ByCategory/{categoryId}")]
        public async Task<ActionResult<IEnumerable<Product>>> GetByCategory(int categoryId)
        {
            if (_context.Products == null)
            {
                return NotFound();
            }

            var products = await _context.Products
                .Where(p => p.CategoryId == categoryId && p.IsActive)
                .ToListAsync();

            if (!products.Any())
            {
                return NotFound("Không có sản phẩm nào trong danh mục này.");
            }

            return Ok(products);
        }

        // ======================================================
        // API TÌM KIẾM AUTOCOMPLETE (dùng cho thanh search navbar)
        // GET: api/Products/Search?q=asus&categoryId=0&limit=6
        // ======================================================
        [HttpGet("Search")]
        public async Task<IActionResult> Search(string q = "", int categoryId = 0, int limit = 6)
        {
            if (string.IsNullOrWhiteSpace(q) || q.Length < 2)
                return Ok(new List<object>());

            var query = _context.Products
                .Include(p => p.Category)
                .Where(p => p.IsActive
                         && p.ImagePath != null && p.ImagePath != ""
                         && p.ProductName.Contains(q));

            if (categoryId > 0)
                query = query.Where(p => p.CategoryId == categoryId);

            var results = await query
                .OrderBy(p => p.ProductName)
                .Take(limit)
                .Select(p => new
                {
                    p.ProductId,
                    p.ProductName,
                    p.Price,
                    p.ImagePath,
                    CategoryName = p.Category != null ? p.Category.CategoryName : ""
                })
                .ToListAsync();

            return Ok(results);
        }
    }
}