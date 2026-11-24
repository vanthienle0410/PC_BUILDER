using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace PCBuilder_DACS.Models
{
    public class VoucherUsage
    {
        [Key]
        public int Id { get; set; }

        [Required]
        public int VoucherId { get; set; }

        [Required]
        public int UserId { get; set; }

        public int? OrderId { get; set; } // Nullable because it might be tied to an order that hasn't been placed yet during checkout validation, though typically saved on order placement.

        [Required]
        public DateTime UsedAt { get; set; } = DateTime.Now;

        [ForeignKey("VoucherId")]
        public virtual Voucher Voucher { get; set; }

        [ForeignKey("UserId")]
        public virtual ApplicationUser User { get; set; }

        [ForeignKey("OrderId")]
        public virtual Order? Order { get; set; }
    }
}
