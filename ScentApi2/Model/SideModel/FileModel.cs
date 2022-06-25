using Microsoft.AspNetCore.Http;

namespace ScentApi2.Model.SideModel
{
    public class FileModel
    {
        public string FileName { get; set; }
        public IFormFile File { get; set; }
    }
}
