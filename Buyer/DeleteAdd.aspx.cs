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

namespace SupremeArt.Buyer
{
    public partial class DeleteProfile : System.Web.UI.Page
    {
        private static string cs = Global.CS;
        private SqlConnection con = new SqlConnection(cs);
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!Page.IsPostBack)
            {
                string userID = Request.QueryString["ID"];

                string sql = @"DELETE From Address Where CustomerID = @ID";

                SqlConnection con = new SqlConnection(cs);
                SqlCommand cmd = new SqlCommand(sql, con);

                cmd.Parameters.AddWithValue("@ID", userID);
                

                con.Open();
                cmd.ExecuteNonQuery(); //insert,delete,update
                Session["Success"] = "<p class='alert alert-success'>The Address is Deleted</p>";
                Response.Redirect("Profile.aspx");
                con.Close();
              



            }
        }
    }
}