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
    public partial class Issues : System.Web.UI.Page
    {
        string cs = Global.CS;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                if (Session["status"] != null)
                {
                    litResult.Text = Session["status"].ToString();
                }
                Session["status"] = null;
            }
        }

        protected void btnInsert_Click(object sender, EventArgs e)
        {
            try
            {
                string id = Session["custId"].ToString();
                string iss = issue.Text.Trim();
                string date = DateTime.Now.ToString();

                if (iss == "")
                {
                    this.litResult.Text = "<p class='alert alert-danger'>Issue is required to send</p>";
                }
                else
                {
                    SqlConnection con = new SqlConnection(cs);
                    string sql = @"INSERT INTO Issue(userId, issues, date) VALUES(@userid, @issue, @date)";

                    SqlCommand cmd = new SqlCommand(sql, con);

                    cmd.Parameters.AddWithValue("@userid", id);
                    cmd.Parameters.AddWithValue("@issue", iss);
                    cmd.Parameters.AddWithValue("@date", date);

                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();

                    Session["status"] = "<p class='alert alert-success'>Issue Reported Successfully</p>";
                    Response.Redirect("Issues.aspx?issuereported");
                }
            }
            catch(Exception ex)
            {
                litResult.Text = "<p class='alert alert-danger'>Something went wrong. Please try again</p>";
            }
        }
    }
}