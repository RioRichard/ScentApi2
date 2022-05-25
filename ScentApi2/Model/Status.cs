using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text.Json.Serialization;

namespace ScentApi2.Model
{
    [Table("Status")]
    public class Status
    {
        [Key]
        public int IDStatus { get; set; }
        public string StatusName { get; set; }
        public bool IsDelete { get; set; }

        [JsonIgnore]
        public List<Invoice> Invoices { get; set; }
    }
}
