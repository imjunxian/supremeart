using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;

namespace SupremeArt.Buyer
{
    public partial class HomeControl : System.Web.UI.UserControl
    {
        private static string cs = Global.CS;
        private SqlConnection con = new SqlConnection(cs);
        private SqlCommand cmd;
        private SqlDataAdapter dta;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string category = Request.QueryString["category"] ?? "";
                string membership = Session["membership"].ToString();

                if(category == "all")
                {
                    BindAllProductRepeater();
                }
                else if (category == "premium")
                {
                    BindPremiumProductRepeater();
                }
                else if(category == "basic")
                {
                    BindBasicProductRepeater();
                }
                else if(category == "")
                {
                    if (membership == "Premium")
                    {
                        BindAllProductRepeater();
                    }
                    else
                    {
                        BindBasicProductRepeater();
                    }
                }
                else
                {
                    BindBasicProductRepeater();
                }
               
            }
        }

        private void BindAllProductRepeater()
        {
            string sql = "SELECT * FROM Product";
            cmd = new SqlCommand(sql, con);
            con.Open();
            dta = new SqlDataAdapter(cmd);
            DataTable table = new DataTable();
            dta.Fill(table);
            productRepeater.DataSource = table;
            productRepeater.DataBind();
        }

        private void BindBasicProductRepeater()
        {
            string sql = "SELECT * FROM Product WHERE category = 'Basic'";
            cmd = new SqlCommand(sql, con);
            con.Open();
            dta = new SqlDataAdapter(cmd);
            DataTable table = new DataTable();
            dta.Fill(table);
            productRepeater.DataSource = table;
            productRepeater.DataBind();
        }

        private void BindPremiumProductRepeater()
        {
            string sql = "SELECT * FROM Product WHERE category = 'Premium'";
            cmd = new SqlCommand(sql, con);
            con.Open();
            dta = new SqlDataAdapter(cmd);
            DataTable table = new DataTable();
            dta.Fill(table);
            productRepeater.DataSource = table;
            productRepeater.DataBind();
        }


    }
}