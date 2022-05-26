using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text.Json.Serialization;

namespace ScentApi2.Model
{
    [Table("Cart")]
    public class Cart
    {
        [Key]
        public Guid IDCart { get; set; }
        public bool IsExpired { get; set; }
        public string IDAccount { get; set; }

        [JsonIgnore]
        public Account Account { get; set; }
        public System.Collections.Generic.List<ProductCart> ProductCarts { get; set; }
        public Invoice Invoices { get; set; }
    }
}
