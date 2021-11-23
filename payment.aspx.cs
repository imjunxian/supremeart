using Stripe;
using Stripe.Checkout;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;


namespace SupremeArt
{
    public partial class payment : System.Web.UI.Page
    {
        public static string sessionId;
        protected void Page_Load(object sender, EventArgs e)
        {
            if(Session["total"] == null || Session["custLoggedIn"] == null)
            {
                Response.Redirect("fail.aspx");
            }
            else
            {
                string email = Session["custemail"].ToString();
                long amount = (long)Convert.ToDouble(Request.QueryString["total"])*100;

               

                StripeConfiguration.ApiKey = "sk_test_4eC39HqLyjWDarjtT1zdp7dc";

                var options = new SessionCreateOptions
                {
                    CustomerEmail = email,
                   SuccessUrl = "https://localhost:44301/paymentSuccess.aspx",
                    CancelUrl = "https://localhost:44301/paymentFail.aspx",
                    PaymentMethodTypes = new List<string>
                {
                  "card",
                },
                    LineItems = new List<SessionLineItemOptions>
                  {
                    new SessionLineItemOptions
                    {
                      
                      Name = "Order FROM  Supreme Art",
                      Description = "Please protect your cards details!",
                     //Price = ttls,
                     Amount = amount,
                     Currency = "myr",
                      Quantity = 1,
                       
                    },
                  },
                    Mode = "payment",
                };
                var service = new SessionService();
                Session session = service.Create(options);
                Session["checkout"] = session.Id;
                sessionId = session.Id;

            }
            
           
        }

       
    }
}