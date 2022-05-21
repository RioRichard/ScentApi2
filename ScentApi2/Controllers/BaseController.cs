using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using ScentApi2.Model;
using ScentApi2.Model.Repository;


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
