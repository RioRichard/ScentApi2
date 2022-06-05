using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using ScentApi2.Model;
using ScentApi2.Model.SideModel;
using System.Collections.Generic;
using System.IO;
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
        [HttpPost("AddProduct")]
       
        public IActionResult AddProduct([FromBody] ProductModel product)
        {
            try
            {
                var srcpath = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot", "ImageTemp", product.ImageUrl);
                var despath = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot", "Image", product.ImageUrl);
                //System.IO.File.Move(despath, srcpath);
                System.IO.File.Copy(srcpath,despath);
                System.IO.File.Delete(srcpath);



                var newProduct = new Product()
                {
                    IdCategory = product.IdCategory,
                    Name = product.Name,
                    Price = product.Price,
                    Description = product.Description,
                    IsDelete = product.IsDelete,
                    ImageUrl = product.ImageUrl,
                    ShortDescription = product.ShortDescription,

                };
                Context.Products.Add(newProduct);
                Context.SaveChanges();
                
                return Ok();
                //return Ok(imageUrl);
            }
            catch (System.Exception e)
            {

                return BadRequest(e);
            }
        }
        [HttpGet("Search/{name}")]
        public IActionResult Search(string name)
        {
            return Ok(Context.Products.Where(p=>p.Name.ToLower().Contains(name.ToLower())));
        }
        [HttpPost("Upload")]
        public IActionResult Upload(IFormFile file)
        {
            try
            {
                var path = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot", "ImageTemp");

                var imageUrl = Helper.FileUpload(file, path);
                
                return Ok(new {imageUrl = imageUrl});
            }
            catch (System.Exception e)
            {

                return BadRequest(e);
            }
        }
    }
}
