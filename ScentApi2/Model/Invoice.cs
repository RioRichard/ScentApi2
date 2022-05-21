using System;

namespace ScentApi2.Model
{
    public class Invoice
    {
        public System.Guid IDInvoice { get; set; }
        public DateTime? DateCreated{ get; set; }
        public DateTime? DateExpired { get; set; }
        public Guid IDCart { get; set; }
        public int IDAddress { get; set; }
        public int IDStatus { get; set; }
    }
}
