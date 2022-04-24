using System.Linq;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using ScentApi2.Model;
using ScentApi2.Model.SideModel;

namespace ScentApi2.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AuthenticationController : ControllerBase
    {
        DataContext Context;
        public AuthenticationController(DataContext context)
        {
            Context = context;
        }
        [HttpPost]
        [Route("SignUp")]
        public IActionResult SignUp([FromBody]SignUpModel signUp)
        {
            var newAccount = new Account()
            {
                IdAccount = "12323123213123",
                Email = signUp.Email,
                UserName = signUp.UserName,
                Password = Helper.Hash(signUp.Pass)
            };
            Context.Accounts.Add(newAccount);
            Context.SaveChanges();
            return Ok();
        }
        [HttpPost]
        [Route("Login")]
        public IActionResult Login([FromBody]LogInModel login){
            var result= Context.Accounts.FirstOrDefault(p=>p.UserName == login.UserName && p.Password ==  Helper.Hash(login.Pass));
            if (result != null)
            {
                return Ok();
            }
            return NotFound();
        }

    }
}
