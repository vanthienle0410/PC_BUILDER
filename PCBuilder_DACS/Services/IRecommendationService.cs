using System.Collections.Generic;
using System.Threading.Tasks;
using PCBuilder_DACS.Models;

namespace PCBuilder_DACS.Services
{
    public interface IRecommendationService
    {
        // Các hàm cũ của Bạn (Giữ nguyên)
        Task TrainModelAsync();
        IEnumerable<Product> GetRecommendations(int userId, int count = 5);

        // ==========================================
        // HÀM MỚI THÊM: Để Controller có thể lấy điểm AI lọc tương thích
        // ==========================================
        ProductPrediction GetPrediction(int userId, int productId);
    }
}