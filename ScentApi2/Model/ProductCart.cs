using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace ScentApi2.Model
{
    [Table("ProductCart")]
    public class ProductCart
    {

        public Guid IDCart { get; set; }

        public int IDProduct { get; set; }
        public int Quantity { get; set; }
        public int PaymentPrice { get; set; }

        public Cart Cart { get; set; }
        public Product Product { get; set; }
    }
}
