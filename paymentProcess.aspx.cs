using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SupremeArt
{
    public partial class paymentProcess : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(Session["item"] == null)
            {
                Response.Redirect("fail.aspx");
            }
            else
            {
                if (String.IsNullOrEmpty(Request.QueryString["total"]) || String.IsNullOrEmpty(Request.QueryString["method"]))
                {
                    Response.Redirect("fail.aspx");
                }
                else
                {
                   string total = Request.QueryString["total"];
                    Session["total"] = total ;
                     string method =  Request.QueryString["method"];
                    Session["method"] = method;
                    Session["discount"] = Request.QueryString["discount"];
                    Session["totaldelivery"] = Request.QueryString["totaldelivery"];
                    Session["subtotal"] = Request.QueryString["subtotal"];

                    string[] delivery = Request["delivery"].ToString().Split(',');
                    string [] price = Request["price"].ToString().Split(',');
                    Session["delivery"] = delivery;
                    Session["price"] = price;
                   
                    
                   
                   
                    switch (method)
                    {
                        case "card":
                            Response.Redirect("Payment.aspx?total="+total);
                            break;
                        case "cash":
                            Response.Redirect("success.aspx");
                            break;
                        default:
                           
                            Session["paymentStatus"] = "Invalid Payment"; 
                            Response.Redirect("Buyer/Cart.aspx");
                            break;
                    }


                }
            }
            
        }
    }
}