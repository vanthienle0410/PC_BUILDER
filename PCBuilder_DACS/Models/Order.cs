using System;
using System.Collections.Generic;

namespace PCBuilder_DACS.Models
{
    public class Order
    {
        public int OrderId { get; set; }
        public int UserId { get; set; }
        public DateTime OrderDate { get; set; }
        public decimal TotalAmount { get; set; }

        // --- Loyalty System ---
        public decimal DiscountAmount { get; set; } = 0;
        public bool IsPointsAwarded { get; set; } = false;

        // --- Voucher System ---
        public string? AppliedVoucherCode { get; set; }


        // Pending, Shipping, Completed, Cancelled
        public string Status { get; set; } = "Pending";

        // Thông tin giao hàng (Phương án B)
        public string? ReceiverPhone { get; set; }
        public string? ShippingAddress { get; set; }

        // --- Installment fields ---
        public string PaymentMethod { get; set; } = "Tiền mặt";
        public int InstallmentMonths { get; set; } = 0; // 0 means no installment
        public decimal PrepaymentAmount { get; set; } = 0;
        public decimal MonthlyInstallment { get; set; } = 0;

        public virtual ApplicationUser User { get; set; }
        public virtual ICollection<OrderDetail> OrderDetails { get; set; } = new List<OrderDetail>();
        public virtual ICollection<InstallmentSchedule> InstallmentSchedules { get; set; } = new List<InstallmentSchedule>();
    }
}
