namespace PCBuilder_DACS.Models;

public partial class UserInteraction
{
    public int InteractionId { get; set; }
    public int? UserId { get; set; }
    public int? ProductId { get; set; }
    public string? InteractionType { get; set; }

    // ĐỔI TÊN Ở ĐÂY: Phải là InteractionDate mới đúng với DB của Bạn
    public DateTime? InteractionDate { get; set; }

    // THÊM DÒNG NÀY: Kiểu float tương ứng với 'real' trong SQL
    public float? Rating { get; set; }

    public virtual Product? Product { get; set; }
    public virtual ApplicationUser? User { get; set; }
}