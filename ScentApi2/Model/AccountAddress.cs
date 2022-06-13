using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text.Json.Serialization;

namespace ScentApi2.Model
{
    [Table("AccountAddress")]
    public class AccountAddress
    {
        
        public int IDAddress { get; set; }

        public string IDAccount { get; set; }

        public bool IsDefault { get; set; }

        //public Account Account { get; set; }
        [JsonIgnore]

        public Account Account { get; set; }
        [JsonIgnore]

        public Address Address { get; set; }

    }
}
