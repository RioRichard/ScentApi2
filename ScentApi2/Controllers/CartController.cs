using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using ScentApi2.Model;
using ScentApi2.Model.Repository;
using ScentApi2.Model.SideModel;
using System.Linq;
using System.Security.Claims;

namespace ScentApi2.Controllers
{
    [Route("api/[Controller]/[Action]")]
    [ApiController]
    public class CartController : BaseController
    {
        CartRepo cartRepo;
        public CartController(DataContext context) : base(context)
        {
            cartRepo = new CartRepo(context);
        }

        [HttpGet]
        [Authorize]
        public IActionResult GetAllCart()
        {
            var userId = User.Claims.FirstOrDefault(p => p.Type == ClaimTypes.NameIdentifier).Value;

            return Ok(Context.Carts.Where(p=>p.IDAccount==userId).ToList());
        }

        
        [HttpPost]
        [Authorize]
        public IActionResult AddToCart([FromBody] AddCartModel product)
        {
            var userId = User.Claims.FirstOrDefault(p => p.Type == ClaimTypes.NameIdentifier).Value;
            cartRepo.AddToCart(product, userId);
            return Ok();
        }

        
    }
}
