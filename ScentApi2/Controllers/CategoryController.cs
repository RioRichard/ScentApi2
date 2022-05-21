using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using ScentApi2.Model;
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
        public IActionResult AddCategory(string Name)
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
        [HttpPut("UpdateCate")]
        public IActionResult UpdateCate(int id, string Name, bool isDelete)
        {
            try
            {
                var cate = Context.Categories.FirstOrDefault(p => p.IdCategory == id);
                cate.CategoryName = Name;
                cate.IsDelete = isDelete;
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
        public IActionResult DeleteCate(int id)
        {
            try
            {
                var cate = Context.Categories.FirstOrDefault(p => p.IdCategory == id);

                Context.Categories.Remove(cate);
                Context.SaveChanges();
                return Ok();
            }
            catch
            {
                return BadRequest();

            }

        }
        [HttpGet("TestAuthorize")]
        [Authorize]
        public IActionResult Test()
        {
            return Ok(GetCategory());
        }
    }
}
