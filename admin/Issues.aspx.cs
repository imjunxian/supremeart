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

        public string getIssueData()
        {
            string data = "";
            string userRole = "";
            try
            {
                SqlConnection con = new SqlConnection(cs);

                string sql = @"SELECT Issue.*, Account.* FROM Issue INNER JOIN Account ON Account.Id = Issue.userId";
                SqlCommand cmd = new SqlCommand(sql, con);
                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    int id = reader.GetInt32(0);
                    string name = reader["username"].ToString();
                    string date = reader["date"].ToString();
                    string iss = reader["issues"].ToString();
                    string email = reader["email"].ToString();
                    string phone = reader["phone_number"].ToString();
                    string getrole = reader["roles"].ToString();
                    
                    if(getrole == "B")
                    {
                        userRole = "Buyer";
                    }
                    else if (getrole == "S")
                    {
                        userRole = "Seller";
                    }

                    data += @"<tr>" +
                                   "<td>" + userRole + "</td>" +
                                   "<td>" + name + "</td>" +
                                   "<td>" + email + "</td>" +
                                   "<td>" + phone + "</td>" +
                                   "<td>" + date + "</td>" +
                                   "<td>" + iss + "</td>" +
                                   "<td>" +
                                    
                                   "<button type='button' id=" + id + " runat='server' class='deleteBtn btn btn-sm btn-danger' onclick='qqq(this)'><i class='fa fa-trash' style='font-size:14px;'></i></button>" +
                                   "</td>" +
                            "</tr>";



                }
            }
            catch (Exception ex)
            {
                litResult.Text = "<p class='alert alert-danger'>Something went wrong. Please try again</p>";
            }

            return data;
        }

        protected void deleteBtn_Click(object sender, EventArgs e)
        {
            try
            {
                string delid = inputDelete.Value;

                string delsql = "DELETE FROM Issue WHERE Id = @Id";

                SqlConnection conn = new SqlConnection(cs);
                SqlCommand cmd = new SqlCommand(delsql, conn);
                cmd.Parameters.AddWithValue("@Id", delid);

                conn.Open();

                cmd.ExecuteNonQuery();

                conn.Close();

                Session["status"] = "<p class='alert alert-success'>Reported Issue Deleted Successfully</p>";

                Response.Redirect("Issues.aspx?issuedeleted");
            }
            catch (Exception ex)
            {
                litResult.Text = "<p class='alert alert-danger'>Something went wrong. Please try again</p>";
            }

        }
    }
}