using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace PCBuilder_DACS.Models
{
    public enum DiscountType
    {
        Percentage,
        FixedAmount
    }

    public class Voucher
    {
        [Key]
        public int Id { get; set; }

        [Required(ErrorMessage = "Mã giảm giá không được để trống")]
        [StringLength(50)]
        public string Code { get; set; }

        [StringLength(255)]
        public string? Description { get; set; }

        [Required]
        public DiscountType DiscountType { get; set; }

        [Required(ErrorMessage = "Giá trị giảm không được để trống")]
        [Column(TypeName = "decimal(18, 2)")]
        [Range(0, double.MaxValue, ErrorMessage = "Giá trị giảm phải lớn hơn 0")]
        public decimal DiscountValue { get; set; }

        [Column(TypeName = "decimal(18, 2)")]
        public decimal MinSpend { get; set; } = 0;

        [Column(TypeName = "decimal(18, 2)")]
        public decimal? MaxDiscount { get; set; } // Only applies to Percentage type

        [Required]
        public DateTime StartDate { get; set; }

        [Required]
        public DateTime EndDate { get; set; }

        [Range(0, int.MaxValue)]
        public int UsageLimit { get; set; } = 0; // 0 means unlimited

        [Range(0, int.MaxValue)]
        public int UsageCount { get; set; } = 0;

        [Range(1, int.MaxValue)]
        public int UsageLimitPerUser { get; set; } = 1; // Prevent abuse

        public bool IsStackableWithMembership { get; set; } = false; // Prevent unwanted stacking

        public bool IsActive { get; set; } = true;

        public bool IsValid()
        {
            var now = DateTime.Now;
            return IsActive && StartDate <= now && EndDate >= now && (UsageLimit == 0 || UsageCount < UsageLimit);
        }
    }
}
