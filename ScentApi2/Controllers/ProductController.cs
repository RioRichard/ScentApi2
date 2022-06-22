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
                    Stock = product.Stock,
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
        public IActionResult Upload([FromForm] FileModel file)
        {
            try
            {
                var path = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot", "ImageTemp");
                
                var imageUrl = Helper.FileUpload(file.File, path, file.FileName);


                return Ok(new {imageUrl = imageUrl});
            }
            catch (System.Exception e)
            {

                return BadRequest(e);
            }
        }
        [HttpPut("Update/{id}")]
        public IActionResult Update(int id, [FromBody] ProductModel productModel)
        {

            try
            {
                var product = Context.Products.FirstOrDefault(p => p.IdProduct == id);
                if(product.ImageUrl != productModel.ImageUrl)
                {
                    var srcpath = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot", "ImageTemp", productModel.ImageUrl);
                    var despath = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot", "Image", productModel.ImageUrl);
                    //System.IO.File.Move(despath, srcpath);
                    System.IO.File.Copy(srcpath, despath);
                    System.IO.File.Delete(srcpath);
                    var oldDesPath = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot", "Image", product.ImageUrl);
                    System.IO.File.Delete(oldDesPath);


                }
                product.IdCategory = productModel.IdCategory;
                product.Name = productModel.Name;
                product.Price = productModel.Price;
                product.Description = productModel.Description;
                product.IsDelete = productModel.IsDelete;
                product.ImageUrl = productModel.ImageUrl;
                product.Stock = productModel.Stock;

                product.ShortDescription = productModel.ShortDescription;
                
                Context.Products.Update(product);
                Context.SaveChanges();

                return Ok();
                //return Ok(imageUrl);
            }
            catch (System.Exception e)
            {

                return BadRequest(e);
            }
        }
        [HttpDelete("Delete")]
        public IActionResult Update([FromBody]int id)
        {

            try
            {
                var product = Context.Products
                    .Include(p=>p.ProductCarts)
                    .ThenInclude(p=>p.Cart)
                    .FirstOrDefault(p=>p.IdProduct==id);
                if(product.ProductCarts.FirstOrDefault(p=>p.Cart.IsExpired == true) == null)
                {
                    Context.Products.Remove(product);
                    Context.SaveChanges();
                    return Ok();
                }
                return BadRequest("Không thể xóa. Đã có khách hàng mua mặt hàng này");
                
                //return Ok(imageUrl);
            }
            catch (System.Exception e)
            {

                return BadRequest(e);
            }
        }
        [HttpPost("UploadFELogo")]
        
        public IActionResult Upload([FromBody] string FileName)
        {
            try
            {
                var srcpath = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot", "ImageTemp", FileName);
                var despath = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot", "FELogo", FileName);
                var oldDesPath = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot", "Image", FileName);
                if(System.IO.File.Exists(oldDesPath))
                    System.IO.File.Delete(oldDesPath);
                if (System.IO.File.Exists(srcpath))
                {
                    System.IO.File.Copy(srcpath, despath);
                    System.IO.File.Delete(srcpath);
                }

                
                //System.IO.File.Move(despath, srcpath);
                
                

                return Ok();
            }
            catch (System.Exception e)
            {

                return BadRequest(e);
            }
        }
    }
}
