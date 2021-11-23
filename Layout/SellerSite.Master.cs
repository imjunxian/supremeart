using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

namespace SupremeArt.Layout
{
    public partial class SellerSite : System.Web.UI.MasterPage
    {
        private static string cs = Global.CS;
        private SqlConnection con = new SqlConnection(cs);
        private SqlCommand cmd;
        private SqlDataReader reader;
        private void setUsername(string id)
        {
            string uname="";
            string sql = "SELECT username FROM seller where id ='" +id+ "'";
            cmd = new SqlCommand(sql, con);
            con.Open();
            reader = cmd.ExecuteReader();
            while (reader.Read())
            {
                uname = reader["username"].ToString();
              
            }  
            username.Text = uname;

        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                if(Session["sellLogin"] != null)
                {
                    String id = Session["sellerId"].ToString();
                    setUsername(id);
                }
                else
                {
                    Response.Redirect("../Login.aspx");
                }
            }
        }
    }
}