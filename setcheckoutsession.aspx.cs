using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SupremeArt
{
    public partial class setcheckoutsession : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
          
            string[] item = Request["item"].ToString().Split(',');
           
            Session["item"] = null;
            Session["item"] = item;
            string[] id = (string[])Session["item"];

            Response.Redirect("checkout.aspx");
           
        }
    }
}