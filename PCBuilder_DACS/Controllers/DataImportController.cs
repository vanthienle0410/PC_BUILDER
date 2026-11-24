using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using PCBuilder_DACS.Models;
using System.Text.Json;
using System.Text.Json.Serialization;

namespace PCBuilder_DACS.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class DataImportController : ControllerBase
    {
        private readonly PcBuilderContext _context;
        private readonly IWebHostEnvironment _env;

        public DataImportController(PcBuilderContext context, IWebHostEnvironment env)
        {
            _context = context;
            _env = env;
        }

        // DTO khớp đúng với cấu trúc JSON trong thư mục tailieu
        // (field tên tiếng Việt: Ten, Gia, LinkAnh)
        public class TailieuProductJson
        {
            [JsonPropertyName("ID")]
            public string? ID { get; set; }

            [JsonPropertyName("Ten")]
            public string? Ten { get; set; }

            [JsonPropertyName("Gia")]
            public string? Gia { get; set; }

            [JsonPropertyName("LinkAnh")]
            public string? LinkAnh { get; set; }
        }

        [HttpPost("import")]
        public async Task<IActionResult> ImportData()
        {
            string tailieuPath = Path.Combine(_env.ContentRootPath, "..", "tailieu");
            if (!Directory.Exists(tailieuPath))
            {
                return NotFound($"Thư mục {tailieuPath} không tồn tại.");
            }

            // --- Đảm bảo các category cần thiết đã tồn tại ---
            await EnsureCategoryExists("Storage");
            await EnsureCategoryExists("PC & Laptop");
            await EnsureCategoryExists("Gaming Gear");
            await _context.SaveChangesAsync();

            // --- Lấy CategoryId từ tên ---
            int storageId   = await GetCategoryId("Storage");
            int pcLaptopId  = await GetCategoryId("PC & Laptop");
            int gearId      = await GetCategoryId("Gaming Gear");

            // --- Ánh xạ file JSON → CategoryId ---
            var categoryMap = new Dictionary<string, int>
            {
                { "ocung.json",      storageId  },  // Ổ cứng SSD/HDD
                { "pc_maytinh.json", pcLaptopId },  // PC và Laptop
                { "gamegear.json",   gearId     },  // Chuột, bàn phím, tai nghe
            };

            var skipKeywords = new[]
            {
                "Dây nguồn", "Cáp", "Box", "Hộp đựng", "Khay", "Bao",
                "Demo", "Trưng bày", "Ổ cắm", "USB Hub"
            };

            var existingNames = await _context.Products
                .Select(p => p.ProductName)
                .ToListAsync();

            var addedNames    = new List<string>();
            int importedCount = 0;

            var jsonOptions = new JsonSerializerOptions { PropertyNameCaseInsensitive = true };

            foreach (var (fileName, categoryId) in categoryMap)
            {
                string filePath = Path.Combine(tailieuPath, fileName);
                if (!System.IO.File.Exists(filePath))
                {
                    continue;
                }

                string jsonContent = await System.IO.File.ReadAllTextAsync(filePath);
                var items = JsonSerializer.Deserialize<List<TailieuProductJson>>(jsonContent, jsonOptions);

                if (items == null) continue;

                foreach (var item in items)
                {
                    string? name  = item.Ten?.Trim();
                    string? image = item.LinkAnh?.Trim();

                    if (string.IsNullOrWhiteSpace(name)) continue;

                    // Bỏ qua phụ kiện, demo...
                    if (skipKeywords.Any(k => name.Contains(k, StringComparison.OrdinalIgnoreCase)))
                        continue;

                    // Bỏ qua trùng lặp
                    if (existingNames.Contains(name, StringComparer.OrdinalIgnoreCase) ||
                        addedNames.Contains(name, StringComparer.OrdinalIgnoreCase))
                        continue;

                    string  brand = ExtractBrand(name);
                    decimal price = EstimatePrice(name, categoryId, pcLaptopId, storageId, gearId);

                    _context.Products.Add(new Product
                    {
                        ProductName = name,
                        Brand       = brand,
                        Price       = price,
                        ImagePath   = image,
                        CategoryId  = categoryId,
                        CreatedAt   = DateTime.Now,
                        IsActive    = true
                    });

                    addedNames.Add(name);
                    importedCount++;
                }
            }

            await _context.SaveChangesAsync();

            return Ok(new
            {
                Message  = $"Đã import thành công {importedCount} sản phẩm.",
                Imported = importedCount
            });
        }

        // ---------------------------------------------------------------
        // Helpers
        // ---------------------------------------------------------------

        private async Task EnsureCategoryExists(string name)
        {
            if (!await _context.Categories.AnyAsync(c => c.CategoryName == name))
            {
                _context.Categories.Add(new Category { CategoryName = name });
            }
        }

        private async Task<int> GetCategoryId(string name)
        {
            var cat = await _context.Categories.FirstOrDefaultAsync(c => c.CategoryName == name);
            return cat?.CategoryId ?? 0;
        }

        private string ExtractBrand(string name)
        {
            var knownBrands = new[]
            {
                "Asus", "Gigabyte", "MSI", "Corsair", "Kingston", "Samsung",
                "Western Digital", "WD", "Seagate", "Cooler Master", "NZXT",
                "Deepcool", "Thermalright", "AOC", "Dell", "LG", "Lenovo",
                "HP", "Acer", "Xigmatek", "Mik", "Jetek", "AcBel", "FSP",
                "Antec", "Razer", "Logitech", "SteelSeries", "HyperX",
                "ASUS ROG", "ROG", "DAREU", "AULA", "AKKO", "Keychron",
                "Newmen", "E-Dra", "Sony", "Jabra", "Bose", "MCHOSE",
                "ATK", "ZOWIE", "Fuhlen", "Patriot"
            };

            foreach (var brand in knownBrands)
            {
                if (name.Contains(brand, StringComparison.OrdinalIgnoreCase))
                {
                    if (brand.Equals("WD", StringComparison.OrdinalIgnoreCase)) return "Western Digital";
                    return brand;
                }
            }

            // Fallback: từ đầu tiên có nghĩa
            var parts = name.Split(' ', StringSplitOptions.RemoveEmptyEntries);
            return parts.Length > 0 ? parts[0] : "Unknown";
        }

        private decimal EstimatePrice(string name, int categoryId,
                                       int pcLaptopId, int storageId, int gearId)
        {
            string n = name.ToLower();

            // --- PC & Laptop ---
            if (categoryId == pcLaptopId)
            {
                // PC Gaming cao cấp
                if (n.Contains("rtx 5090") || n.Contains("rtx 5080")) return 80_000_000;
                if (n.Contains("rtx 5070") || n.Contains("rtx 4090")) return 60_000_000;
                if (n.Contains("rtx 5060 ti") || n.Contains("rtx 5060"))  return 40_000_000;
                if (n.Contains("rtx 3060") || n.Contains("rtx 4060"))     return 28_000_000;
                if (n.Contains("rtx 3050") || n.Contains("rtx 5050"))     return 22_000_000;
                // CPU cao cấp
                if (n.Contains("ultra 7") || n.Contains("i9") || n.Contains("ryzen 9")) return 35_000_000;
                if (n.Contains("ultra 5") || n.Contains("i7") || n.Contains("ryzen 7")) return 22_000_000;
                if (n.Contains("i5") || n.Contains("ryzen 5"))  return 14_000_000;
                if (n.Contains("i3") || n.Contains("ryzen 3"))  return 9_000_000;
                return 12_000_000;
            }

            // --- Storage ---
            if (categoryId == storageId)
            {
                if (n.Contains("8tb"))                                return 7_000_000;
                if (n.Contains("4tb"))                                return 4_500_000;
                if (n.Contains("2tb"))                                return 3_000_000;
                if (n.Contains("1tb") || n.Contains("1000gb"))       return 1_800_000;
                if (n.Contains("512gb") || n.Contains("500gb"))      return 1_100_000;
                if (n.Contains("256gb") || n.Contains("250gb"))      return 650_000;
                if (n.Contains("128gb"))                              return 450_000;
                return 1_000_000;
            }

            // --- Gaming Gear ---
            if (categoryId == gearId)
            {
                // Chuột
                if (n.Contains("chuột") || n.Contains("mouse"))
                {
                    if (n.Contains("razer viper v3 pro") || n.Contains("razer pro click v2"))  return 4_500_000;
                    if (n.Contains("razer") || n.Contains("logitech pro x superlight"))         return 3_200_000;
                    if (n.Contains("logitech") || n.Contains("asus rog") || n.Contains("corsair")) return 1_500_000;
                    if (n.Contains("gaming"))                                                    return 700_000;
                    return 350_000;
                }

                // Bàn phím
                if (n.Contains("bàn phím") || n.Contains("keyboard"))
                {
                    if (n.Contains("razer") || n.Contains("keychron") || n.Contains("corsair") || n.Contains("logitech g915")) return 3_500_000;
                    if (n.Contains("logitech") || n.Contains("asus rog") || n.Contains("akko"))  return 2_000_000;
                    if (n.Contains("aula") || n.Contains("dareu") || n.Contains("e-dra"))         return 800_000;
                    return 500_000;
                }

                // Tai nghe
                if (n.Contains("tai nghe") || n.Contains("headset") || n.Contains("headphone"))
                {
                    if (n.Contains("sony") || n.Contains("jabra") || n.Contains("bose")) return 3_000_000;
                    if (n.Contains("razer") || n.Contains("corsair") || n.Contains("logitech")) return 2_000_000;
                    return 700_000;
                }

                // Tay cầm
                if (n.Contains("tay cầm") || n.Contains("gamepad") || n.Contains("controller")) return 1_200_000;

                return 500_000;
            }

            // Fallback
            return new Random().Next(5, 30) * 100_000;
        }
    }
}
