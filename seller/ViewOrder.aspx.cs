using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;

namespace SupremeArt.seller
{
    public partial class ViewOrder : System.Web.UI.Page
    {
        private string sellerId;
        private static string cs = Global.CS;
        private SqlConnection con = new SqlConnection(cs);
        private SqlCommand cmd;
        private SqlDataAdapter dta;
        private SqlDataReader dr;
        protected void Page_Load(object sender, EventArgs e)
        {
            if(Session["sellerId"]!= null)
            {
                sellerId = Session["sellerId"].ToString();
                retrieveOrder();
            }
        }

        private void retrieveOrder()
        {
            // this function retrieve all order from ordered_item table that has not completed only
            string sql = "SELECT DISTINCT orderid,customerid,qty,status,orderDate,time FROM OrderedItem Where sellerId = @sellerid AND NOT status ='Completed' ORDER BY time DESC";
         
            cmd = new SqlCommand(sql, con);

            con.Open(); 
            cmd.Parameters.AddWithValue("@sellerid", sellerId);
            dta = new SqlDataAdapter(cmd);
            DataTable table = new DataTable();
            dta.Fill(table);
            ordered_repeater.DataSource = table;
            ordered_repeater.DataBind();

        }
    }
}