using Microsoft.EntityFrameworkCore;

namespace ScentApi2.Model
{
    public class DataContext:DbContext
    {
        public DataContext(DbContextOptions<DataContext> options) : base(options) { }

        public DbSet<Account> Accounts { get; set; }
        public DbSet<Product> Products { get; set; }
        public DbSet<Category> Categories { get; set; }
        
        //public DbSet<AccountStaff> AccountStaffs { get; set; }

        public DbSet<Cart> Carts { get; set; }
        public DbSet<ProductCart> ProductCarts { get; set; }

        public DbSet<AccountAddress> AccountAddresses { get; set; }
        public DbSet<Address> Addresses { get; set; }




        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);
            //Cart
            modelBuilder.Entity<Cart>()
                .Property(p => p.IDAccount);
            modelBuilder.Entity<Cart>()
                .HasMany(p => p.ProductCarts)
                .WithOne(p => p.Cart)
                .HasForeignKey(p => p.IDCart);
            modelBuilder.Entity<Product>()
                .HasMany(p => p.ProductCarts)
                .WithOne(p => p.Product)
                .HasForeignKey(p => p.IDProduct)
                .OnDelete(DeleteBehavior.Cascade);
            modelBuilder.Entity<ProductCart>()
                .HasKey(p => new { p.IDProduct, p.IDCart });
            modelBuilder.Entity<Account>().
                HasMany(p => p.Carts)
                .WithOne(p => p.Account)
                .HasForeignKey(p => p.IDAccount);

            //Cate-Product
            modelBuilder.Entity<Category>()
                .HasMany(c => c.Products)
                .WithOne(c => c.Category)
                .HasForeignKey(p => p.IdCategory)
                .OnDelete(DeleteBehavior.Cascade);

            
                
            //Address-Account
            modelBuilder.Entity<AccountAddress>()
                .HasKey(p => new { p.IDAccount, p.IDAddress });
            modelBuilder.Entity<Address>()
                .HasMany(p=>p.AccountAddress)
                .WithOne(p => p.Address)
                .HasForeignKey(p => p.IDAddress);
            modelBuilder.Entity<Account>()
                .HasMany(p => p.AccountAddresses)
                .WithOne(p => p.Account)
                .HasForeignKey(p => p.IDAccount);


            //modelBuilder.Entity<Cart>().ToTable("Cart").HasKey(p => p.IDCart);
            
        }
    }
}
