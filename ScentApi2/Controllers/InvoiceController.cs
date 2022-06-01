using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using ScentApi2.Model;
using System;
using System.Linq;
using System.Security.Claims;

namespace ScentApi2.Controllers
{
    [Route("api/[Controller]/[Action]")]
    [ApiController]
    public class InvoiceController : BaseController
    {
        public InvoiceController(DataContext context) : base(context)
        {
        }

        [HttpGet]
        public IActionResult GetAllStatus()
        {
            return Ok(Context.Statuses.ToList());
        }

        [Authorize]
        [HttpPost]
        public IActionResult Charge()
        {
            var userId = User.Claims.FirstOrDefault(p => p.Type == ClaimTypes.NameIdentifier).Value;
            var Account = Context.Accounts.Include(p => p.AccountAddresses).Include(p=> p.Carts).ThenInclude(p=>p.ProductCarts).FirstOrDefault(p => p.IdAccount == userId);
            if (Account.AccountAddresses.Count== 0)
            {
                return BadRequest(new {msg= "Không có địa chỉ, yêu cầu bạn thêm địa chỉ" } );
            }
            var cart = Account.Carts.FirstOrDefault(p => p.IsExpired == false);
            if(cart == null || cart.ProductCarts.Count == 0)
            {
                return BadRequest(new { msg = "Giỏ hàng không có, hoặc bạn chưa mua món hàng nào"});

            }
            cart.IsExpired = true;
            var invoice = new Invoice()
            {
                IDInvoice = Guid.NewGuid(),
                IDCart = cart.IDCart,
                IDAddress = Account.AccountAddresses.FirstOrDefault(p => p.IsDefault == true).IDAddress,
                IDStatus = 1,
                DateCreated = DateTime.UtcNow,
                DateExpired = null
            };
            Context.Carts.Update(cart);
            //Context.SaveChanges();
            Context.Invoices.Add(invoice);
            Context.SaveChanges();
            return Ok();
        }
        [HttpGet]
        [Authorize]
        public IActionResult GetAccountAddress()
        {
            var userId = User.Claims.FirstOrDefault(p => p.Type == ClaimTypes.NameIdentifier).Value;

            var Account = Context.Accounts.Include(p => p.AccountAddresses).Include(p => p.Carts).ThenInclude(p => p.ProductCarts).FirstOrDefault(p => p.IdAccount == userId);


            //Console.WriteLine(Account.Carts.FirstOrDefault(p=>p.IsExpired==false).IDCart);
            return Ok(Account.Carts.FirstOrDefault(p => p.IsExpired == false).ProductCarts.Count);
        }
        [HttpGet]
        [Authorize]
        public IActionResult GetAllInvoice()
        {
            var userId = User.Claims.FirstOrDefault(p => p.Type == ClaimTypes.NameIdentifier).Value;

            var AllInvoice = Context.Carts.Include(p=>p.Invoices).Include(p => p.ProductCarts).ThenInclude(p => p.Product).
                Where(p => p.IDAccount == userId && p.IsExpired == true).Select(p => new { invoice = p.Invoices, product = p.ProductCarts.Select(p=>p.Product)});


            //Console.WriteLine(Account.Carts.FirstOrDefault(p=>p.IsExpired==false).IDCart);
            return Ok(AllInvoice);
        }
        [HttpGet]
        public IActionResult GetAdminInvoice()
        {
            var Invoice = Context.Invoices
                .Include(p => p.Carts).ThenInclude(p => p.ProductCarts).ThenInclude(p => p.Product)
                .Include(p => p.Address)
                .Include(p => p.Statused)
                .Select(p => new { id = p.IDInvoice, Product = p.Carts.ProductCarts.Select(p => p.Product), p.Address, p.Statused });
            return Ok(Invoice);
        }

    }
}
