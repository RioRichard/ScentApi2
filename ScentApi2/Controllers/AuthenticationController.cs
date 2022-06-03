using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
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
            var dict = AccountRepo.Test();
            var x = dict.GetValueOrDefault("pass");
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

    }
}
