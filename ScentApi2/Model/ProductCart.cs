using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text.Json.Serialization;

namespace ScentApi2.Model
{
    [Table("ProductCart")]
    public class ProductCart
    {

        public Guid IDCart { get; set; }

        public int IDProduct { get; set; }
        public int Quantity { get; set; }
        public int PaymentPrice { get; set; }
        [JsonIgnore]
        public Cart Cart { get; set; }
        [JsonIgnore]

        public Product Product { get; set; }
    }
}
