using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using PCBuilder_DACS.Models;
using PCBuilder_DACS.Models.ViewModels;
using PCBuilder_DACS.Services;
using System.Security.Claims;
using System.Text.Json;

namespace PCBuilder_DACS.Controllers
{
    public class CartController : Controller
    {
        private readonly PcBuilderContext _context;
        private readonly UserManager<ApplicationUser> _userManager;
        private readonly LoyaltyService _loyaltyService;
        private readonly VoucherService _voucherService;

        public CartController(PcBuilderContext context, UserManager<ApplicationUser> userManager, LoyaltyService loyaltyService, VoucherService voucherService)
        {
            _context = context;
            _userManager = userManager;
            _loyaltyService = loyaltyService;
            _voucherService = voucherService;
        }

        // =============================================
        // 1. TRANG GIỎ HÀNG
        // =============================================
        public async Task<IActionResult> Index()
        {
            var cartJson = HttpContext.Session.GetString("Cart");
            if (string.IsNullOrEmpty(cartJson))
                return View(new List<Product>());

            var productIds = JsonSerializer.Deserialize<List<int>>(cartJson);

            var products = await _context.Products
                .Where(p => productIds != null && productIds.Contains(p.ProductId))
                .ToListAsync();

            return View(products);
        }

        // =============================================
        // 2. API THÊM CẤU HÌNH VÀO GIỎ
        // =============================================
        [HttpPost]
        [Route("api/Cart/add-build")]
        public IActionResult AddBuildToCart([FromBody] List<int> productIds)
        {
            if (productIds == null || !productIds.Any())
                return BadRequest("Dữ liệu trống");

            var cartJson = HttpContext.Session.GetString("Cart");
            List<int> cart = string.IsNullOrEmpty(cartJson)
                ? new List<int>()
                : JsonSerializer.Deserialize<List<int>>(cartJson)!;

            cart.AddRange(productIds);
            HttpContext.Session.SetString("Cart", JsonSerializer.Serialize(cart));

            return Ok(new { message = "Thành công!", totalItems = cart.Count });
        }

        // =============================================
        // 2b. API THÊM LẺ 1 SẢN PHẨM VÀO GIỎ (Buy Now / Add to Cart)
        // =============================================
        [HttpPost]
        [Route("api/Cart/add")]
        public IActionResult AddSingleToCart([FromBody] AddToCartRequest request)
        {
            if (request == null || request.ProductId <= 0)
                return BadRequest(new { message = "Dữ liệu không hợp lệ." });

            var cartJson = HttpContext.Session.GetString("Cart");
            List<int> cart = string.IsNullOrEmpty(cartJson)
                ? new List<int>()
                : JsonSerializer.Deserialize<List<int>>(cartJson)!;

            int qty = Math.Max(1, request.Quantity);
            for (int i = 0; i < qty; i++)
                cart.Add(request.ProductId);

            HttpContext.Session.SetString("Cart", JsonSerializer.Serialize(cart));
            return Ok(new { message = $"Đã thêm {qty} sản phẩm vào giỏ!", totalItems = cart.Count });
        }

        // =============================================
        // 3. API XÓA SẢN PHẨM KHỎI GIỎ
        // =============================================
        [HttpPost]
        [Route("api/Cart/remove-item")]
        public IActionResult RemoveItem([FromBody] int productId)
        {
            var cartJson = HttpContext.Session.GetString("Cart");
            if (string.IsNullOrEmpty(cartJson)) return NotFound("Giỏ hàng trống");

            var cart = JsonSerializer.Deserialize<List<int>>(cartJson);
            if (cart != null && cart.Contains(productId))
            {
                cart.Remove(productId);
                HttpContext.Session.SetString("Cart", JsonSerializer.Serialize(cart));
                return Ok(new { message = "Đã xóa sản phẩm!" });
            }

            return BadRequest("Không tìm thấy sản phẩm trong giỏ.");
        }

        // =============================================
        // 4. TRANG XÁC NHẬN ĐẶT HÀNG (GET)
        //    Yêu cầu đăng nhập, hiển thị form SĐT + địa chỉ + preview giỏ
        // =============================================
        [Authorize]
        [HttpGet]
        public async Task<IActionResult> Checkout()
        {
            var cartJson = HttpContext.Session.GetString("Cart");
            if (string.IsNullOrEmpty(cartJson))
                return RedirectToAction("Index");

            var productIds = JsonSerializer.Deserialize<List<int>>(cartJson)!;

            var cartItems = await _context.Products
                .Where(p => productIds.Contains(p.ProductId))
                .ToListAsync();

            decimal subtotal = cartItems.Sum(p => p.Price ?? 0);

            // --- Loyalty discount ---
            var user = await _userManager.GetUserAsync(User);
            decimal loyaltyDiscount = 0;
            if (user != null)
                loyaltyDiscount = _loyaltyService.GetTierDiscount(user.Tier, subtotal);

            // --- Voucher Logic (Re-validation) ---
            var voucherCode = HttpContext.Session.GetString("AppliedVoucher");
            decimal voucherDiscount = 0;
            string? voucherMessage = null;
            Voucher? validVoucher = null;

            if (!string.IsNullOrEmpty(voucherCode) && user != null)
            {
                var validationResult = await _voucherService.ValidateVoucherAsync(voucherCode, user.Id, subtotal);
                if (validationResult.IsValid)
                {
                    validVoucher = validationResult.Voucher;
                }
                else
                {
                    // Invalid due to cart modification
                    HttpContext.Session.Remove("AppliedVoucher");
                    voucherCode = null;
                    voucherMessage = "Mã giảm giá đã bị gỡ do đơn hàng không còn đủ điều kiện.";
                }
            }

            decimal totalDiscount = loyaltyDiscount;
            if (validVoucher != null && user != null)
            {
                // Let VoucherService decide the best discount / stack
                totalDiscount = await _voucherService.CalculateBestDiscountAsync(user, subtotal, validVoucher);
                // Calculate how much of the total discount came specifically from the voucher for display
                voucherDiscount = totalDiscount - loyaltyDiscount; 
                // If it's not stackable, the voucher might fully replace loyalty, or vice-versa
                if (voucherDiscount < 0) voucherDiscount = 0; // Means loyalty was better
            }

            var viewModel = new CheckoutViewModel
            {
                CartItems = cartItems,
                TotalAmount = Math.Max(0, subtotal - totalDiscount),
                DiscountAmount = loyaltyDiscount,
                VoucherCode = voucherCode,
                VoucherDiscount = voucherDiscount,
                VoucherMessage = voucherMessage,
                Tier = user?.Tier ?? MembershipTier.Bronze
            };

            // Check if there is installment data in session
            var installmentJson = HttpContext.Session.GetString("InstallmentData");
            if (!string.IsNullOrEmpty(installmentJson))
            {
                var installmentData = JsonSerializer.Deserialize<InstallmentSessionData>(installmentJson);
                if (installmentData != null)
                {
                    viewModel.PaymentMethod = "Trả góp";
                    viewModel.InstallmentMonths = installmentData.Months;
                    viewModel.PrepaymentAmount = installmentData.PrepaymentAmount;
                    viewModel.MonthlyInstallment = installmentData.MonthlyInstallment;
                    // Add fee to total amount
                    viewModel.TotalAmount += installmentData.FeeAmount;
                }
            }

            return View(viewModel);
        }

        // =============================================
        // 5. XỬ LÝ ĐẶT HÀNG (POST) - Lưu vào Database
        // =============================================
        [Authorize]
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> PlaceOrder(CheckoutViewModel model)
        {
            var cartJson = HttpContext.Session.GetString("Cart");
            if (string.IsNullOrEmpty(cartJson))
                return RedirectToAction("Index");

            var productIds = JsonSerializer.Deserialize<List<int>>(cartJson)!;
            var cartItems = await _context.Products
                .Where(p => productIds.Contains(p.ProductId))
                .ToListAsync();

            // --- Loyalty & Voucher: Re-calculate discount server-side ---
            var currentUser = await _userManager.GetUserAsync(User);
            if (currentUser == null) return Unauthorized();

            decimal subtotal = cartItems.Sum(p => p.Price ?? 0);
            decimal loyaltyDiscount = _loyaltyService.GetTierDiscount(currentUser.Tier, subtotal);
            
            var voucherCode = HttpContext.Session.GetString("AppliedVoucher");
            Voucher? validVoucher = null;
            decimal totalDiscount = loyaltyDiscount;

            if (!string.IsNullOrEmpty(voucherCode))
            {
                var validationResult = await _voucherService.ValidateVoucherAsync(voucherCode, currentUser.Id, subtotal);
                if (validationResult.IsValid)
                {
                    validVoucher = validationResult.Voucher;
                    totalDiscount = await _voucherService.CalculateBestDiscountAsync(currentUser, subtotal, validVoucher);
                }
            }

            if (!ModelState.IsValid)
            {
                model.CartItems = cartItems;
                model.TotalAmount = Math.Max(0, subtotal - totalDiscount);
                model.DiscountAmount = loyaltyDiscount;
                model.VoucherCode = validVoucher?.Code;
                model.VoucherDiscount = validVoucher != null ? Math.Max(0, totalDiscount - loyaltyDiscount) : 0;
                model.Tier = currentUser.Tier;
                return View("Checkout", model);
            }

            // Lấy ID người dùng hiện tại
            var userIdClaim = User.FindFirst(ClaimTypes.NameIdentifier);
            if (userIdClaim == null) return Unauthorized();
            int userId = int.Parse(userIdClaim.Value);

            // Lấy InstallmentData từ session (nếu có)
            var installmentJson = HttpContext.Session.GetString("InstallmentData");
            InstallmentSessionData? installmentData = null;
            if (!string.IsNullOrEmpty(installmentJson))
            {
                installmentData = JsonSerializer.Deserialize<InstallmentSessionData>(installmentJson);
            }

            // Tạo đơn hàng mới
            var order = new Order
            {
                UserId = userId,
                OrderDate = DateTime.Now,
                TotalAmount = Math.Max(0, subtotal - totalDiscount) + (installmentData?.FeeAmount ?? 0),
                DiscountAmount = loyaltyDiscount, // Record base loyalty
                AppliedVoucherCode = validVoucher?.Code,
                Status = "Pending",
                ReceiverPhone = model.ReceiverPhone,
                ShippingAddress = model.ShippingAddress,

                // Gán thông tin trả góp nếu có
                PaymentMethod = installmentData != null ? "Trả góp" : "Tiền mặt",
                InstallmentMonths = installmentData?.Months ?? 0,
                PrepaymentAmount = installmentData?.PrepaymentAmount ?? 0,
                MonthlyInstallment = installmentData?.MonthlyInstallment ?? 0
            };

            _context.Orders.Add(order);
            await _context.SaveChangesAsync(); // Lưu để lấy OrderId

            // Tạo các dòng chi tiết đơn hàng
            foreach (var product in cartItems)
            {
                _context.OrderDetails.Add(new OrderDetail
                {
                    OrderId = order.OrderId,
                    ProductId = product.ProductId,
                    Quantity = 1,
                    UnitPrice = product.Price ?? 0
                });
            }

            // --- Tự động tạo lịch trả góp ---
            if (installmentData != null)
            {
                for (int i = 1; i <= installmentData.Months; i++)
                {
                    _context.InstallmentSchedules.Add(new InstallmentSchedule
                    {
                        OrderId = order.OrderId,
                        MonthNumber = i,
                        DueDate = DateTime.Now.AddMonths(i),
                        Amount = installmentData.MonthlyInstallment,
                        Status = "Unpaid"
                    });
                }
            }

            await _context.SaveChangesAsync();

            // Record Voucher Usage
            if (validVoucher != null)
            {
                await _voucherService.RecordVoucherUsageAsync(validVoucher.Id, currentUser.Id, order.OrderId);
            }

            // Xóa giỏ hàng và dữ liệu session sau khi đặt thành công
            HttpContext.Session.Remove("Cart");
            HttpContext.Session.Remove("InstallmentData");
            HttpContext.Session.Remove("AppliedVoucher");

            // Truyền OrderId qua TempData để trang Success hiển thị
            TempData["OrderId"] = order.OrderId;
            TempData["TotalAmount"] = order.TotalAmount.ToString("N0");

            return RedirectToAction("CheckoutSuccess");
        }

        // =============================================
        // 6. TRANG ĐẶT HÀNG THÀNH CÔNG
        // =============================================
        public IActionResult CheckoutSuccess()
        {
            return View();
        }

        // =============================================
        // 7. THIẾT LẬP TRẢ GÓP TỪ MODAL (POST)
        // =============================================
        [HttpPost]
        [Route("Cart/SetupInstallment")]
        public async Task<IActionResult> SetupInstallment([FromBody] SetupInstallmentRequest request)
        {
            if (request == null || request.ProductId <= 0)
                return BadRequest(new { message = "Dữ liệu không hợp lệ." });

            var product = await _context.Products.FindAsync(request.ProductId);
            if (product == null) return NotFound(new { message = "Không tìm thấy sản phẩm." });

            decimal price = product.Price ?? 0;
            decimal prepayAmount = price * (request.PrepaymentPercent / 100m);
            decimal loanAmount = price - prepayAmount;
            decimal feeAmount = loanAmount * 0.02m;
            decimal totalLoan = loanAmount + feeAmount;
            decimal monthlyInstallment = totalLoan / request.Months;

            var installmentData = new InstallmentSessionData {
                ProductId = request.ProductId,
                PrepaymentPercent = request.PrepaymentPercent,
                Months = request.Months,
                PrepaymentAmount = prepayAmount,
                MonthlyInstallment = monthlyInstallment,
                FeeAmount = feeAmount
            };

            HttpContext.Session.SetString("InstallmentData", JsonSerializer.Serialize(installmentData));

            // Set cart to only this item
            var cart = new List<int> { request.ProductId };
            HttpContext.Session.SetString("Cart", JsonSerializer.Serialize(cart));

            return Ok(new { message = "Thiết lập thành công." });
        }

        // =============================================
        // 8. API ÁP DỤNG & GỠ VOUCHER
        // =============================================
        [Authorize]
        [HttpPost]
        [Route("api/Cart/apply-voucher")]
        public async Task<IActionResult> ApplyVoucher([FromBody] string code)
        {
            var cartJson = HttpContext.Session.GetString("Cart");
            if (string.IsNullOrEmpty(cartJson))
                return BadRequest(new { message = "Giỏ hàng trống." });

            var productIds = JsonSerializer.Deserialize<List<int>>(cartJson)!;
            var cartItems = await _context.Products.Where(p => productIds.Contains(p.ProductId)).ToListAsync();
            decimal subtotal = cartItems.Sum(p => p.Price ?? 0);

            var user = await _userManager.GetUserAsync(User);
            if (user == null) return Unauthorized();

            var result = await _voucherService.ValidateVoucherAsync(code, user.Id, subtotal);
            
            if (result.IsValid && result.Voucher != null)
            {
                HttpContext.Session.SetString("AppliedVoucher", result.Voucher.Code);
                
                decimal loyaltyDiscount = _loyaltyService.GetTierDiscount(user.Tier, subtotal);
                decimal totalDiscount = await _voucherService.CalculateBestDiscountAsync(user, subtotal, result.Voucher);
                decimal voucherDiscount = Math.Max(0, totalDiscount - loyaltyDiscount);

                return Ok(new { 
                    success = true, 
                    message = result.Message,
                    voucherCode = result.Voucher.Code,
                    voucherDiscount = voucherDiscount,
                    totalDiscount = totalDiscount,
                    newTotal = Math.Max(0, subtotal - totalDiscount)
                });
            }

            return Ok(new { success = false, message = result.Message });
        }

        [Authorize]
        [HttpPost]
        [Route("api/Cart/remove-voucher")]
        public IActionResult RemoveVoucher()
        {
            HttpContext.Session.Remove("AppliedVoucher");
            return Ok(new { success = true, message = "Đã gỡ mã giảm giá." });
        }
    }

    public class AddToCartRequest
    {
        public int ProductId { get; set; }
        public int Quantity { get; set; } = 1;
    }

    public class SetupInstallmentRequest
    {
        public int ProductId { get; set; }
        public decimal PrepaymentPercent { get; set; }
        public int Months { get; set; }
    }

    public class InstallmentSessionData
    {
        public int ProductId { get; set; }
        public decimal PrepaymentPercent { get; set; }
        public int Months { get; set; }
        public decimal PrepaymentAmount { get; set; }
        public decimal MonthlyInstallment { get; set; }
        public decimal FeeAmount { get; set; }
    }
}
