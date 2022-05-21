using System;
using System.Text.Json.Serialization;

namespace ScentApi2.Model
{
    public class AccountStaff
    {
        public string IdAccount { get; set; }
        public string UserName { get; set; }
        [JsonIgnore]
        public byte[] Password { get; set; }
        public string Email { get; set; }
        public DateTime? ExpiredTokenTime { get; set; }
        public bool? IsConfirmed { get; set; }
        public bool? IsDelete { get; set; }
        public string FullName { get; set; }
        public bool? Gender { get; set; }
    }
}
