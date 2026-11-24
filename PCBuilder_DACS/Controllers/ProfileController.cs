using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using PCBuilder_DACS.Models;
using System.Linq;
using System.Security.Claims;
using System.Threading.Tasks;

namespace PCBuilder_DACS.Controllers
{
    [Authorize]
    public class ProfileController : Controller
    {
        private readonly UserManager<ApplicationUser> _userManager;
        private readonly PcBuilderContext _context;

        public ProfileController(UserManager<ApplicationUser> userManager, PcBuilderContext context)
        {
            _userManager = userManager;
            _context = context;
        }

        public async Task<IActionResult> Index()
        {
            var user = await _userManager.GetUserAsync(User);
            if (user == null) return NotFound();

            return View(user);
        }

        public async Task<IActionResult> OrderHistory()
        {
            var userIdStr = User.FindFirstValue(ClaimTypes.NameIdentifier);
            if (!int.TryParse(userIdStr, out int userId))
                return Unauthorized();

            var orders = await _context.Orders
                .Include(o => o.OrderDetails)
                    .ThenInclude(od => od.Product)
                .Where(o => o.UserId == userId)
                .OrderByDescending(o => o.OrderDate)
                .ToListAsync();

            return View(orders);
        }

        public async Task<IActionResult> Installments()
        {
            var userIdStr = User.FindFirstValue(ClaimTypes.NameIdentifier);
            if (!int.TryParse(userIdStr, out int userId))
                return Unauthorized();

            var schedules = await _context.InstallmentSchedules
                .Include(s => s.Order)
                .Where(s => s.Order.UserId == userId)
                .OrderBy(s => s.DueDate)
                .ToListAsync();

            return View(schedules);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> CancelOrder(int id)
        {
            var userIdStr = User.FindFirstValue(ClaimTypes.NameIdentifier);
            if (!int.TryParse(userIdStr, out int userId))
                return Unauthorized();

            var order = await _context.Orders.FirstOrDefaultAsync(o => o.OrderId == id && o.UserId == userId);
            if (order == null)
                return NotFound();

            if (order.Status != "Pending")
            {
                TempData["ErrorMessage"] = "Chỉ có thể hủy đơn hàng đang chờ xử lý.";
                return RedirectToAction(nameof(OrderHistory));
            }

            if ((System.DateTime.Now - order.OrderDate).TotalHours > 24)
            {
                TempData["ErrorMessage"] = "Đã quá 24h, không thể hủy đơn hàng này.";
                return RedirectToAction(nameof(OrderHistory));
            }

            order.Status = "Cancelled";
            
            // Hủy luôn các khoản trả góp nếu có
            var installments = await _context.InstallmentSchedules.Where(s => s.OrderId == id).ToListAsync();
            foreach (var item in installments)
            {
                item.Status = "Cancelled";
            }

            await _context.SaveChangesAsync();
            TempData["SuccessMessage"] = $"Hủy thành công đơn hàng #{id}.";
            
            return RedirectToAction(nameof(OrderHistory));
        }
    }
}
