using Microsoft.Extensions.Configuration;
using Microsoft.IdentityModel.Tokens;
using System;
using System.IdentityModel.Tokens.Jwt;
using System.Linq;
using System.Security.Claims;
using System.Text;

namespace ScentApi2.Model.Repository
{
    public class AccountRepository : BaseRepo
    {
        IConfiguration Configuration;
        public AccountRepository(DataContext context, IConfiguration configuration) : base(context)
        {
            Configuration = configuration;
        }
        public void AddAccount(string email, string userName, string pass)
            
        {
            var id = Helper.RandomString(64);
            var newAccount = new Account()
            {
                IdAccount = id,
                Email = email,
                UserName = userName,
                Password = Helper.Hash(pass+id)
            };
            Context.Accounts.Add(newAccount);
            Context.SaveChanges();
        }
        public object Validate(string userName, string pass)
        {
            var result = Context.Accounts.FirstOrDefault(p => p.UserName == userName);
            
            if (result != null)
            {
                
                var hasedPass = Helper.Hash(pass + result.IdAccount);
               
                if (hasedPass.SequenceEqual(result.Password))
                {
                    if(result.IsConfirmed == false)
                    {
                        return new
                        {
                            Success = false,
                            Msg = "Tài khoản của bạn chưa được xác nhận. Một email mới đã được gửi tới yêu cầu xác nhận và có hiệu lực trong 15p",
                            Data = ""
                        };
                    }
                    return new
                    {
                        Success = true,
                        Msg = "Đăng nhập thành công",
                        Data = generateJWTToken(result)
                    };
                }
                    
            }
            return new
            {
                Success = false,
                Msg = "Tên đăng nhập hoặc mật khẩu không đúng",
                Data = ""

            };
        }

        public string generateJWTToken(Account account)
        {
            var jwtHandler = new JwtSecurityTokenHandler();
            var secretKeyBytes = Encoding.UTF8.GetBytes(Configuration["JWT:Key"]);

            var tokenDescription = new SecurityTokenDescriptor
            {
                Subject = new ClaimsIdentity(new[]
                    {
                    new Claim(ClaimTypes.Email, account.Email),
                    new Claim(ClaimTypes.Name, account.UserName),
                    new Claim(ClaimTypes.NameIdentifier, account.IdAccount),

                    //Roles
                    new Claim(ClaimTypes.Role, "None"),


                }
                ),
                Expires = DateTime.UtcNow.AddDays(30),
                SigningCredentials = new SigningCredentials(new SymmetricSecurityKey(secretKeyBytes), SecurityAlgorithms.HmacSha256Signature),

            };
            var token = jwtHandler.CreateToken(tokenDescription);
            return jwtHandler.WriteToken(token);
        }


    }
}
