using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using ScentApi2.Model;
using System.Linq;

namespace ScentApi2.Controllers
{
    [Route("api/[Controller]/[Action]")]
    [ApiController]
    public class RoleController : BaseController
    {
        public RoleController(DataContext context) : base(context)
        {
        }

        [HttpGet]

        public IActionResult GetRole()
        {
            try
            {
                var rs = Context.Roles.Include(p => p.staffRoles).Select(p => new { p.IdRole, p.RoleName, p.IsDelete, p.staffRoles }).ToList();
                return Ok(rs);
            }
            catch (System.Exception ex)
            {

                return BadRequest(ex);
            }
        }
    }
}
