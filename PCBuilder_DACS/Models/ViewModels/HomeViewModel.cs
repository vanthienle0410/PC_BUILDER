using System.Collections.Generic;
using PCBuilder_DACS.Models;

namespace PCBuilder_DACS.Models.ViewModels
{
    public class HomeViewModel
    {
        public List<Product> LatestProducts { get; set; } = new List<Product>();
        public List<Product> TopCPUs { get; set; } = new List<Product>();
        public List<Product> TopVGAs { get; set; } = new List<Product>();
        public List<Product> TopRAMs { get; set; } = new List<Product>();
        public List<Product> TopMainboards { get; set; } = new List<Product>();
    }
}
