using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;

namespace SupremeArt.admin
{
    public partial class adminList : System.Web.UI.Page
    {
        string cs = Global.CS;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                if(Session["status"] != null)
                {
                    litResult.Text = Session["status"].ToString();
                }
                Session["status"] = null;
            }
        }

        public string getAdminData()
        {
            string adminData = "";
            try
            {
                SqlConnection con = new SqlConnection(cs);

                string sql = "SELECT * FROM ADMIN";
                SqlCommand cmd = new SqlCommand(sql, con);
                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    int id = reader.GetInt32(0);
                    string name = reader["adminName"].ToString();
                    string email = reader["adminEmail"].ToString();
                    string phone = reader["adminPhoneNo"].ToString();
                    string password = reader["adminPassword"].ToString();


                    adminData += @"<tr>" +
                                   "<td>" + name + "</td>" +
                                   "<td>" + email + "</td>" +
                                   "<td>" + phone + "</td>" +
                                   "<td>" +
                                   "<a ID='editBtn' class='btn btn-sm btn-primary' href='editAdmin.aspx?id=" + id + "'><i class='fa fa-edit' style='font-size:12px;'></i></a>&nbsp;" +
                                   "<button type='button' id=" + id + " runat='server' class='deleteBtn btn btn-sm btn-danger' onclick='qqq(this)'><i class='fa fa-trash' style='font-size:14px;'></i></button>" +
                                   "</td>" +
                            "</tr>";



                }
            }catch(Exception ex)
            {
                litResult.Text = "<p class='alert alert-danger'>Something went wrong. Please try again</p>";
            }
            
            return adminData;
        }

        private int checkEmail(String email)
        {
            SqlConnection con = new SqlConnection(cs);
            string query = "SELECT COUNT(*) FROM Admin WHERE adminEmail = '" + email + "'";
            SqlCommand cmd = new SqlCommand(query, con);
            con.Open();
            int count = (int)cmd.ExecuteScalar();
            con.Close();
            return count;
        }

        private int checkPhone(String phone)
        {
            SqlConnection con = new SqlConnection(cs);
            string query = "SELECT COUNT(*) FROM Admin WHERE adminPhoneNo = '" + phone + "'";
            SqlCommand cmd = new SqlCommand(query, con);
            con.Open();
            int count = (int)cmd.ExecuteScalar();
            con.Close();
            return count;
        }

        private int checkName(String name)
        {
            SqlConnection con = new SqlConnection(cs);
            string query = "SELECT COUNT(*) FROM Admin WHERE adminName = '" + name + "'";
            SqlCommand cmd = new SqlCommand(query, con);
            con.Open();
            int count = (int)cmd.ExecuteScalar();
            con.Close();
            return count;
        }


        protected void addBtn_Click(object sender, EventArgs e)
        {
            try
            {
                string name = adminName.Text.Trim();
                string email = adminEmail.Text.Trim();
                string contact = adminPhoneNo.Text.Trim();
                string pass = adminPassword.Text.Trim();
                string cpass = cpassword.Text.Trim();

                if (name == "")
                {
                    this.litResult.Text = "<p class='alert alert-danger'>Name cannot be empty</p>";
                }
                else if (email == "")
                {
                    this.litResult.Text = "<p class='alert alert-danger'>Email cannot be empty</p>";
                }
                else if (contact == "")
                {
                    this.litResult.Text = "<p class='alert alert-danger'>Contact cannot be empty</p>";
                }
                else if (pass == "")
                {
                    this.litResult.Text = "<p class='alert alert-danger'>Password cannot be empty</p>";
                }
                else if (pass != cpass)
                {
                    this.litResult.Text = "<p class='alert alert-danger'>Password Not Match</p";
                }
                else
                {

                    int emailExists = checkEmail(email);
                    int phoneExists = checkPhone(contact);
                    int nameExists = checkName(name);

                    if (nameExists > 0)
                    {
                        litResult.Text = "<p class='alert alert-danger'>Name already exists. Please try another.</p>";
                    }
                    else if (emailExists > 0)
                    {
                        litResult.Text = "<p class='alert alert-danger'>Email already exists. Please try another.</p>";
                    }
                    else if (phoneExists > 0)
                    {
                        litResult.Text = "<p class='alert alert-danger'>Phone Number already exists. Please try another.</p>";
                    }
                    else
                    {
                        SqlConnection con = new SqlConnection(cs);
                        string sql = @"INSERT INTO Admin(adminName, adminPhoneNo, adminEmail, adminPassword) VALUES(@adminName, @adminPhoneNo, @adminEmail, @adminPassword)";

                        SqlCommand cmd = new SqlCommand(sql, con);

                        cmd.Parameters.AddWithValue("@adminName", name);
                        cmd.Parameters.AddWithValue("@adminPhoneNo", contact);
                        cmd.Parameters.AddWithValue("@adminEmail", email);
                        cmd.Parameters.AddWithValue("@adminPassword", pass);

                        con.Open();
                        cmd.ExecuteNonQuery();
                        con.Close();

                        Session["status"] = "<p class='alert alert-success'>Admin Added Successfully</p>";
                        Response.Redirect("adminList.aspx?addedsuccess");
                    }
                    
                }
            }
            catch (Exception ex)
            {
                litResult.Text = "<p class='alert alert-danger'>Something went wrong. Please try again</p>";
            } 
  
                   
        }

        protected void deleteBtn_Click(object sender, EventArgs e)
        {
            try
            {
                string delid = inputDelete.Value;
 
                string delsql = "DELETE FROM Admin WHERE adminId = @Id";

                SqlConnection conn = new SqlConnection(cs);
                SqlCommand cmd = new SqlCommand(delsql, conn);
                cmd.Parameters.AddWithValue("@Id", delid);

                conn.Open();

                cmd.ExecuteNonQuery();

                conn.Close();

                Session["status"] = "<p class='alert alert-success'>Admin Deleted Successfully</p>";

                Response.Redirect("adminList.aspx");
            }
            catch (Exception ex)
            {
                litResult.Text = "<p class='alert alert-danger'>Something went wrong. Please try again</p>";
            }
            
            
        }
    }
}