using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text.Json.Serialization;

namespace ScentApi2.Model
{
    [Table("Category")]
    public class Category
    {
        [Key]
        public int IdCategory { get; set; }
        public string CategoryName { get; set; }
        public bool IsDelete { get; set; }

        [JsonIgnore]
        public List<Product> Products { get; set; }
    }
}
