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
using System.Web.Script.Services;
using System.Web.Script.Serialization;


namespace SupremeArt.seller
{
    public partial class ViewProduct : System.Web.UI.Page
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
                if (Session["sellerId"] != null)
                {
                    string sellerid = Session["sellerId"].ToString();
                    BindProduct(sellerid);
                    litResult.Text = "";
                }

                if (Session["status"] != null)
                {
                    litResult.Text = Session["status"].ToString();
                }
                Session["status"] = null;
            }
        }

        private void BindProduct(string id)
        {
            string sql = "SELECT * From Product Where SellerID ='"+id+"'";
            cmd = new SqlCommand(sql, con);

            con.Open();
            dta = new SqlDataAdapter(cmd);
            DataTable table = new DataTable();
            dta.Fill(table);
           product_repeater.DataSource = table;
           product_repeater.DataBind();
        }

        protected void deleteBtn_Click(object sender, EventArgs e)
        {
            string delid = inputDelete.Value;

            string delsql = "DELETE FROM Product WHERE Id = @prodId";

            SqlConnection conn = new SqlConnection(cs);
            SqlCommand cmd = new SqlCommand(delsql, conn);
            cmd.Parameters.AddWithValue("@prodId", delid);

            conn.Open();

            cmd.ExecuteNonQuery();

            conn.Close();

            Session["status"] = "<p class='alert alert-success'>Delete Successfully</p>";
            Response.Redirect("ViewProduct.aspx");

            
        }
    }
}