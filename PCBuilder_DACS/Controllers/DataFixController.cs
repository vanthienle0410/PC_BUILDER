using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using PCBuilder_DACS.Models;
using System.Text;

namespace PCBuilder_DACS.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    // TODO: Sau khi fix xong, xóa controller này hoặc thêm lại [Authorize(Roles = "Admin")]
    [AllowAnonymous]
    public class DataFixController : ControllerBase
    {
        private readonly PcBuilderContext _context;

        public DataFixController(PcBuilderContext context)
        {
            _context = context;
        }

        /// <summary>
        /// Sửa lỗi encoding tiếng Việt trong database (chạy 1 lần duy nhất).
        /// Dữ liệu bị double-encoded: UTF-8 bytes → CP1252 chars → nvarchar.
        /// Fix: đọc từng char → lấy byte CP1252 → decode lại thành UTF-8.
        /// </summary>
        [HttpPost("fix-encoding")]
        public async Task<IActionResult> FixEncoding()
        {
            var products = await _context.Products.ToListAsync();
            int fixedCount = 0;
            var details = new List<string>();

            foreach (var product in products)
            {
                bool changed = false;

                // Fix ProductName
                string fixedName = TryFixMojibake(product.ProductName);
                if (fixedName != product.ProductName)
                {
                    details.Add($"[ID={product.ProductId}] \"{product.ProductName}\" → \"{fixedName}\"");
                    product.ProductName = fixedName;
                    changed = true;
                }

                // Fix Brand
                if (!string.IsNullOrEmpty(product.Brand))
                {
                    string fixedBrand = TryFixMojibake(product.Brand);
                    if (fixedBrand != product.Brand)
                    {
                        product.Brand = fixedBrand;
                        changed = true;
                    }
                }

                if (changed) fixedCount++;
            }

            await _context.SaveChangesAsync();

            return Ok(new
            {
                message = $"Đã sửa encoding cho {fixedCount}/{products.Count} sản phẩm.",
                fixedCount,
                totalProducts = products.Count,
                changes = details
            });
        }

        /// <summary>
        /// Chuyển đổi chuỗi bị mojibake (UTF-8 lưu thành CP1252) về đúng UTF-8.
        /// Nếu chuỗi không bị mojibake, trả về nguyên bản.
        /// </summary>
        private static string TryFixMojibake(string input)
        {
            if (string.IsNullOrEmpty(input)) return input;

            try
            {
                // Bước 1: Chuyển mỗi ký tự Unicode thành byte CP1252 tương ứng
                Encoding cp1252 = Encoding.GetEncoding(1252);
                byte[] bytes = cp1252.GetBytes(input);

                // Bước 2: Đọc lại mảng bytes đó dưới dạng UTF-8
                string decoded = Encoding.UTF8.GetString(bytes);

                // Bước 3: Kiểm tra kết quả có hợp lệ không
                // Nếu chuỗi gốc chỉ có ASCII thuần thì kết quả giống nhau → bỏ qua
                if (decoded == input) return input;

                // Nếu chuỗi mới chứa ký tự thay thế (�) thì dữ liệu gốc không phải mojibake
                if (decoded.Contains('\uFFFD')) return input;

                return decoded;
            }
            catch
            {
                // Nếu có lỗi, trả về nguyên bản
                return input;
            }
        }

        /// <summary>
        /// Đổi tên category cho đúng với tên hiển thị trong mega menu.
        /// Chạy 1 lần duy nhất sau khi import dữ liệu.
        /// </summary>
        [HttpPost("rename-categories")]
        public async Task<IActionResult> RenameCategories()
        {
            var renames = new Dictionary<string, string>
            {
                { "PC & Laptop", "PC - Máy tính bàn" }
            };

            var changed = new List<string>();
            foreach (var (oldName, newName) in renames)
            {
                var cat = await _context.Categories.FirstOrDefaultAsync(c => c.CategoryName == oldName);
                if (cat != null)
                {
                    cat.CategoryName = newName;
                    changed.Add($"{oldName} → {newName}");
                }
            }

            await _context.SaveChangesAsync();
            return Ok(new { Message = "Đã đổi tên category.", Changes = changed });
        }
    }
}
