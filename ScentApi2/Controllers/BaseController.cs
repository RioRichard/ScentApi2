using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using ScentApi2.Model;

namespace ScentApi2.Controllers
{

    public class BaseController : ControllerBase
    {
        protected DataContext Context;

        public BaseController(DataContext context)
        {
            Context = context;
        }

    }
}
