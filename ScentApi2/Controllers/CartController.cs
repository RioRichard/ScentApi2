using Microsoft.AspNetCore.Mvc;
using ScentApi2.Model;
using System.Linq;

namespace ScentApi2.Controllers
{
    [Route("api/[Controller]/[Action]")]
    [ApiController]
    public class CartController : BaseController
    {
        public CartController(DataContext context) : base(context)
        {
        }

        [HttpGet]
        public IActionResult GetAllCart()
        {
            return Ok(Context.Carts.ToList());
        }

        
        [HttpPost]
        public IActionResult AddToCart(string idAccount, int idProduct, int quantity)
        {
            return Ok(new {id1 = idAccount, id2 = idProduct, quantity1 = quantity});
        }
    }
}
