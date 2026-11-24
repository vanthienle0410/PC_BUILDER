using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema; // Thư viện bắt buộc để dùng [NotMapped]

namespace PCBuilder_DACS.Models;

public partial class Product
{
    public int ProductId { get; set; }

    public string ProductName { get; set; } = null!;

    public string? Brand { get; set; }

    public decimal? Price { get; set; }

    public string? ImagePath { get; set; }

    public int? CategoryId { get; set; }

    public DateTime? CreatedAt { get; set; }

    public bool IsHiddenFromRecommendation { get; set; } = false;

    // Soft Delete: Admin ẩn sản phẩm thay vì xóa cứng
    public bool IsActive { get; set; } = true;

    // ==========================================
    // THUỘC TÍNH MỚI: Dùng để lưu điểm AI (Không lưu vào SQL)
    // ==========================================
    [NotMapped]
    public float Score { get; set; }

    public virtual Category? Category { get; set; }

    public virtual CpuSpec? CpuSpec { get; set; }

    public virtual GpuSpec? GpuSpec { get; set; }

    public virtual MainboardSpec? MainboardSpec { get; set; }

    public virtual RamSpec? RamSpec { get; set; }

    public virtual ICollection<UserInteraction> UserInteractions { get; set; } = new List<UserInteraction>();
}