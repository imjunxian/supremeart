using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using System.Web.Services;
using Newtonsoft.Json;
using System.Web.Script.Services;

namespace SupremeArt.Buyer
{
    public partial class Cart : System.Web.UI.Page
    {
        private static string cs = Global.CS;
        private  SqlConnection con = new SqlConnection(cs);
        private SqlCommand cmd;
        private SqlDataAdapter dta;

        protected int count = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
               
                if (Session["custId"]!= null)
                {
                    string custID = Session["custId"].ToString();
                    BindCart(custID);
                    count = countItem(custID);
                }

                if (Session["paymentStatus"] != null)
                {
                    string paymentStatus = Session["paymentStatus"].ToString();
                    string showPayStatus = "";
                    if (paymentStatus.Equals("success"))
                    {
                       showPayStatus = "<p class='alert alert-success'><i class='bi bi-check-circle'></i> Payment made successful</p>";
                    }
                    else
                    {
                        showPayStatus = "<p class='alert alert-danger'><i class='bi bi-x-circle'></i>"+paymentStatus+"</p>";
                    }

                    payStat.InnerHtml = showPayStatus;
                    Session["paymentStatus"] = null;
                }

                //if cart has removed any item 
                if (Session["cartUpdateStat"] != null)
                {
                    string cartUpdateStat = Session["cartUpdateStat"].ToString();
                    string stat = "<p class='alert alert-primary'>" + cartUpdateStat + "</p>";
                  

                  
                 


                    cartStat.InnerHtml = stat;
                    Session["cartUpdateStat"] = null;
                }
              
            }
        }

        private void BindCart(string id)
        {
            string sql = "SELECT Cart.ID, Cart.ProductID,Cart.CustomerID,Cart.qty,Product.imagePath as image,Product.name,Product.price,Product.deliveryFee, total = Product.price*Cart.qty FROM Cart inner join product on cart.ProductID = product.Id WHERE Cart.CustomerID = '"+id+"'";
            cmd = new SqlCommand(sql, con);
            
            con.Open();
            dta = new SqlDataAdapter(cmd);
            DataTable table = new DataTable();
            dta.Fill(table);
            cartRepeater.DataSource = table;
            cartRepeater.DataBind();
            con.Close();
        }

        private int countItem(string id)
        {
            string sql = "SELECT COUNT(*) FROM Cart Where CustomerID = '"+id+"'";
            cmd = new SqlCommand(sql, con);
            con.Open();
             int getcount = (int)cmd.ExecuteScalar();
            con.Close();
            return getcount;
                
        }

        public void cartDetails()
        {
         
        }

        





    }
}