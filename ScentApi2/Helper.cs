using System;
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
        public static string RandomString(int len)
        {
            string p = "qwertyuiopasdfghjklzxcvbnm1234567890QWERTYUIOPASDFGHJKLZXCVBNM";
            char[] a = new char[len];
            Random random = new Random();
            for (int i = 0; i < len; i++)
            {
                a[i] = p[random.Next(p.Length)];
            }
            return string.Join("", a);
        }
        public static string HashToken(string plaintext)
        {
            HashAlgorithm hashAlgorithm = HashAlgorithm.Create("MD5");
            var output = hashAlgorithm.ComputeHash(ASCIIEncoding.ASCII.GetBytes(plaintext));
            var sb = new StringBuilder();
            for (int i = 0; i < output.Length; i++)
            {
                sb.Append(output[i].ToString("X2"));
            }

            return sb.ToString();

        }

    }
}
