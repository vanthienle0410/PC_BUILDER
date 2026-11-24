using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using PCBuilder_DACS.Models;
using PCBuilder_DACS.Models.ViewModels;
using System.Linq;

namespace PCBuilder_DACS.Controllers
{
    public class HomeController : Controller
    {
        private readonly PcBuilderContext _context;

        public HomeController(PcBuilderContext context)
        {
            _context = context;
        }

        public IActionResult Index()
        {
            // Resolve category IDs by name — safe after seeding new data
            var categories = _context.Categories.ToList();
            int catIdOf(string name) => categories.FirstOrDefault(c => c.CategoryName == name)?.CategoryId ?? -1;

            int cpuId  = catIdOf("CPU");
            int gpuId  = catIdOf("GPU");
            int ramId  = catIdOf("RAM");
            int mainId = catIdOf("Mainboard");

            var viewModel = new HomeViewModel
            {
                LatestProducts = _context.Products
                    .Where(p => p.IsActive)
                    .OrderByDescending(p => p.ProductId)
                    .Take(12)
                    .ToList(),

                TopCPUs = _context.Products
                    .Where(p => p.IsActive && p.CategoryId == cpuId)
                    .OrderByDescending(p => p.ProductId)
                    .Take(4)
                    .ToList(),

                TopVGAs = _context.Products
                    .Where(p => p.IsActive && p.CategoryId == gpuId)
                    .OrderByDescending(p => p.ProductId)
                    .Take(4)
                    .ToList(),

                TopRAMs = _context.Products
                    .Where(p => p.IsActive && p.CategoryId == ramId)
                    .OrderByDescending(p => p.ProductId)
                    .Take(4)
                    .ToList(),

                TopMainboards = _context.Products
                    .Where(p => p.IsActive && p.CategoryId == mainId)
                    .OrderByDescending(p => p.ProductId)
                    .Take(4)
                    .ToList(),
            };

            return View(viewModel);
        }

        public IActionResult BuildPC()
        {
            return View();
        }
    }
}