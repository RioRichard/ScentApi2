using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace ScentApi2.Model
{
    public class ProductCart
    {
        [Key]
        [Column(Order = 0)]
        public Guid IDCart { get; set; }
        [Key]
        [Column(Order = 1)]
        public int IDProduct { get; set; }
        public int Quantity { get; set; }
        public int PaymentPrice { get; set; }

        public Cart Cart { get; set; }
        public Product Product { get; set; }
    }
}
