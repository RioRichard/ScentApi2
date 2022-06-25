using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using ScentApi2.Model;
using ScentApi2.Model.SideModel;
using System;
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
        //[Authorize]
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
        [HttpPost("AddCate")]
        [Authorize(Roles = "Admin,Staff,SuperAdmin")]

        public IActionResult AddCategory([FromBody] string Name)
        {
            try
            {
                var cate = new Category()
                {
                    CategoryName = Name,
                    IsDelete = false
                };
                Context.Categories.Add(cate);
                Context.SaveChanges();
                return Ok();
            }
            catch 
            {

                return BadRequest();
            }
        }
        [HttpPut("UpdateCate/{id}")]
        [Authorize(Roles = "Admin,Staff,SuperAdmin")]

        public IActionResult UpdateCate(int id, [FromBody] CategoryModel category)
        {
            try
            {
                var cate = Context.Categories.FirstOrDefault(p => p.IdCategory == id);
                cate.CategoryName = category.CategoryName;
                cate.IsDelete = category.IsDelete;
                Context.Categories.Update(cate);
                Context.SaveChanges();
                return Ok();
            }
            catch 
            {

                return BadRequest();
            }
        }
        [HttpDelete("DeleteCate")]
        [Authorize(Roles = "Admin,Staff,SuperAdmin")]

        public IActionResult DeleteCate([FromBody]int id)
        {
            try
            {
                var cate = Context.Categories.Include(p=>p.Products)
                    .ThenInclude(p=>p.ProductCarts)
                    .ThenInclude(p=>p.Cart)
                    
                    .FirstOrDefault(p => p.IdCategory == id);
                if (cate.Products.FirstOrDefault(p => p.ProductCarts.FirstOrDefault(c => c.Cart.IsExpired == true) == null) == null)
                {
                    Context.Categories.Remove(cate);
                    Context.SaveChanges();
                    return Ok();

                }
                return BadRequest("Không thể xóa. Sản phẩm đã được mua");

            }
            catch (Exception ex)
            {
                return BadRequest(ex);

            }

        }
        
    }
}
