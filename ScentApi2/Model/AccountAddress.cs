using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace ScentApi2.Model
{
    [Table("AccountAddress")]
    public class AccountAddress
    {
        [Key]
        [Column(Order = 0)]
        public int IDAddress { get; set; }
        [Key]
        [Column(Order =1)]
        public string IDAccount { get; set; }

        public bool IsDefault { get; set; }

        //public Account Account { get; set; }
        public Account Account { get; set; }
        public Address Address { get; set; }

    }
}
