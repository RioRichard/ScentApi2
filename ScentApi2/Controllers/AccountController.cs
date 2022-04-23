using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using ScentApi2.Model;
using ScentApi2.Model.SideModel;

namespace ScentApi2.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AccountController : ControllerBase
    {
        DataContext Context;
        public AccountController(DataContext context)
        {
            Context = context;
        }
        [HttpPost]
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

    }
}
