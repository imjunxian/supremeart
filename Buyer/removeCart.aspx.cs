using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
namespace SupremeArt.Buyer
{
    public partial class removeCart : System.Web.UI.Page
    {
        private static string cs = Global.CS;
        private SqlConnection con = new SqlConnection(cs);
        private SqlCommand cmd;
        private SqlDataAdapter dta;

        protected void Page_Load(object sender, EventArgs e)
        {
            if(Session["custId"]!= null)
            {
                deleteItem();
            }
            else
            {
                Response.Redirect("cart.aspx");
            }
        }

        private void deleteItem()
        {
            string id = Request.QueryString["cartId"];
            string sql = "DELETE FROM Cart Where id = @id";
            cmd = new SqlCommand(sql, con);
            cmd.Parameters.AddWithValue("@id", id);
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
          Session["cartUpdateStat"] = "Cart Updated"; 
            Response.Redirect("Cart.aspx");
        }
    }
}