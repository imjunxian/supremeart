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
    public partial class editAdmin : System.Web.UI.Page
    {
        string cs = Global.CS;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                bool found = false;

                string id = Request.QueryString["Id"] ?? "";

                string sql = "SELECT * FROM Admin WHERE adminId = @Id";

                SqlConnection con = new SqlConnection(cs);
                SqlCommand cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("@Id", id);

                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.Read())
                {
                    found = true;
                    adminID.Value = Convert.ToString(dr["adminId"]);
                    adminName.Text = (string)dr["adminName"];
                    adminEmail.Text = (string)dr["adminEmail"];
                    adminContact.Text = (string)dr["adminPhoneNo"];

                }

                dr.Close();
                con.Close();

                if (!found)
                {
                    Response.Redirect("adminList.aspx?idnotfound");
                }
            }
        }

        private int checkEmail(String email, String id)
        {
            SqlConnection con = new SqlConnection(cs);
            string query = "SELECT COUNT(*) FROM Admin WHERE adminEmail = '" + email + "' AND adminId != '"+ id +"'";
            SqlCommand cmd = new SqlCommand(query, con);
            con.Open();
            int count = (int)cmd.ExecuteScalar();
            con.Close();
            return count;
        }

        private int checkPhone(String phone, String id)
        {
            SqlConnection con = new SqlConnection(cs);
            string query = "SELECT COUNT(*) FROM Admin WHERE adminPhoneNo = '" + phone + "' AND adminId != '" + id + "'";
            SqlCommand cmd = new SqlCommand(query, con);
            con.Open();
            int count = (int)cmd.ExecuteScalar();
            con.Close();
            return count;
        }

        private int checkName(String name, String id)
        {
            SqlConnection con = new SqlConnection(cs);
            string query = "SELECT COUNT(*) FROM Admin WHERE adminName = '" + name + "' AND adminId != '"+ id +"'";
            SqlCommand cmd = new SqlCommand(query, con);
            con.Open();
            int count = (int)cmd.ExecuteScalar();
            con.Close();
            return count;
        }

        protected void updateBtn_Click(object sender, EventArgs e)
        {
            try
            {
                string id = adminID.Value;
                string name = adminName.Text;
                string email = adminEmail.Text;
                string contact = adminContact.Text;

                int emailExists = checkEmail(email, id);
                int phoneExists = checkPhone(contact, id);
                int nameExists = checkName(name, id);

                if (name == "")
                {
                    litResult.Text = "<p class='alert alert-danger'>Name cannot be empty</p>";
                }
                else if (email == "")
                {
                    litResult.Text = "<p class='alert alert-danger'>Email cannot be empty</p>";
                }
                else if (contact == "")
                {
                    litResult.Text = "<p class='alert alert-danger'>Contact cannot be empty</p>";
                }
                else
                {
                    if (emailExists > 0)
                    {
                        litResult.Text = "<p class='alert alert-danger'>Email already exists. Please try another email.</p>";
                    }
                    else if (phoneExists > 0)
                    {
                        litResult.Text = "<p class='alert alert-danger'>Phone Number already exists. Please try another.</p>";
                    }
                    else if (nameExists > 0)
                    {
                        litResult.Text = "<p class='alert alert-danger'>Name already exists. Please try another.</p>";
                    }
                    else
                    {
                        //parameterized query
                        SqlConnection con = new SqlConnection(cs);
                        string sql = @"UPDATE Admin SET adminName=@Name, adminEmail=@email, adminPhoneNo=@contact WHERE adminId=@Id";
                        SqlCommand cmd = new SqlCommand(sql, con);
                        cmd.Parameters.AddWithValue("@Name", name);
                        cmd.Parameters.AddWithValue("@Email", email);
                        cmd.Parameters.AddWithValue("@contact", contact);
                        cmd.Parameters.AddWithValue("@Id", id);

                        con.Open();
                        cmd.ExecuteNonQuery();

                        con.Close();

                        Session["status"] = "<p class='alert alert-success'>Admin Updated Successfully</p>";

                        Response.Redirect("adminList.aspx?updatesuccess");
                    }

                }

            }
            catch(Exception ex)
            {
                litResult.Text = "<p class='alert alert-danger'>Something went wrong. Please try again</p>";
            }
            
        }
    }
}