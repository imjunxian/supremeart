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
    public partial class Wishlist : System.Web.UI.Page
    {
        private static string cs = Global.CS;
        private SqlConnection con = new SqlConnection(cs);
        private SqlCommand cmd;
        private SqlDataAdapter dta;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                if (Session["status"] != null)
                {
                    litResult.Text = Session["status"].ToString();
                }
                Session["status"] = null;

                if (Session["custId"] != null)
                {
                    string id = Session["custId"].ToString();
                    BindWishList(id);

                    SqlConnection prodcon = new SqlConnection(cs);
                    SqlCommand prodCount = prodcon.CreateCommand();
                    prodCount.CommandText = @"SELECT COUNT(*) FROM Wishlist WHERE CustomerID='" + id + "'";
                    prodcon.Open();
                    Int32 prodRow = (Int32)prodCount.ExecuteScalar();
                    num.Text = prodRow.ToString();
                    prodcon.Close();
                }

               
            }
        }
        private void BindWishList(string id)
        {
            string sql = "SELECT Wishlist.*,Product.imagePath as image,Product.name FROM Wishlist inner join product on Wishlist.ProductID = product.Id WHERE Wishlist.CustomerID = '"+id+"'";
            cmd = new SqlCommand(sql, con);

            con.Open();
            dta = new SqlDataAdapter(cmd);
            DataTable table = new DataTable();
            dta.Fill(table);
            WishListRepeater.DataSource = table;
            WishListRepeater.DataBind();
        }

    }
}