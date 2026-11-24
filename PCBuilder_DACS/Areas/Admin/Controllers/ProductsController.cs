using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using PCBuilder_DACS.Models;
using PCBuilder_DACS.Models.ViewModels;
using System;
using System.IO;
using System.Linq;
using System.Threading.Tasks;

namespace PCBuilder_DACS.Areas.Admin.Controllers
{
    [Area("Admin")]
    [Authorize(Roles = "Admin")]
    public class ProductsController : Controller
    {
        private readonly PcBuilderContext _context;

        public ProductsController(PcBuilderContext context)
        {
            _context = context;
        }

        // GET: Admin/Products
        public async Task<IActionResult> Index()
        {
            var products = await _context.Products
                .Include(p => p.Category)
                .OrderByDescending(p => p.ProductId)
                .ToListAsync();
            return View(products);
        }

        // GET: Admin/Products/Create
        public IActionResult Create()
        {
            ViewBag.Categories = new SelectList(_context.Categories, "CategoryId", "CategoryName");
            return View(new ProductFormViewModel());
        }

        // POST: Admin/Products/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create(ProductFormViewModel model, IFormFile? imageFile)
        {
            if (!ModelState.IsValid)
            {
                ViewBag.Categories = new SelectList(_context.Categories, "CategoryId", "CategoryName");
                return View(model);
            }

            // Xử lý upload hình ảnh
            string? imagePath = null;
            if (imageFile != null && imageFile.Length > 0)
            {
                string fileName = Guid.NewGuid().ToString() + Path.GetExtension(imageFile.FileName);
                string uploadPath = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot", "images");

                if (!Directory.Exists(uploadPath))
                    Directory.CreateDirectory(uploadPath);

                string filePath = Path.Combine(uploadPath, fileName);
                using (var stream = new FileStream(filePath, FileMode.Create))
                {
                    await imageFile.CopyToAsync(stream);
                }
                imagePath = "/images/" + fileName;
            }

            var product = new Product
            {
                ProductName = model.ProductName,
                Brand       = model.Brand,
                Price       = model.Price,
                CategoryId  = model.CategoryId,
                ImagePath   = imagePath,
                CreatedAt   = DateTime.Now,
                IsActive    = true
            };

            _context.Products.Add(product);
            await _context.SaveChangesAsync();

            TempData["Success"] = $"Đã thêm linh kiện \"{product.ProductName}\" thành công!";
            return RedirectToAction(nameof(Index));
        }

        // GET: Admin/Products/Edit/5
        public async Task<IActionResult> Edit(int id)
        {
            var product = await _context.Products.FindAsync(id);
            if (product == null) return NotFound();

            var model = new ProductFormViewModel
            {
                ProductId   = product.ProductId,
                ProductName = product.ProductName,
                Brand       = product.Brand,
                Price       = product.Price,
                CategoryId  = product.CategoryId,
                ImagePath   = product.ImagePath
            };

            ViewBag.Categories = new SelectList(_context.Categories, "CategoryId", "CategoryName", product.CategoryId);
            return View(model);
        }

        // POST: Admin/Products/Edit/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, ProductFormViewModel model, IFormFile? imageFile)
        {
            if (id != model.ProductId) return NotFound();

            if (!ModelState.IsValid)
            {
                ViewBag.Categories = new SelectList(_context.Categories, "CategoryId", "CategoryName", model.CategoryId);
                return View(model);
            }

            var product = await _context.Products.FindAsync(id);
            if (product == null) return NotFound();

            // Xử lý upload hình ảnh mới (nếu có)
            if (imageFile != null && imageFile.Length > 0)
            {
                string fileName = Guid.NewGuid().ToString() + Path.GetExtension(imageFile.FileName);
                string uploadPath = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot", "images");

                if (!Directory.Exists(uploadPath))
                    Directory.CreateDirectory(uploadPath);

                string filePath = Path.Combine(uploadPath, fileName);
                using (var stream = new FileStream(filePath, FileMode.Create))
                {
                    await imageFile.CopyToAsync(stream);
                }
                product.ImagePath = "/images/" + fileName;
            }

            product.ProductName = model.ProductName;
            product.Brand       = model.Brand;
            product.Price       = model.Price;
            product.CategoryId  = model.CategoryId;

            await _context.SaveChangesAsync();

            TempData["Success"] = $"Đã cập nhật linh kiện \"{product.ProductName}\" thành công!";
            return RedirectToAction(nameof(Index));
        }

        // POST: Admin/Products/Delete/5 (Soft Delete)
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Delete(int id)
        {
            var product = await _context.Products.FindAsync(id);
            if (product == null) return NotFound();

            product.IsActive = false;
            await _context.SaveChangesAsync();

            TempData["Warning"] = $"Đã ẩn linh kiện \"{product.ProductName}\" khỏi cửa hàng.";
            return RedirectToAction(nameof(Index));
        }

        // POST: Admin/Products/Restore/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Restore(int id)
        {
            var product = await _context.Products.FindAsync(id);
            if (product == null) return NotFound();

            product.IsActive = true;
            await _context.SaveChangesAsync();

            TempData["Success"] = $"Đã khôi phục linh kiện \"{product.ProductName}\"!";
            return RedirectToAction(nameof(Index));
        }
    }
}
