using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SupremeArt
{
    public partial class paymentFail : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["paymentStatus"] = "Payment failed due to some issues ! Please try again later ";
        }
    }
}