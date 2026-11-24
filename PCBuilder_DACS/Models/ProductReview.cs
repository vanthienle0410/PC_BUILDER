using System;
using System.ComponentModel.DataAnnotations;

namespace PCBuilder_DACS.Models
{
    public class ProductReview
    {
        [Key]
        public int ReviewId { get; set; }

        public int? ProductId { get; set; }

        public int? UserId { get; set; }

        [Range(1, 5)]
        public int? Rating { get; set; }

        public string? Content { get; set; }

        public string? Sentiment { get; set; }

        public DateTime? CreatedAt { get; set; }

        public bool IsHidden { get; set; } = false;

        public virtual Product? Product { get; set; }
        public virtual ApplicationUser? User { get; set; }
    }
}
