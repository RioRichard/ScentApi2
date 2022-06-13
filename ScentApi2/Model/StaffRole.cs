using System;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text.Json.Serialization;

namespace ScentApi2.Model
{
    [Table("StaffRole")]
    public class StaffRole
    {
        public string IDStaff { get; set; }
        public Guid IdRole { get; set; }
        [JsonIgnore]

        public AccountStaff accountStaff { get; set; }
        [JsonIgnore]

        public Role role { get; set; }
        public bool IsDelete { get; set; }
    }
}
