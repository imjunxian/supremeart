using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

namespace SupremeArt.Buyer
{
    public partial class updateCart : System.Web.UI.Page
    {
        private static string cs = Global.CS;
        private  SqlConnection con = new SqlConnection(cs);
        private  SqlCommand cmd;
        private SqlDataReader rd;
        private  SqlDataAdapter dta;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                int itemid = Int32.Parse(Request.QueryString["id"]);
                int qty = Int32.Parse(Request.QueryString["qty"]);
                updateQty(itemid, qty);
            }
        }

        private int getItemStock(int id)
        {
            string sql = "SELECT productID from Cart where id = " + id;
            con.Open();
            cmd = new SqlCommand(sql,con);
            rd = cmd.ExecuteReader();
            string productId = "";
            if (rd.Read())
            {
                productId = rd["ProductID"].ToString();
                rd.Close();
            }
            string checkStock = "SELECT stock FROM Product Where id = @prodid";
           
            cmd = new SqlCommand(checkStock, con); 
            cmd.Parameters.AddWithValue("@prodid", productId);
            rd = cmd.ExecuteReader();
            int stock = 0;
            if (rd.Read())
            {
                stock = Int32.Parse(rd["stock"].ToString());
                rd.Close();
            }
            con.Close();
            return stock;

        }
        private void updateQty(int id,int qty)
        {
            int getStock = getItemStock(id);
            if(qty <= getStock)
            {
                string sql = "Update Cart Set qty=" + qty + "WHERE id = " + id;
                cmd = new SqlCommand(sql, con);
                con.Open();
                int update = (int)cmd.ExecuteNonQuery();
                con.Close();
                if(update > 0)
                {
                    Session["cartUpdateStat"] = "Item quantity updated";
                    Response.Redirect("Cart.aspx");
                }
            }
            else
            {
                Session["cartUpdateStat"] = "Order quantity must not more than stock";
                Response.Redirect("Cart.aspx");
            }
           
            

        }
    }
}