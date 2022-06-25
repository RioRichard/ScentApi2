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
