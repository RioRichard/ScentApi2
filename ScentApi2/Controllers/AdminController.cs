﻿using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
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
    [Authorize(Roles = "Admin,Staff,SuperAdmin")]
    public class AdminController : BaseController
    {
        
        public AdminController(DataContext context) : base(context)
        {
            
        }


        [HttpGet("AllStaffInfo")]
        [Authorize(Roles ="Admin, SuperAdmin")]
        public IActionResult AllStaffInfo()
        {
            try
            {
                var rs = Context.AccountStaffs.Include(p => p.StaffRoles).ThenInclude(p => p.role)
                .Select(p => new { p.IDStaff, p.Email, p.IsConfirmed, p.Gender, p.UserName, p.FullName, p.IsDelete, Role = p.StaffRoles.Where(c => c.IsDelete == false).Select(p => p.role) });
                return Ok(rs);
            }
            catch (Exception ex)
            {

                return BadRequest(ex);
            }
        }

        [HttpGet("GetAdminInfo")]
        
        public IActionResult GetAdminInfo()
        {
            var userId = User.Claims.FirstOrDefault(p => p.Type == ClaimTypes.NameIdentifier).Value;

            var rs = Context.AccountStaffs.Include(p => p.StaffRoles).ThenInclude(p => p.role).Where(p => p.IDStaff == userId)
                .Select(p => new { info = new { p.IDStaff, p.Email, p.IsConfirmed, p.Gender, p.UserName, p.FullName, p.IsDelete }, Role = p.StaffRoles.Where(c => c.IsDelete == false).Select(p => p.role) }).FirstOrDefault();
            return Ok(rs);
        }
        [HttpPut("ChangeAdminInfo")]
        
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
        [Authorize(Roles = "Admin, SuperAdmin")]

        public IActionResult ChangeMemberInfo(string id, [FromBody] InfoModel info)
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

        [HttpPut("ChangeStaffPass")]

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
        [Authorize(Roles = "Admin, SuperAdmin")]

        public IActionResult ChangeRole(string idStaff, [FromBody] ChangeRoleModel changeRoleModel)
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
    }
}
