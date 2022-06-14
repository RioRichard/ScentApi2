using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text.Json.Serialization;

namespace ScentApi2.Model
{
    [Table("AccountStaff")]
    public class AccountStaff
    {
        [Key]
        public string IDStaff { get; set; }
        public string UserName { get; set; }
        [JsonIgnore]
        public byte[] Password { get; set; }
        public string Email { get; set; }
        public string Token { get; set; }

        public DateTime? ExpiredTokenTime { get; set; }
        public bool? IsConfirmed { get; set; }
        public bool? IsDelete { get; set; }
        public string FullName { get; set; }
        public bool? Gender { get; set; }
        [JsonIgnore]

        public List<StaffRole> StaffRoles { get; set; }

    }
}
