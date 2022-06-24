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
                var rs = AccountRepo.AddAccount(signUp);
                
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
            var rs = AccountRepo.Validate(login);
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
        [HttpPost("Confirm/{token}")]
        public IActionResult Confirm(string token, [FromBody] string UrlFrontEnd)
        {
            
            try
            {
                return Ok(AccountRepo.tryConfirm(token, UrlFrontEnd));
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
                var rs = AccountRepo.ValidateAdmin(logIn);
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
                var rs = AccountRepo.AddAdminAccount(signUp);
                return Ok(rs);
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
                .Select(p => new { info = new { p.IDStaff, p.Email, p.IsConfirmed, p.Gender, p.UserName, p.FullName, p.IsDelete }, Role = p.StaffRoles.Where(c=>c.IsDelete == false).Select(p => p.role) });
            return Ok(rs);
        }

        [HttpGet("GetAdminInfo")]
        [Authorize]
        public IActionResult GetAdminInfo()
        {
            var userId = User.Claims.FirstOrDefault(p => p.Type == ClaimTypes.NameIdentifier).Value;

            var rs = Context.AccountStaffs.Include(p => p.StaffRoles).ThenInclude(p => p.role).Where(p => p.IDStaff == userId)
                .Select(p => new { info = new { p.IDStaff,p.Email, p.IsConfirmed, p.Gender, p.UserName, p.FullName, p.IsDelete }, Role = p.StaffRoles.Where(c => c.IsDelete == false).Select(p => p.role) }).FirstOrDefault();
            return Ok(rs);
        }
        [HttpPut("ChangeAdminInfo")]
        [Authorize]
        public IActionResult ChangeInfo([FromBody] InfoModel info)
        {
            var userId = User.Claims.FirstOrDefault(p => p.Type == ClaimTypes.NameIdentifier).Value;
            try
            {
                var acc = Context.AccountStaffs.FirstOrDefault(p => p.IDStaff == userId);
                acc.FullName = info.Fullname;
                acc.Gender = info.Gender;
                Context.AccountStaffs.Update(acc);
                Context.SaveChanges();
                return Ok("Sửa thông tin thành công.");
            }
            catch (Exception e)
            {

                return BadRequest(e);
            }
        }
        [HttpPut("ChangeMemberInfo/{id}")]
        public IActionResult ChangeMemberInfo(string id,[FromBody] InfoModel info)
        {
            
            try
            {
                var acc = Context.AccountStaffs.FirstOrDefault(p => p.IDStaff == id);
                acc.FullName = info.Fullname;
                acc.Gender = info.Gender;
                acc.IsDelete = info.IsDelete;
                Context.AccountStaffs.Update(acc);
                Context.SaveChanges();
                return Ok("Sửa thông tin thành công.");
            }
            catch (Exception e)
            {

                return BadRequest(e);
            }
        }
        [HttpPost("ConfirmAdmin/{token}")]
        public IActionResult ConfirmAdmin(string token, [FromBody] string UrlFrontEnd)
        {

            try
            {
                return Ok(AccountRepo.tryConfirmAdmin(token, UrlFrontEnd));
            }
            catch (Exception e)
            {

                return BadRequest(e);
            }
        }

        [HttpPut("ChangePass")]
        [Authorize]
        public IActionResult ChangePass([FromBody] ChangePassword pass)
        {
            var userId = User.Claims.FirstOrDefault(p => p.Type == ClaimTypes.NameIdentifier).Value;
            try
            {
                var acc = Context.Accounts.FirstOrDefault(p => p.Password.SequenceEqual(Helper.Hash(pass.OldPass + userId)) && p.IdAccount == userId);
                if(acc == null)
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
        [HttpPut("ChangeStaffPass")]
        [Authorize]
        public IActionResult ChangeStaffPass([FromBody] ChangePassword pass)
        {
            var userId = User.Claims.FirstOrDefault(p => p.Type == ClaimTypes.NameIdentifier).Value;
            try
            {
                var acc = Context.AccountStaffs.FirstOrDefault(p => p.Password.SequenceEqual(Helper.Hash(pass.OldPass + userId)) && p.IDStaff == userId);
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
                    Context.AccountStaffs.Update(acc);
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
        [HttpPut("ChangeRole/{idStaff}")]
        public IActionResult ChangeRole(string idStaff, [FromBody]ChangeRoleModel changeRoleModel)
        {
            try
            {
                var staffRole = Context.StaffRoles.FirstOrDefault(p => p.IdRole == changeRoleModel.RoleId && p.IDStaff == idStaff);
                if (staffRole == null)
                {
                    staffRole = new StaffRole()
                    {
                        IDStaff = idStaff,
                        IdRole = changeRoleModel.RoleId,
                        IsDelete = changeRoleModel.IsDelete
                    };
                    Context.StaffRoles.Add(staffRole);

                }
                else
                {
                    staffRole.IsDelete = changeRoleModel.IsDelete;
                    Context.StaffRoles.Update(staffRole);
                }
                    
                Context.SaveChanges();
                return Ok("Đổi role thành công");

            }
            catch (Exception e)
            {

                return BadRequest(e);
            }
        }
        [HttpPost("SignInGoogle")]
        public IActionResult SignInGoogle([FromBody] SignUpModel logIn)
        {
            try
            {
                var rs = AccountRepo.ValidateGoogle(logIn);
                return Ok(rs);
            }
            catch (Exception e)
            {

                return BadRequest(e);
            }
        }
        [HttpPost("ForgotPassword")]
        public IActionResult ForgotPassword([FromBody] string email)
        {
            try
            {
                var rs = AccountRepo.ForgotPassword(email);
                return Ok(rs);
            }
            catch (Exception ex)
            {

                return BadRequest(ex);
            }
            
        }
        [HttpPost("ForgotAdminPassword")]
        public IActionResult ForgotAdminPassword([FromBody] string email)
        {
            try
            {
                var rs = AccountRepo.ForgotAdminPassword(email);
                return Ok(rs);
            }
            catch (Exception ex)
            {

                return BadRequest(ex);
            }

        }
        

    }
}
