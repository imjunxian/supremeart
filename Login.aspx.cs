using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using SupremeArt;


namespace SupremeArt
{
    public partial class Login : System.Web.UI.Page
    {
        public static string cs = Global.CS;
        public SqlConnection conn = new SqlConnection(cs);
        public SqlCommand cmd;
        public SqlDataReader reader;
        private string customerId;
        private string sellerId;
        private string email;

        private int userStatus;
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!Page.IsPostBack)
            {
                if(Session["register"]!= null)
                {
                    loginmsg.InnerHtml = "<p class='alert alert-success'>You have successfully registered an account ! Please sign in to continue</p>";
                }
                Session["register"] = null;
            }
          
        }

        protected void login_Click(object sender, EventArgs e)
        {



            loginAction();

           
            // if (String.Equals("admin", uname) && String.Equals("admin", pass))
            //{
            //    Response.AppendHeader("Refresh", "3;url=admin/Dashboard.aspx");
            //}




        }
        public string decryptPassword(string password)
        {
            byte[] b;
            string decrypt = "";
            try
            {
                b = Convert.FromBase64String(password);
                decrypt = System.Text.ASCIIEncoding.ASCII.GetString(b);

            }catch(Exception e)
            {
                decrypt = "";
            }
            return decrypt;
        }

        private bool sellerLogin(string username, string password)
        {
            bool found = false;
            string hashedPass = "";
            string status = "";
            //check from database
            string sql = "SELECT * FROM Seller WHERE username ='" + username + "'";
           
            conn = new SqlConnection(cs);
            SqlCommand cmd = new SqlCommand(sql, conn);
          
            conn.Open();
            SqlDataReader dr = cmd.ExecuteReader();
            if (dr.Read())
            {
                hashedPass = dr["password"].ToString();
                status = dr["status"].ToString();

            }
            string dehashedPass = decryptPassword(hashedPass);
            if (dehashedPass.Equals(password) && status=="active")
            {
                found = true;
               sellerId = dr["id"].ToString();
                userStatus = 0;
            }

            if(status == "barred")
            {
                userStatus = 1;
            }
            conn.Close();
            return found;
            
        }

        private bool customerLogin(string username,string password)
        {
            bool found = false;
            string hashedPass = "";
            string status = "";
            //check from database
            string sql = "SELECT * FROM Customer WHERE username ='" + username + "'";

            conn = new SqlConnection(cs);
            SqlCommand cmd = new SqlCommand(sql, conn);

            conn.Open();
            SqlDataReader dr = cmd.ExecuteReader();
            if (dr.Read())
            {
                hashedPass = dr["password"].ToString();
                status = dr["status"].ToString();
            }
            string dehashedPass = decryptPassword(hashedPass);
            if (dehashedPass.Equals(password) && status == "active")
            {
                found = true;
                customerId = dr["id"].ToString();
                userStatus = 0;
            }

            if (status == "barred")
            {
                userStatus = 1;
            }
            conn.Close();
            return found;
        }
      

        private void loginAction()
        {
            SqlDataReader dr;
            string uname = username.Text;
            string pass = password.Text;
            string hashed = "";
            string status = "";
            string roles = "";
            string userID = "";
            bool found = false;
            bool stat = false;
            string url = "";
            string membership = "";

            string verifyAccount = "SELECT * FROM ACCOUNT WHERE username = @username";
            conn.Open();
            cmd = new SqlCommand(verifyAccount, conn);
            cmd.Parameters.AddWithValue("@username", uname);
            dr = cmd.ExecuteReader();
            if (dr.Read())
            {
                userID = dr["id"].ToString();
                hashed = dr["password"].ToString();
                status = dr["status"].ToString();
                roles = dr["roles"].ToString();
				 email = dr["email"].ToString();
                
              
            }
            
            conn.Close();

            switch (status)
            {

                case "active":
                    stat = true;
                    break;
                default:
                    stat = false;
                    break;
            }
            string decryptedPass = decryptPassword(hashed);
            if(decryptedPass.Equals(pass) && stat)
            {
                switch (roles)
                {
                    case "B":
                        string getmembership = "SELECT membership from customer where id ='" + userID + "'";
                        cmd = new SqlCommand(getmembership, conn);
                        conn.Open();
                        reader = cmd.ExecuteReader();
                        if (reader.Read())
                        {
                            membership = reader["membership"].ToString();
                        }
                        
                        url = "Buyer/Home.aspx";
                        Session["custLoggedIn"] = 0;
                        Session["username"] = uname;
                        Session["membership"] = membership;
                        Session["custId"] = userID ;
						  Session["custemail"] = email;
                        
                        break;
                    case "S":
                        url = "seller/Dashboard.aspx";
                        Session["sellLogin"] = 0;
                        Session["sellerId"] = userID;
                        break;
                  

                }
                Response.Redirect(url);
            }
            if(!stat)
            {
              
                
                    loginmsg.InnerHtml = " <p class='alert alert-danger'>Your account has been barred due to some issues ! Please contact admin to unbarred  your account</p>";



            }
            if(!decryptedPass.Equals(pass))
            {
               
                    loginmsg.InnerHtml = " <p class='alert alert-danger'>Invalid username or password</p>";

                
            }


        }
    }
}
