using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text.Json.Serialization;

namespace ScentApi2.Model
{
    [Table("Role")]
    public class Role
    {
        [Key]
        public Guid IdRole { get; set; }
        public string RoleName { get; set; }
        public bool? IsDelete { get; set; }
        [JsonIgnore]

        public List<StaffRole> staffRoles { get; set; }
    }
}
