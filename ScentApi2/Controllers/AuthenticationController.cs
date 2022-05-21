using System.Linq;
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
                AccountRepo.AddAccount(signUp.Email, signUp.UserName, signUp.Pass);
                return Ok();

            }
            catch 
            {

                return BadRequest();
            }
        }
        [HttpPost]
        [Route("Login")]
        public IActionResult Login([FromBody]LogInModel login){
            var rs = AccountRepo.Validate(login.UserName, login.Pass);
            return Ok(rs);
        }

    }
}
