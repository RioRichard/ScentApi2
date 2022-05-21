using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text.Json.Serialization;

namespace ScentApi2.Model
{
    public class Address
    {
        [Key]
        public int IDAddress { get; set; }
        [Column("Address")]
        public string Addressed { get; set; }
        public string Phone { get; set; }
        public string Receiver { get; set; }
        [JsonIgnore]
        public Account Account { get; set; }
    }
}
