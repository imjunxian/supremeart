using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SupremeArt.Layout
{
    public partial class AdminSite : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
           
            if (!Page.IsPostBack)
            {

                if (Session["admin"] == null)
                {
                     Response.Redirect("~\\AdminLogin.aspx");
                }

            }
        }
    }
}