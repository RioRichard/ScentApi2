using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http.Features;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.IdentityModel.Tokens;
using Microsoft.OpenApi.Models;
using ScentApi2.Model;
using System;
using System.Text;
using System.Text.Json.Serialization;

namespace ScentApi2
{
    public class Startup
    {
        public Startup(IConfiguration configuration)
        {
            Configuration = configuration;
        }

        public IConfiguration Configuration { get; }

        // This method gets called by the runtime. Use this method to add services to the container.
        public void ConfigureServices(IServiceCollection services)
        {
            services.AddAuthentication(
                option =>{
                    option.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
                    option.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
                }
            ).AddJwtBearer(p=>{
                var key = Encoding.UTF8.GetBytes(Configuration["JWT:Key"]);
                p.SaveToken = true;
                p.TokenValidationParameters = new Microsoft.IdentityModel.Tokens.TokenValidationParameters{
                    ValidateIssuer = false,
                    ValidateAudience = false,

                    ValidateIssuerSigningKey = true,

                    IssuerSigningKey = new SymmetricSecurityKey(key),
                    ClockSkew = TimeSpan.Zero

                    
                };
            });
            services.Configure<FormOptions>(p =>
            {
                p.ValueLengthLimit = int.MaxValue;
                p.MultipartBodyLengthLimit = int.MaxValue;
                p.MemoryBufferThreshold = int.MaxValue;
            });
            
            //services.AddControllersWithViews().AddJsonOptions(p => p.JsonSerializerOptions.ReferenceHandler = System.Text.Json.Serialization.ReferenceHandler.Preserve);
            //services.AddCors(options =>
            //{
            //    options.AddDefaultPolicy(buider =>
            //    {
            //        buider.WithOrigins("https://localhost:44380/", "http://localhost:53629/")
            //        .AllowAnyHeader()
            //        .AllowAnyMethod();
            //    });
            //});
            services.AddCors();
            services.AddControllers();
           


            services.AddSwaggerGen(c =>
            {
                c.SwaggerDoc("v1", new OpenApiInfo { Title = "ScentApi2", Version = "v1" });
            });
            services.AddDbContext<DataContext>(p => p.UseSqlServer(Configuration.GetConnectionString("Data")));
                
        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
        {
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
                app.UseSwagger();
                app.UseSwaggerUI(c => c.SwaggerEndpoint("/swagger/v1/swagger.json", "ScentApi2 v1"));
            }
            app.UseCors(
                builder =>
                {
                    builder.AllowAnyOrigin().AllowAnyMethod().AllowAnyHeader();
                });
            app.UseStaticFiles();
            app.UseHttpsRedirection();
            
            app.UseRouting();

            app.UseAuthentication();

            app.UseAuthorization();

            app.UseEndpoints(endpoints =>
            {
                endpoints.MapControllers();
            });
        }
    }
}
