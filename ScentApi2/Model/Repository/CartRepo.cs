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
            var Cart = Context.Accounts.FirstOrDefault(p => p.IdAccount == userId).Carts?.FirstOrDefault(p=>p.IsExpired==false);
            
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
            var productCart = new ProductCart()
            {
                IDCart = Cart.IDCart,
                IDProduct = product.IdProduct,
                Quantity = productIn.Quantity,
                PaymentPrice = (int)product.Price,
            };
            Cart.ProductCarts.Add(productCart);
            Context.Carts.Update(Cart);
            Context.SaveChanges();

        }
    }
}
