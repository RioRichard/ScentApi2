using Microsoft.EntityFrameworkCore;
using ScentApi2.Model.SideModel;
using System;
using System.Collections.Generic;
using System.Linq;

namespace ScentApi2.Model.Repository
{
    public class CartRepo : BaseRepo
    {
        public CartRepo(DataContext context) : base(context)
        {
        }
        public void AddToCart(AddCartModel productIn, string userId)
        {
            var Cart = Context.Carts.Include(p=>p.ProductCarts).FirstOrDefault(p => p.IDAccount == userId && p.IsExpired == false);
            
            if (Cart == null)
            {
                
                Cart = new Cart()
                {
                    IDAccount = userId,
                    IDCart = Guid.NewGuid(),
                    IsExpired = false,
                    ProductCarts = new List<ProductCart>()
                    
                    
                };
                Context.Carts.Add(Cart);
                Context.SaveChanges();


            };
            var product = Context.Products.FirstOrDefault(p => p.IdProduct == productIn.idProduct);
            var productCart = Cart.ProductCarts.FirstOrDefault(p => p.IDProduct == productIn.idProduct);
            if (productCart == null)
            {
                productCart = new ProductCart()
                {
                    IDCart = Cart.IDCart,
                    IDProduct = product.IdProduct,
                    Quantity = productIn.Quantity,
                    PaymentPrice = (int)product.Price,
                };
                Cart.ProductCarts.Add(productCart);
            }
            else
                productCart.Quantity++;
           
            Context.Carts.Update(Cart);
            Context.SaveChanges();

        }
    }
}
