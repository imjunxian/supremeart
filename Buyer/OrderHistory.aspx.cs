using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using System.Web.Script.Services;
using System.Web.Script.Serialization;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
namespace SupremeArt.Buyer
{
    public partial class OrderHistory : System.Web.UI.Page
    {
        private static string cs = Global.CS;
        private SqlConnection con = new SqlConnection(cs);
        private SqlCommand cmd;
        private SqlDataAdapter dta;
        private SqlDataReader dr;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                if(Session["custId"] != null)
                {
                    string custid = Session["custId"].ToString();
                    BindOrder(custid);
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
                        showPayStatus = "<p class='alert alert-danger'><i class='bi bi-x-circle'></i>" + paymentStatus + "</p>";
                    }

                    msg.InnerHtml = showPayStatus;
                    Session["paymentStatus"] = null;
                }
            }
        }

        private void BindOrder(string custid)
        {
            string sql = "SELECT * FROM orders WHERE customerID ='"+custid+"' ORDER BY time DESC";
            cmd = new SqlCommand(sql, con);

            con.Open();
            dta = new SqlDataAdapter(cmd);
            DataTable table = new DataTable();
            dta.Fill(table);
            order_repeater.DataSource = table;
            order_repeater.DataBind();
           
           
        }
    }
}