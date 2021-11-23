using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;

namespace SupremeArt.Buyer
{
    public partial class orderDetails : System.Web.UI.Page
    {
        private static string cs = Global.CS;
        private SqlConnection con = new SqlConnection(cs);
        private SqlCommand cmd;
        private SqlDataAdapter dta;
        private SqlDataReader reader;
        protected void Page_Load(object sender, EventArgs e)
        {
            if(Session["custId"] == null)
            {
                Response.Redirect("~/Login.aspx");
            }
            else
            {
                bindOrderDetails();
                bindItem();
            }

        }

        private void bindOrderDetails()
        {
            string orderid = Request.QueryString["orderid"];
            string ordersql = "SELECT * FROM ORDERS WHERE orderid = @orderid ";
            cmd = new SqlCommand(ordersql, con);

            con.Open();
            cmd.Parameters.AddWithValue("@orderid", orderid);
            dta = new SqlDataAdapter(cmd);
            DataTable table = new DataTable();
            dta.Fill(table);
            reference.DataSource = table;
            reference.DataBind();
            
            con.Close();
        }

        private void bindItem()
        {
            string orderid = Request.QueryString["orderid"];
            string selectallitem = @"SELECT ordereditem.id as id,ordereditem.price as price,ordereditem.qty as qty, ordereditem.status as status,product.price as prodprice,
product.name as name,product.imagePath as image  FROM ordereditem inner join product on ordereditem.productid = product.id WHERE ordereditem.orderid = @orderid ORDER BY time DESC";


            cmd = new SqlCommand(selectallitem, con);

            con.Open();
            cmd.Parameters.AddWithValue("@orderid",orderid);
            dta = new SqlDataAdapter(cmd);
            DataTable table = new DataTable();
            dta.Fill(table);
            itemRepeater.DataSource = table;
            itemRepeater.DataBind();
            con.Close();
        }
    }
}