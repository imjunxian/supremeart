using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
namespace SupremeArt
{
    public partial class AdminLogin : System.Web.UI.Page
    {
        public static string cs = Global.CS;
        public SqlConnection con = new SqlConnection(cs);
        public SqlCommand cmd;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        private void adminLogin()
        {

            string uname = username.Text;
            string pass = password.Text;
            bool found = false;

            if (String.IsNullOrEmpty(uname) || String.IsNullOrEmpty(pass))
            {
                loginmsg.Text = "<p class='alert alert-danger'>Username and password cannot be blank </p>";
            }


            // loginmsg.Text = " <p class='alert alert-success'>Login Successful ! You will be redirect to the admin page soon.</p>";
            //Response.AppendHeader("Refresh", "3;url=admin/Dashboard.aspx");


            else
            {
                string sql = "SELECT COUNT(*) FROM Admin Where adminName='"+uname+"' AND adminPassword = '"+pass+"'";
                cmd = new SqlCommand(sql, con);
                con.Open();
                int count = (int)cmd.ExecuteScalar();

                if(count > 0)
                {
                    Session["admin"] = uname;
                    Session["adminLoggedIn"] = "1";
                    Response.Redirect("admin/Dashboard.aspx");
                }
                else
                {
                    loginmsg.Text = "<p class='alert alert-danger'>Invalid email or password </p>";
                }
                con.Close();
            }

        }
        protected void login_Click(object sender, EventArgs e)
        {
            adminLogin();
        }
    }
}