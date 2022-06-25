using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.IdentityModel.Tokens;
using ScentApi2.Model.SideModel;
using System;
using System.Collections.Generic;
using System.IdentityModel.Tokens.Jwt;
using System.IO;
using System.Linq;
using System.Security.Claims;
using System.Text;
using System.Text.Json;

namespace ScentApi2.Model.Repository
{
    public class AccountRepository : BaseRepo
    {
        IConfiguration Configuration;
        public AccountRepository(DataContext context, IConfiguration configuration) : base(context)
        {
            Configuration = configuration;
        }
        public object AddAccount(SignUpModel signUp)
            
        {
            var check = Context.Accounts.FirstOrDefault(p => p.Email == signUp.Email || p.UserName == signUp.UserName);
            if(check == null)
            {
                var id = Helper.RandomString(64);
                var newAccount = new Account()
                {
                    IdAccount = id,
                    Email = signUp.Email,
                    UserName = signUp.UserName,
                    Password = Helper.Hash(signUp.Pass + id),
                    Token = Helper.RandomString(64),
                    IsConfirmed = false,
                    ExpiredTokenTime = DateTime.UtcNow.AddMinutes(15)
                };
                Context.Accounts.Add(newAccount);
                Context.SaveChanges();
                var content = $"Đường dẫn xác nhận tài khoản của bạn là: {signUp.UrlFrontEnd + newAccount.Token} có thời gian hiệu lực trong 15p.";
                var subject = $"Xác nhận tài khoản Teyvat Scent";
                Helper.SendMail(signUp.Email, content, subject);
                return new
                {
                    Status = true,
                    msg = "Đăng kí thành công. Mã xác nhận đã gửi tới email bạn"
                };
            }
            return new
            {
                Status = false,
                msg = "Đăng kí không thành công. Trùng tên đăng nhập hoặc mật khẩu."
            };




        }
        public object Validate(LogInModel logIn)
        {
            var result = Context.Accounts.FirstOrDefault(p => p.UserName == logIn.UserName);
            
            if (result != null)
            {
                
                var hasedPass = Helper.Hash(logIn.Pass + result.IdAccount);
               
                if (hasedPass.SequenceEqual(result.Password))
                {
                    if(result.IsConfirmed == false)
                    {
                        var expiredTime = (DateTime)result.ExpiredTokenTime;

                        if (DateTime.Compare(DateTime.UtcNow, expiredTime.AddMinutes(-14)) >= 0)
                        {
                            result.ExpiredTokenTime = DateTime.UtcNow.AddMinutes(15);
                            result.Token = Helper.RandomString(64);
                            Context.Accounts.Update(result);
                            Context.SaveChanges();
                            var content = $"Đường dẫn xác nhận tài khoản của bạn là: {logIn.UrlFrontEnd + result.Token} có thời gian hiệu lực trong 15p.";
                            var subject = $"Xác nhận tài khoản Teyvat Scent";
                            Helper.SendMail(result.Email, content, subject);

                        }
                        
                        return new
                        {
                            Success = false,
                            Msg = "Tài khoản của bạn chưa được xác nhận. Một email mới đã được gửi tới yêu cầu xác nhận và có hiệu lực trong 15p",
                            Data = "",
                            IsConfirm = false
                            
                        };
                    }
                    return new
                    {
                        Success = true,
                        Msg = "Đăng nhập thành công",
                        Data = generateJWTToken(result),
                        IsConfirm = result.IsConfirmed

                    };
                }
                    
            }
            return new
            {
                Success = false,
                Msg = "Tên đăng nhập hoặc mật khẩu không đúng",
                Data = "",
                IsConfirm = false


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
        
        public object tryConfirm(string token, string UrlFrontEnd)
        {
            var acc = Context.Accounts.FirstOrDefault(p => p.Token == token);
            if(acc != null)
            {
                if (acc.IsConfirmed == true)
                {
                    return new
                    {
                        status = true,
                        msg = "Tài khoản của bạn đã được xác nhận trước đó."
                    };
                }
                if (DateTime.Compare(DateTime.UtcNow, (DateTime)acc.ExpiredTokenTime) <= 0)
                {
                    acc.ExpiredTokenTime = DateTime.MaxValue;
                    acc.Token = "";
                    acc.IsConfirmed = true;
                    Context.Accounts.Update(acc);
                    Context.SaveChanges();
                    return new
                    {
                        status = true,
                        msg = "Xác nhận thành công"
                    };
                }
                else
                {
                    acc.ExpiredTokenTime = DateTime.UtcNow.AddMinutes(15);
                    acc.Token = Helper.RandomString(64);
                    Context.Accounts.Update(acc);
                    Context.SaveChanges();
                    var content = $"Đường dẫn xác nhận tài khoản của bạn là: {UrlFrontEnd + acc.Token} có thời gian hiệu lực trong 15p.";
                    var subject = $"Xác nhận tài khoản Teyvat Scent";
                    Helper.SendMail(acc.Email, content, subject);
                    return new
                    {
                        status = false,
                        msg = "Xác nhận không thành công. Đường dẫn hết hạn. Đường dẫn mới đã đc gửi tới email bạn."
                    };
                }
                

            }
            return new
            {
                status = false,
                msg = "Xác nhận không thành công. Sai đường dẫn."
            };
        }
        

        public string generateJWTToken(AccountStaff account)
        {
            var jwtHandler = new JwtSecurityTokenHandler();
            var secretKeyBytes = Encoding.UTF8.GetBytes(Configuration["JWT:Key"]);
            var roles = Context.StaffRoles.Include(p => p.role).Where(p => p.IDStaff == account.IDStaff && p.IsDelete == false);
            var listRole = new List<Claim>();
            foreach (var item in roles)
            {
                var role = new Claim(ClaimTypes.Role, item.role.RoleName);
                listRole.Add(role);

            }
            var Subject = new ClaimsIdentity(new[]
                    {
                    new Claim(ClaimTypes.Email, account.Email),
                    new Claim(ClaimTypes.Name, account.UserName),
                    new Claim(ClaimTypes.NameIdentifier, account.IDStaff),
                });
            Subject.AddClaims(listRole);

            var tokenDescription = new SecurityTokenDescriptor
            {
                Subject = Subject
                ,
                
                Expires = DateTime.UtcNow.AddDays(30),
                SigningCredentials = new SigningCredentials(new SymmetricSecurityKey(secretKeyBytes), SecurityAlgorithms.HmacSha256Signature),

            };
            var token = jwtHandler.CreateToken(tokenDescription);
            return jwtHandler.WriteToken(token);
        }

        public object ValidateAdmin(LogInModel logIn)
        {
            var result = Context.AccountStaffs
                .FirstOrDefault(p => p.UserName == logIn.UserName);

            if (result != null)
            {

                var hasedPass = Helper.Hash(logIn.Pass + result.IDStaff);

                if (hasedPass.SequenceEqual(result.Password))
                {
                    if (result.IsConfirmed == false)
                    {
                        var expiredTime = (DateTime)result.ExpiredTokenTime;

                        if (DateTime.Compare(DateTime.UtcNow, expiredTime.AddMinutes(-14)) >= 0)
                        {
                            result.ExpiredTokenTime = DateTime.UtcNow.AddMinutes(15);
                            result.Token = Helper.RandomString(64);
                            Context.AccountStaffs.Update(result);
                            Context.SaveChanges();
                            var content = $"Đường dẫn xác nhận tài khoản nhân viên của bạn là: {logIn.UrlFrontEnd + result.Token} có thời gian hiệu lực trong 15p.";
                            var subject = $"Xác nhận tài khoản nhân viên Teyvat Scent";
                            Helper.SendMail(result.Email, content, subject);

                        }
                        return new
                        {
                            Success = false,
                            Msg = "Tài khoản của bạn chưa được xác nhận. Một email mới đã được gửi tới yêu cầu xác nhận và có hiệu lực trong 15p",
                            Data = "",
                            IsConfirm = false,
                            

                        };
                    }
                    return new
                    {
                        Success = true,
                        Msg = "Đăng nhập thành công",
                        Data = generateJWTToken(result),
                        IsConfirm = result.IsConfirmed,
                        IsDelete = result.IsDelete

                    };
                }

            }
            return new
            {
                Success = false,
                Msg = "Tên đăng nhập hoặc mật khẩu không đúng",
                Data = "",
                IsConfirm = false


            };
        }

        public object AddAdminAccount(SignUpModel signUp)

        {
            var check = Context.AccountStaffs.FirstOrDefault(p => p.Email == signUp.Email || p.UserName == signUp.UserName);
            if (check == null)
                
            {
                var role = Context.Roles.FirstOrDefault(p => p.RoleName == "Staff");
                var id = Helper.RandomString(64);
                var staffRole = new StaffRole()
                {
                    IdRole = role.IdRole,
                    IDStaff = id,
                    IsDelete = false

                };
                
                var pass = Helper.RandomString(7);
                var newAccount = new AccountStaff()
                {
                    IDStaff = id,
                    Email = signUp.Email,
                    UserName = signUp.UserName,
                    Password = Helper.Hash(pass + id),
                    Token = Helper.RandomString(64),
                    IsConfirmed = false,
                    ExpiredTokenTime = DateTime.UtcNow.AddMinutes(15),
                    StaffRoles = new List<StaffRole>()
                };
                newAccount.StaffRoles.Add(staffRole);
                Context.AccountStaffs.Add(newAccount);
                Context.SaveChanges();
                
                var content = $"Đường dẫn xác nhận tài khoản nhân viên của bạn là: {signUp.UrlFrontEnd + newAccount.Token} với mật khẩu là {pass} có thời gian hiệu lực trong 15p.";
                var subject = $"Xác nhận tài khoản nhân viên Teyvat Scent";
                Helper.SendMail(signUp.Email, content, subject);
                return new
                {
                    Status = true,
                    msg = "Đăng kí thành công. Mã xác nhận đã gửi tới email bạn"
                };
            }
            return new
            {
                Status = false,
                msg = "Đăng kí không thành công. Trùng tên đăng nhập hoặc mật khẩu."
            };




        }
        public object tryConfirmAdmin(string token, string UrlFrontEnd)
        {
            var acc = Context.AccountStaffs.FirstOrDefault(p => p.Token == token);
            if (acc != null)
            {
                if (acc.IsConfirmed == true)
                {
                    return new
                    {
                        status = true,
                        msg = "Tài khoản của bạn đã được xác nhận trước đó."
                    };
                }
                if (DateTime.Compare(DateTime.UtcNow, (DateTime)acc.ExpiredTokenTime) <= 0)
                {
                    acc.ExpiredTokenTime = DateTime.MaxValue;
                    acc.Token = "";
                    acc.IsConfirmed = true;
                    Context.AccountStaffs.Update(acc);
                    Context.SaveChanges();
                    return new
                    {
                        status = true,
                        msg = "Xác nhận thành công"
                    };
                }
                else
                {
                    acc.ExpiredTokenTime = DateTime.UtcNow.AddMinutes(15);
                    acc.Token = Helper.RandomString(64);
                    Context.AccountStaffs.Update(acc);
                    Context.SaveChanges();
                    var content = $"Đường dẫn xác nhận tài khoản nhân viên của bạn là: {UrlFrontEnd + acc.Token} có thời gian hiệu lực trong 15p.";
                    var subject = $"Xác nhận tài khoản nhân viên Teyvat Scent";
                    Helper.SendMail(acc.Email, content, subject);
                    return new
                    {
                        status = false,
                        msg = "Xác nhận không thành công. Đường dẫn hết hạn. Đường dẫn mới đã đc gửi tới email bạn."
                    };
                }


            }
            return new
            {
                status = false,
                msg = "Xác nhận không thành công. Sai đường dẫn."
            };
        }
        public object ValidateGoogle(SignUpModel logIn)
        {
            var result = Context.Accounts.FirstOrDefault(p => p.Email == logIn.Email);

            if (result == null)
            {
                var id = Helper.RandomString(64);
                result = new Account()
                {
                    Email = logIn.Email,
                    UserName = logIn.UserName,
                    Password = Helper.Hash(Helper.RandomString(64)),
                    IsConfirmed = true,
                    IsDelete = false
                    
                };
                Context.Accounts.Add(result);
                Context.SaveChanges();
                
                

            }

            return new
            {
                Success = true,
                Msg = "Đăng nhập thành công",
                Data = generateJWTToken(result),
                IsConfirm = result.IsConfirmed


            };
            
        }
        public object ForgotPassword(string emai)
        {
            var acc = Context.Accounts.FirstOrDefault(p => p.Email == emai);
            if(acc == null)
            {
                return new
                {
                    Success = false,
                    Msg = "Không có tài khoản của bạn.",

                };
            }
            var randomPass = Helper.RandomString(7);
            var newPass = Helper.Hash(randomPass+ acc.IdAccount );
            acc.Password = newPass;
            Context.Accounts.Update(acc);
            Context.SaveChanges();
            var content = $"Mật khẩu mới của bạn là: {randomPass} có thời gian hiệu lực trong 15p.";
            var subject = $"Xác nhận tài khoản nhân viên Teyvat Scent";
            Helper.SendMail(acc.Email, content, subject);
            return new
            {
                Success = true,
                Msg = "Đã gửi tin nhắn kèm mật khẩu mới của bạn.",

            };
        }
        public object ForgotAdminPassword(string emai)
        {
            var acc = Context.AccountStaffs.FirstOrDefault(p => p.Email == emai);
            if (acc == null)
            {
                return new
                {
                    Success = false,
                    Msg = "Không có tài khoản của bạn.",

                };
            }
            var randomPass = Helper.RandomString(7);
            var newPass = Helper.Hash(randomPass + acc.IDStaff);
            acc.Password = newPass;
            Context.AccountStaffs.Update(acc);
            Context.SaveChanges();
            var content = $"Mật khẩu mới cho tài khoản nhân viên của bạn là: {randomPass} có thời gian hiệu lực trong 15p.";
            var subject = $"Xác nhận tài khoản nhân viên Teyvat Scent";
            Helper.SendMail(acc.Email, content, subject);
            return new
            {
                Success = true,
                Msg = "Đã gửi tin nhắn kèm mật khẩu mới của bạn.",

            };
        }

    }
}
