using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using PCBuilder_DACS.Models;
using PCBuilder_DACS.Services;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace PCBuilder_DACS.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class RecommendationsController : ControllerBase
    {
        private readonly IRecommendationService _recommendationService;
        private readonly PcBuilderContext _context;

        public RecommendationsController(IRecommendationService recommendationService, PcBuilderContext context)
        {
            _recommendationService = recommendationService;
            _context = context;
        }

        [HttpPost("train")]
        public async Task<IActionResult> TrainModel()
        {
            try
            {
                await _recommendationService.TrainModelAsync();
                return Ok("Huấn luyện thành công.");
            }
            catch (System.Exception ex)
            {
                return StatusCode(500, ex.Message);
            }
        }

        [HttpGet("user/{userId}")]
        public ActionResult<IEnumerable<Product>> GetAiRecommendations(int userId)
        {
            var results = _recommendationService.GetRecommendations(userId);
            return Ok(results);
        }

        // =========================================================
        // API TÍCH HỢP 2 TRONG 1: LỌC TƯƠNG THÍCH VÀ CHẤM ĐIỂM AI
        // =========================================================
        [HttpGet("suggest-mainboard/{cpuId}")]
        public async Task<IActionResult> SuggestMainboardForCpu(int cpuId)
        {
            // 1. Tìm thông tin CPU theo ID
            var cpu = await _context.Products.Include(p => p.CpuSpec)
                .FirstOrDefaultAsync(p => p.ProductId == cpuId);

            if (cpu?.CpuSpec == null) return NotFound("CPU không hợp lệ hoặc thiếu thông số Socket.");

            // Lấy loại Socket của CPU (Sử dụng đúng tên SocketType trong DB của Bạn)
            string targetSocket = cpu.CpuSpec.SocketType!;

            // 2. Lấy danh sách Mainboard có cùng SocketType
            var compatibleMainboards = await _context.Products
                .Include(p => p.MainboardSpec)
                .Where(p => p.IsActive && p.CategoryId == 2 && p.MainboardSpec != null && p.MainboardSpec.SocketType == targetSocket)
                .ToListAsync();

            // 3. Gọi AI chấm điểm cho từng Mainboard tương thích
            int currentUserId = 0;
            if (User.Identity != null && User.Identity.IsAuthenticated)
            {
                var userIdClaim = User.FindFirst(System.Security.Claims.ClaimTypes.NameIdentifier);
                if (userIdClaim != null) int.TryParse(userIdClaim.Value, out currentUserId);
            }

            foreach (var product in compatibleMainboards)
            {
                if (currentUserId > 0)
                {
                    var prediction = _recommendationService.GetPrediction(currentUserId, product.ProductId);
                    product.Score = prediction.Score; // Gán điểm AI vào Model
                }
                else
                {
                    product.Score = 0;
                }
            }

            // 4. Trả về danh sách đã được sắp xếp (AI đánh giá cao nhất sẽ nằm trên cùng)
            return Ok(compatibleMainboards.OrderByDescending(p => p.Score));
        }

        // =========================================================
        // API LỌC RAM (Giữ nguyên của Bạn vì đã chuẩn rồi)
        // =========================================================
        [HttpGet("suggest-ram/{mainboardId}")]
        public async Task<IActionResult> SuggestRamForMainboard(int mainboardId)
        {
            var mb = await _context.Products.Include(p => p.MainboardSpec)
                .FirstOrDefaultAsync(p => p.ProductId == mainboardId);

            if (mb?.MainboardSpec == null) return NotFound("Mainboard không hợp lệ.");

            string ramType = mb.MainboardSpec.RamTypeSupported!;

            var compatibleRams = await _context.Products.Include(p => p.RamSpec)
                .Where(p => p.IsActive && p.CategoryId == 3 && p.RamSpec != null && p.RamSpec.RamType == ramType)
                .Select(p => new {
                    Id = p.ProductId,
                    Name = p.ProductName,
                    Price = p.Price,
                    ImagePath = p.ImagePath,
                    Capacity = p.RamSpec!.Capacity
                })
                .ToListAsync();

            return Ok(compatibleRams);
        }
    }
}