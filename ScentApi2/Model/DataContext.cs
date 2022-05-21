using Microsoft.EntityFrameworkCore;

namespace ScentApi2.Model
{
    public class DataContext:DbContext
    {
        public DataContext(DbContextOptions<DataContext> options) : base(options) { }

        public DbSet<Account> Accounts { get; set; }
        public DbSet<Product> Products { get; set; }
        public DbSet<Category> Categories { get; set; }
        //public DbSet<AccountAddress> AccountAddresses { get; set; }
        //public DbSet<AccountStaff> AccountStaffs { get; set; }

        //public DbSet<Address> Addresses { get; set; }
        public DbSet<Cart> Carts { get; set; }
        public DbSet<ProductCart> ProductCarts { get; set; }
        


        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);
            modelBuilder.Entity<Account>().
                HasMany(p => p.Carts)
                .WithOne(p => p.Account)
                .HasForeignKey(p => p.IDAccount);

            modelBuilder.Entity<Category>()
                .HasMany(c => c.Products)
                .WithOne(c => c.Category)
                .HasForeignKey(p => p.IdCategory);
            modelBuilder.Entity<Cart>()
                .HasMany(p => p.ProductCarts);
            modelBuilder.Entity<Cart>()
                .Property(p => p.IDAccount);
            modelBuilder.Entity<Product>()
                .HasMany(p => p.ProductCarts);
            modelBuilder.Entity<ProductCart>()
                .HasKey(p => new { p.IDProduct, p.IDCart });
            modelBuilder.Entity<AccountAddress>()
                .HasKey(p => new { p.IDAccount, p.IDAddress });
            //modelBuilder.Entity<Cart>().ToTable("Cart").HasKey(p => p.IDCart);
            
        }
    }
}
