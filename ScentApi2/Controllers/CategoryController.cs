using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using ScentApi2.Model;
using System.Linq;

namespace ScentApi2.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CategoryController : BaseController
    {
        public CategoryController(DataContext Context) : base(Context) { }

        [HttpGet]
        public IActionResult GetCategory()
        {
            try
            {
                return Ok(Context.Categories);

            }
            catch 
            {
                return BadRequest();
            }
        }
        [HttpGet]
        [Route("{id}")]
        public IActionResult GetCategory(int id)
        {
            try
            {
                var rs = Context.Categories.FirstOrDefault(prop => prop.IdCategory == id);
                if (rs != null)
                    return Ok(rs);
                return NotFound();
            }
            catch 
            {
                return BadRequest();
                
            }
        }
        [HttpGet("GetByProduct/{id}")]
        public IActionResult GetByProduct(int id)
        {
            try
            {
                var rs = Context.Products.Include(prop=>prop.Category).FirstOrDefault(prop => prop.IdCategory == id);
                if (rs != null)
                    return Ok(rs.Category);
                return NotFound();
            }
            catch
            {
                return BadRequest();

            }
        }
    }
}
