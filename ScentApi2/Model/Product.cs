using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text.Json.Serialization;

namespace ScentApi2.Model
{
    [Table("Product")]
    public class Product
    {
        [Key]
        public int IdProduct { get; set; }
        public int IdCategory { get; set; }
        public string Name { get; set; }
        public int? Price { get; set; }
        public int? Stock { get; set; }
        public string ImageUrl { get; set; }
        public bool? IsDelete { get; set; }
        public string Description { get; set; }
        public string ShortDescription { get; set; }

        
        public Category Category { get; set; }
        [JsonIgnore]

        public List<ProductCart> ProductCarts { get; set; }
    }
}
