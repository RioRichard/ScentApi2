using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using ScentApi2.Model;
using System.Collections.Generic;
using System.Linq;

namespace ScentApi2.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ProductController : BaseController
    {
        public ProductController(DataContext context) : base(context) { }
        [HttpGet]
        public IActionResult GetAllProduct()
        {
            return Ok(Context.Products.OrderBy(p=>p.IdProduct).ToList());
        }
        [HttpGet]
        [Route("[action]/{id}")]
        public IActionResult GetByCategory(int id)
        {
            var result = Context.Categories.Include(prop => prop.Products).FirstOrDefault(p => p.IdCategory == id);
            if (result != null)
                return Ok(result.Products);
            return NotFound();

        }
        [HttpGet, Route("{id}")]
        public IActionResult GetById(int id)
        {
            var result = Context.Products.FirstOrDefault(p => p.IdProduct == id);
            if (result != null)
                return Ok(result);
            return NotFound();
        }
    }
}
