using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using ScentApi2.Model;
using ScentApi2.Model.SideModel;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;

namespace ScentApi2.Controllers
{
    [Route("api/[Controller]/[Action]")]
    [ApiController]
    public class AddressController : BaseController
    {
        public AddressController(DataContext context) : base(context)
        {
        }

        [HttpGet]
        [Authorize]
        public IActionResult GetAddress()
        {
            var userId = User.Claims.FirstOrDefault(p => p.Type == ClaimTypes.NameIdentifier).Value;
            var address = Context.Accounts.Include(p=>p.AccountAddresses).ThenInclude(p=>p.Address).FirstOrDefault(p => p.IdAccount == userId).AccountAddresses?.Select(p => new { p.IsDefault,p.Address});
            return Ok(address);
        }
        [HttpPost]
        [Authorize]
        public IActionResult AddAddress([FromBody] AddressModel address)
        {
            var userId = User.Claims.FirstOrDefault(p => p.Type == ClaimTypes.NameIdentifier).Value;
            var dfAddress = Context.AccountAddresses.FirstOrDefault(p=>p.IDAccount == userId && p.IsDefault == true);
            
            if (dfAddress == null)
                address.IsDefault = true;
            else
            {
                if (address.IsDefault)
                {
                    dfAddress.IsDefault = false;
                    Context.AccountAddresses.Update(dfAddress);
                    Context.SaveChanges();
                }

            }
            var newAddress = new Address()
            {
                Addressed = address.Addressed,
                Phone = address.Phone,
                Reciever = address.Reciever,
                AccountAddress = new List<AccountAddress>()
               
            };
            Context.Addresses.Add(newAddress);
            Context.SaveChanges();

            var accountAddress = new AccountAddress()
            {
                IDAccount = userId,
                IDAddress = newAddress.IDAddress,
                IsDefault = address.IsDefault
            };
            newAddress.AccountAddress.Add(accountAddress);
            Context.Addresses.Update(newAddress);
            
            Context.SaveChanges();
            return Ok();
        }
    }
}
