using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using PCBuilder_DACS.Models;
using PCBuilder_DACS.Services;
using System.Linq;
using System.Threading.Tasks;

namespace PCBuilder_DACS.Areas.Admin.Controllers
{
    [Area("Admin")]
    [Authorize(Roles = "Admin")]
    public class OrdersController : Controller
    {
        private readonly PcBuilderContext _context;
        private readonly LoyaltyService _loyaltyService;

        public OrdersController(PcBuilderContext context, LoyaltyService loyaltyService)
        {
            _context = context;
            _loyaltyService = loyaltyService;
        }

        // GET: Admin/Orders
        public async Task<IActionResult> Index()
        {
            var orders = await _context.Orders
                .Include(o => o.User)
                .OrderByDescending(o => o.OrderDate)
                .ToListAsync();

            return View(orders);
        }

        // GET: Admin/Orders/Details/5
        public async Task<IActionResult> Details(int id)
        {
            var order = await _context.Orders
                .Include(o => o.User)
                .Include(o => o.OrderDetails)
                    .ThenInclude(od => od.Product)
                .FirstOrDefaultAsync(o => o.OrderId == id);

            if (order == null) return NotFound();

            return View(order);
        }

        // POST: Admin/Orders/UpdateStatus
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> UpdateStatus(int orderId, string status)
        {
            var order = await _context.Orders.Include(o => o.User).FirstOrDefaultAsync(o => o.OrderId == orderId);
            if (order == null) return NotFound();

            var validStatuses = new[] { "Pending", "Shipping", "Completed", "Cancelled", "Returned" };
            if (!validStatuses.Contains(status)) return BadRequest();

            // Loyalty logic
            if (status == "Completed" && order.Status != "Completed")
            {
                await _loyaltyService.AwardPointsAsync(order, order.User);
            }
            else if ((status == "Cancelled" || status == "Returned") && order.Status == "Completed")
            {
                await _loyaltyService.ReversePointsAsync(order, order.User);
            }

            order.Status = status;
            await _context.SaveChangesAsync();

            TempData["Success"] = $"Đã cập nhật trạng thái đơn #{orderId} thành \"{status}\".";
            return RedirectToAction(nameof(Details), new { id = orderId });
        }
    }
}
