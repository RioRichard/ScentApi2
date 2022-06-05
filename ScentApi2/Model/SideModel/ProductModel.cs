using Microsoft.AspNetCore.Http;

namespace ScentApi2.Model.SideModel
{
    public class ProductModel
    {

        public int IdCategory { get; set; }
        public string Name { get; set; }
        public int? Price { get; set; }
        public int? Stock { get; set; }

        public string ImageUrl { get; set; }
        public bool? IsDelete { get; set; }
        public string Description { get; set; }
        public string ShortDescription { get; set; }
    }
}
