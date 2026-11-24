using System.ComponentModel.DataAnnotations;

namespace PCBuilder_DACS.Models.ViewModels
{
    public class CheckoutViewModel
    {
        [Required(ErrorMessage = "Vui lòng nhập số điện thoại")]
        [Phone(ErrorMessage = "Số điện thoại không hợp lệ")]
        [Display(Name = "Số điện thoại nhận hàng")]
        public string ReceiverPhone { get; set; } = string.Empty;

        [Required(ErrorMessage = "Vui lòng nhập địa chỉ giao hàng")]
        [MinLength(10, ErrorMessage = "Địa chỉ phải có ít nhất 10 ký tự")]
        [Display(Name = "Địa chỉ giao hàng")]
        public string ShippingAddress { get; set; } = string.Empty;

        // Thông tin giỏ hàng để hiển thị preview trước khi đặt
        public List<Product> CartItems { get; set; } = new();
        public decimal TotalAmount { get; set; }

        // --- Loyalty System ---
        public decimal DiscountAmount { get; set; } = 0;
        public MembershipTier Tier { get; set; } = MembershipTier.Bronze;

        // --- Voucher System ---
        public string? VoucherCode { get; set; }
        public decimal VoucherDiscount { get; set; } = 0;
        public string? VoucherMessage { get; set; }

        // --- Installment fields ---
        public string PaymentMethod { get; set; } = "Tiền mặt";
        public int InstallmentMonths { get; set; } = 0;
        public decimal PrepaymentAmount { get; set; } = 0;
        public decimal MonthlyInstallment { get; set; } = 0;
    }
}
