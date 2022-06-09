using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using ScentApi2.Model;
using ScentApi2.Model.Repository;
using ScentApi2.Model.SideModel;

namespace ScentApi2.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AuthenticationController : BaseController
    {
        protected AccountRepository AccountRepo;

        public AuthenticationController(DataContext context, IConfiguration configuration) : base(context)
        {
            AccountRepo = new AccountRepository(context, configuration);
        }

        [HttpPost]
        [Route("SignUp")]
        public IActionResult SignUp([FromBody] SignUpModel signUp)
        {
            try
            {
                var rs = AccountRepo.AddAccount(signUp.Email, signUp.UserName, signUp.Pass);
                
                return Ok(rs);

            }
            catch (Exception ex)
            {

                return BadRequest(ex);
            }
            
        }
        [HttpPost]
        [Route("Login")]
        public IActionResult Login([FromBody]LogInModel login){
            var rs = AccountRepo.Validate(login.UserName, login.Pass);
            return Ok(rs);
        }
        [HttpGet("Info")]
        [Authorize]
        public IActionResult GetInfo()
        {
            var userId = User.Claims.FirstOrDefault(p=>p.Type == ClaimTypes.NameIdentifier).Value;
            var acc = Context.Accounts.Where(p=>p.IdAccount == userId).Select(p=> new {email = p.Email, userName = p.UserName, gender = p.Gender, fullName = p.FullName, }).FirstOrDefault();
            return Ok(acc);
        }
        [HttpGet("test")]
        public IActionResult Test()
        {

            var x = Context.StaffRoles.Include(p => p.role);

            return Ok(x);
        }
        [HttpPost("Confirm")]
        [Authorize]
        public IActionResult Confirm([FromBody] string token)
        {
            var userId = User.Claims.FirstOrDefault(p => p.Type == ClaimTypes.NameIdentifier).Value;
            try
            {
                return Ok(AccountRepo.tryConfirm(userId, token));
            }
            catch (Exception e)
            {

                return BadRequest(e);
            }
        }
        [HttpPost("SendMail")]
        [Authorize]
        public IActionResult SendMail()
        {
            var userId = User.Claims.FirstOrDefault(p => p.Type == ClaimTypes.NameIdentifier).Value;
            try
            {
                return Ok(AccountRepo.sendToken(userId));
            }
            catch (Exception e)
            {

                return BadRequest(e);
            }
        }
        [HttpPut("UpdateInfo")]
        [Authorize]
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
        [HttpPost("AdminLogin")]
        public IActionResult AdminLogin([FromBody] LogInModel logIn)
        {
            try
            {
                var rs = AccountRepo.ValidateAdmin(logIn.UserName, logIn.Pass);
                return Ok(rs);
            }
            catch (Exception ex)
            {

                return BadRequest(ex);
            }
        }
        [HttpPost("AdminReg")]
        public IActionResult AdminReg([FromBody] SignUpModel signUp)
        {
            try
            {
                var id = Helper.RandomString(64);
                var acc = new AccountStaff()
                {
                    IDStaff = id,
                    UserName = signUp.UserName,
                    Password = Helper.Hash(signUp.Pass + id),
                    Email = signUp.Email
                };
                Context.AccountStaffs.Add(acc);
                Context.SaveChanges();
                //var acc = Context.AccountStaffs;
                return Ok(acc);
            }
            catch (Exception ex)
            {

                return BadRequest(ex);
            }
        }
        [HttpGet("AllStaffInfo")]
        public IActionResult AllStaffInfo()
        {
            var rs = Context.AccountStaffs.Include(p => p.StaffRoles).ThenInclude(p => p.role)
                .Select(p => new { info = new { p.IDStaff, p.IsConfirmed, p.Gender, p.UserName, p.FullName, p.IsDelete }, Role = p.StaffRoles.Where(c=>c.IsDelete == false).Select(p => p.role) });
            return Ok(rs);
        }

        [HttpGet("GetAdminInfo")]
        [Authorize]
        public IActionResult GetAdminInfo()
        {
            var userId = User.Claims.FirstOrDefault(p => p.Type == ClaimTypes.NameIdentifier).Value;

            var rs = Context.AccountStaffs.Include(p => p.StaffRoles).ThenInclude(p => p.role).Where(p => p.IDStaff == userId)
                .Select(p => new { info = new { p.IDStaff, p.IsConfirmed, p.Gender, p.UserName, p.FullName, p.IsDelete }, Role = p.StaffRoles.Where(c => c.IsDelete == false).Select(p => p.role) }).FirstOrDefault();
            return Ok(rs);
        }


    }
}
