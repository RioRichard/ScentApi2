using System;
using System.Collections.Generic;
using System.IO;
using System.Net;
using System.Net.Mail;
using System.Security.Cryptography;
using System.Text;
using System.Text.Json;

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
        public static string RandomNumber(int len)
        {
            string p = "1234567890";
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
        public static void SendMail( string toEmail, string content, string subject)
        {

            var json = File.ReadAllText("test.json");
            var account = JsonSerializer.Deserialize<Dictionary<string, string>>(json);
            SmtpClient client = new SmtpClient("smtp.gmail.com", 587)
            {
                UseDefaultCredentials = false,
                Credentials = new NetworkCredential(account.GetValueOrDefault("account"), account.GetValueOrDefault("pass")),
                EnableSsl = true        
            };
            MailAddress addressFrom = new MailAddress(account.GetValueOrDefault("account"));
            MailAddress addressTo = new MailAddress(toEmail);
            MailMessage message = new MailMessage(addressFrom, addressTo);

            message.Body = content;
            message.Subject = subject;
            client.Send(message);
        }

    }
}
