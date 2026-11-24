using System.ComponentModel.DataAnnotations;

namespace PCBuilder_DACS.Models.ViewModels
{
    public class ProductFormViewModel
    {
        public int ProductId { get; set; }

        [Required(ErrorMessage = "Tên linh kiện không được để trống")]
        [MaxLength(255)]
        public string ProductName { get; set; } = string.Empty;

        [MaxLength(100)]
        public string? Brand { get; set; }

        [Range(0, double.MaxValue, ErrorMessage = "Giá phải là số dương")]
        public decimal? Price { get; set; }

        public string? ImagePath { get; set; }

        public int? CategoryId { get; set; }
    }
}
