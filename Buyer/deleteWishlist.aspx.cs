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
    public partial class deleteWishlist : System.Web.UI.Page
    {
        string cs = Global.CS;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
              
                    string delid = Request.QueryString["id"] ?? "";

                    string delsql = "DELETE FROM Wishlist WHERE Id = @Id";

                    SqlConnection conn = new SqlConnection(cs);
                    SqlCommand cmd = new SqlCommand(delsql, conn);
                    cmd.Parameters.AddWithValue("@Id", delid);

                    conn.Open();

                    cmd.ExecuteNonQuery();

                    conn.Close();

                    Session["status"] = "<p class='alert alert-success'>Removed Successfully</p>";

                    Response.Redirect("Wishlist.aspx?removed");
                
           
            }
        }
    }
}