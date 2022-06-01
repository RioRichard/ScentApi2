using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
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
        public IActionResult GetCart()
        {
            var userId = User.Claims.FirstOrDefault(p => p.Type == ClaimTypes.NameIdentifier).Value;
            var rs = Context.Carts.Include(p => p.ProductCarts).ThenInclude(p => p.Product).Where(p => p.IDAccount == userId && p.IsExpired == false)
                .Select(p =>new {Product = p.ProductCarts.Select(p => p.Product)}).FirstOrDefault();
            return Ok(rs);
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
