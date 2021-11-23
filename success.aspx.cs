using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using Stripe;
using Stripe.Checkout;

namespace SupremeArt
{
    public partial class success : System.Web.UI.Page
    {
        private static string cs = Global.CS;
        private SqlConnection con = new SqlConnection(cs);
        private SqlCommand cmd;
        private SqlDataReader reader;
        private string custId;
        private string[] cartID;
        public string orderDateTime = DateTime.Now.ToString("dddd, dd MMMM yyyy HH:mm:ss");
        public DateTime now = DateTime.Now;

        protected void Page_Load(object sender, EventArgs e)
        {
            string sessionid = Session["checkout"].ToString();
            StripeConfiguration.ApiKey = "sk_test_4eC39HqLyjWDarjtT1zdp7dc";

            var service = new SessionService();
            service.Get(
             sessionid
            );
        }
    }
}