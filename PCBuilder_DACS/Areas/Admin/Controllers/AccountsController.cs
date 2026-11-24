using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using PCBuilder_DACS.Models;
using System.Threading.Tasks;
using System.Linq;

namespace PCBuilder_DACS.Areas.Admin.Controllers
{
    [Area("Admin")]
    [Authorize(Roles = "Admin")]
    public class AccountsController : Controller
    {
        private readonly UserManager<ApplicationUser> _userManager;
        private readonly RoleManager<IdentityRole<int>> _roleManager;
        private readonly PcBuilderContext _context;

        public AccountsController(UserManager<ApplicationUser> userManager, RoleManager<IdentityRole<int>> roleManager, PcBuilderContext context)
        {
            _userManager = userManager;
            _roleManager = roleManager;
            _context = context;
        }

        public async Task<IActionResult> Index()
        {
            var users = await _userManager.Users.ToListAsync();
            // We can pass a tuple or a ViewModel. Let's use ViewBag for roles to keep it simple.
            
            var userRoles = new System.Collections.Generic.Dictionary<int, string>();
            foreach(var user in users)
            {
                var roles = await _userManager.GetRolesAsync(user);
                userRoles[user.Id] = string.Join(", ", roles);
            }
            
            ViewBag.UserRoles = userRoles;
            return View(users);
        }

        public async Task<IActionResult> Details(int id)
        {
            var user = await _userManager.Users.FirstOrDefaultAsync(u => u.Id == id);
            if (user == null)
            {
                return NotFound();
            }

            var roles = await _userManager.GetRolesAsync(user);
            ViewBag.Roles = string.Join(", ", roles);

            // Get Order History
            var orders = await _context.Orders
                .Where(o => o.UserId == id)
                .OrderByDescending(o => o.OrderDate)
                .ToListAsync();
                
            ViewBag.Orders = orders;

            return View(user);
        }

        [HttpPost]
        public async Task<IActionResult> Delete(int id)
        {
            var user = await _userManager.FindByIdAsync(id.ToString());
            if (user == null)
            {
                return NotFound();
            }

            // Manually delete related data to avoid foreign key constraints
            // 1. UserInteractions
            var interactions = _context.UserInteractions.Where(x => x.UserId == id);
            _context.UserInteractions.RemoveRange(interactions);

            // 2. ProductReviews
            var reviews = _context.ProductReviews.Where(x => x.UserId == id);
            _context.ProductReviews.RemoveRange(reviews);

            // 3. VoucherUsages
            var voucherUsages = _context.VoucherUsages.Where(x => x.UserId == id);
            _context.VoucherUsages.RemoveRange(voucherUsages);

            // 4. Orders (which will cascade delete OrderDetails and InstallmentSchedules via EF configuration if set, but let's be safe)
            var orders = _context.Orders.Where(x => x.UserId == id).ToList();
            var orderIds = orders.Select(o => o.OrderId).ToList();
            
            var orderDetails = _context.OrderDetails.Where(x => orderIds.Contains(x.OrderId));
            _context.OrderDetails.RemoveRange(orderDetails);

            var installments = _context.InstallmentSchedules.Where(x => orderIds.Contains(x.OrderId));
            _context.InstallmentSchedules.RemoveRange(installments);

            _context.Orders.RemoveRange(orders);

            await _context.SaveChangesAsync();

            // Finally, delete the user
            await _userManager.DeleteAsync(user);
            
            return RedirectToAction(nameof(Index));
        }

        [HttpPost]
        public async Task<IActionResult> AssignRole(int id, string role)
        {
            var user = await _userManager.FindByIdAsync(id.ToString());
            if (user == null)
            {
                return NotFound();
            }

            var currentRoles = await _userManager.GetRolesAsync(user);
            await _userManager.RemoveFromRolesAsync(user, currentRoles);
            
            if (await _roleManager.RoleExistsAsync(role))
            {
                await _userManager.AddToRoleAsync(user, role);
            }
            else
            {
                 // Role doesn't exist, create it if it's "Admin" or "Customer"
                 if(role == "Admin" || role == "Customer")
                 {
                     await _roleManager.CreateAsync(new IdentityRole<int>(role));
                     await _userManager.AddToRoleAsync(user, role);
                 }
            }

            return RedirectToAction(nameof(Index));
        }
    }
}
