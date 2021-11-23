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
    public partial class UpdatePassword : System.Web.UI.Page
    {
        private static string cs = Global.CS;
        private SqlConnection con = new SqlConnection(cs);
       
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }
        public string decryptPassword(string password)
        {
            byte[] b;
            string decrypt = "";
            try
            {
                b = Convert.FromBase64String(password);
                decrypt = System.Text.ASCIIEncoding.ASCII.GetString(b);

            }
            catch (Exception e)
            {
                decrypt = "";
            }
            return decrypt;
        }

        private string encryptPass(string pass)
        {
            string encrypted = "";
            byte[] b = System.Text.ASCIIEncoding.ASCII.GetBytes(pass);
            encrypted = Convert.ToBase64String(b);
            return encrypted;
        }
        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            
                string custId = Session["custId"].ToString();
                // create variable for the txtCrrPass
                string crrPass = txtCrrPass.Text.Trim();
                //create variable for the pass for database
                string pass = "";

                string sql = "SELECT password FROM Account WHERE Id = '" + custId + "'";


                //enstablish conncetion btw web app with the databse
                SqlConnection con = new SqlConnection(cs);
                SqlCommand cmd = new SqlCommand(sql, con);


                //open database connection
                con.Open();

                SqlDataReader dr = cmd.ExecuteReader();

                //data reader

                if (dr.Read())
                {
                    //particular customer id's pass variable read the info from database
                    pass = string.Format("{0}",
                        dr["password"]);

                }

               
                //decrypt the password from the database
                string decryptedpassword = decryptPassword(pass);

                dr.Close();
               


            if (crrPass != decryptedpassword)
            {
                this.lblPass.Text = "<p class='alert alert-danger'>The current password is not match with the old password</p>";


            }
            else
            {
               
                string NewPass = txtNewPass.Text;

                string encryptedPass = encryptPass(NewPass);

                String sqlUppass = "UPDATE Account SET password = @password  Where Id = '" + custId + "'";

                SqlCommand cmdd = new SqlCommand(sqlUppass, con);

                cmdd.Parameters.AddWithValue("@password", encryptedPass);
                
                
                cmdd.ExecuteNonQuery(); //insert,delete,update

                Session["Success"] = "<p class='alert alert-success'>The Password is Updated</p>";
                Response.Redirect("Profile.aspx");

                
                con.Close();

            }
            

               



            
            

           
        }
      
    }
}