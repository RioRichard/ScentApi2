using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text.Json.Serialization;

namespace ScentApi2.Model
{
    [Table("Invoice")]
    public class Invoice
    {
        [Key]
        public System.Guid IDInvoice { get; set; }
        public DateTime? DateCreated{ get; set; }
        public DateTime? DateExpired { get; set; }
        public Guid IDCart { get; set; }
        public int IDAddress { get; set; }
        public int IDStatus { get; set; }
        [JsonIgnore]

        public Status Statused { get; set; }
        [JsonIgnore]

        public Cart Carts { get; set; }
        [JsonIgnore]

        public Address Address { get; set; }
    }
}
