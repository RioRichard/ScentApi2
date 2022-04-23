using System.Security.Cryptography;
using System.Text;

namespace ScentApi2
{
    public class Helper
    {
        public static byte[] Hash(string plainText)
        {
            HashAlgorithm hashAlgorithm = HashAlgorithm.Create("SHA-512");
            return hashAlgorithm.ComputeHash(ASCIIEncoding.ASCII.GetBytes(plainText));
        }
    }
}
