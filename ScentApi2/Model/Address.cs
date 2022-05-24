using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text.Json.Serialization;

namespace ScentApi2.Model
{
    [Table("Address")]
    public class Address
    {
        [Key]
        public int IDAddress { get; set; }
        [Column("Address")]
        public string Addressed { get; set; }
        public string Phone { get; set; }
        public string Reciever { get; set; }
        [JsonIgnore]
        public List<AccountAddress> AccountAddress { get; set; }
    }
}
