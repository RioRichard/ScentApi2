using System;
using System.ComponentModel.DataAnnotations.Schema;

namespace ScentApi2.Model
{
    [Table("StaffRole")]
    public class StaffRole
    {
        public string IDStaff { get; set; }
        public Guid IdRole { get; set; }

        public AccountStaff accountStaff { get; set; }
        public Role role { get; set; }
        public bool IsDelete { get; set; }
    }
}
