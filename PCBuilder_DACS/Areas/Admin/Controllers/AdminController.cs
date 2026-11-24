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
    public class AdminController : Controller
    {
        private readonly PcBuilderContext _context;

        public AdminController(PcBuilderContext context)
        {
            _context = context;
        }

        public async Task<IActionResult> Index()
        {
            // Đếm số liệu thật từ DB
            ViewBag.TotalProducts = await _context.Products.CountAsync(p => p.IsActive);
            ViewBag.TotalOrders   = await _context.Orders.CountAsync();
            ViewBag.HiddenProducts = await _context.Products.CountAsync(p => !p.IsActive);

            // Số sản phẩm đang bị cảnh báo AI (>70% tiêu cực)
            var productStats = await _context.Products
                .Where(p => p.IsActive)
                .Select(p => new {
                    p.ProductId,
                    Total    = _context.ProductReviews.Count(r => r.ProductId == p.ProductId),
                    Negative = _context.ProductReviews.Count(r => r.ProductId == p.ProductId && r.Sentiment == "Negative")
                })
                .Where(p => p.Total > 0)
                .ToListAsync();

            ViewBag.AiAlertCount = productStats.Count(p => (double)p.Negative / p.Total > 0.7);

            return View();
        }
    }
}
