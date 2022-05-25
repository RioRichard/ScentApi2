using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

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

        public Status Status { get; set; }
    }
}
