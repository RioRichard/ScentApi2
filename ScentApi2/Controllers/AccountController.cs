using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using ScentApi2.Model;
using ScentApi2.Model.Repository;
using ScentApi2.Model.SideModel;
using System;
using System.Linq;
using System.Security.Claims;

namespace ScentApi2.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    [Authorize(Roles ="None")]
    public class AccountController : BaseController
    {
        AccountRepository AccountRepository { get; set; }
        public AccountController(DataContext context, IConfiguration configuration) : base(context)
        {
            AccountRepository = new AccountRepository(context,configuration);
        }
        [HttpGet("Info")]
        
        public IActionResult GetInfo()
        {
            var userId = User.Claims.FirstOrDefault(p => p.Type == ClaimTypes.NameIdentifier).Value;
            var acc = Context.Accounts.Where(p => p.IdAccount == userId).Select(p => new { email = p.Email, userName = p.UserName, gender = p.Gender, fullName = p.FullName, }).FirstOrDefault();
            return Ok(acc);
        }
        [HttpPut("UpdateInfo")]

        public IActionResult UpdateInfo([FromBody] InfoModel info)
        {
            var userId = User.Claims.FirstOrDefault(p => p.Type == ClaimTypes.NameIdentifier).Value;
            try
            {
                var acc = Context.Accounts.FirstOrDefault(p => p.IdAccount == userId);
                acc.FullName = info.Fullname;
                acc.Gender = info.Gender;
                Context.Accounts.Update(acc);
                Context.SaveChanges();
                return Ok("Sửa thông tin thành công.");
            }
            catch (Exception e)
            {

                return BadRequest(e);
            }
        }

        [HttpPut("ChangePass")]

        public IActionResult ChangePass([FromBody] ChangePassword pass)
        {
            var userId = User.Claims.FirstOrDefault(p => p.Type == ClaimTypes.NameIdentifier).Value;
            try
            {
                var acc = Context.Accounts.FirstOrDefault(p => p.Password.SequenceEqual(Helper.Hash(pass.OldPass + userId)) && p.IdAccount == userId);
                if (acc == null)
                {
                    return Ok(new
                    {
                        status = false,
                        msg = "Sai mật khẩu cũ"
                    });

                }
                else
                {
                    acc.Password = Helper.Hash(pass.NewPass + userId);
                    Context.Accounts.Update(acc);
                    Context.SaveChanges();
                    return Ok(new
                    {
                        status = true,
                        msg = "Đổi mật khẩu thành công"
                    });
                }
            }
            catch (Exception e)
            {

                return BadRequest(e);
            }
        }

    }
}
