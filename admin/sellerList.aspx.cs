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

    public partial class sellerList : System.Web.UI.Page
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

        public string getSellerData()
        {
            string sellerData = "";
            try
            {
                SqlConnection con = new SqlConnection(cs);
                SqlCommand cmd = con.CreateCommand();
                cmd.CommandText = @"SELECT * FROM Seller";
                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    string id = reader["id"].ToString();
                    string name = reader["name"].ToString();
                    string username = reader["username"].ToString();
                    string email = reader["email"].ToString();
                    string phone = reader["phone_number"].ToString();
                    string getstatus = reader["status"].ToString();
                    string status = "";
                    string total = getTotal(id);

                    if (getstatus == "active")
                    {
                        status = "<span class='badge badge-success'>" + getstatus + "</span>";
                    }
                    else
                    {
                        status = "<span class='badge badge-warning'>" + getstatus + "</span>";
                    }

                    sellerData += @"<tr>" +
                                    "<td>" + id + "</td>" +
                                   "<td>" + name + "</td>" +
                                   "<td>" + username + "</td>" +
                                   "<td>" + email + "</td>" +
                                   "<td>" + phone + "</td>" +
                                   "<td>" + total + "</td>" +
                                   "<td>" + status + "</td>" +
                                   "<td>" +
                                   "<a ID='editBtn' class='btn btn-sm btn-primary' href='editSeller.aspx?id=" + id + "'><i class='fa fa-edit' style='font-size:12px;'></i></a>" +
                                   
                                   "</td>" +
                            "</tr>";

                }
            }
            catch (Exception ex)
            {
                litResult.Text = "<p class='alert alert-danger'>Something went wrong. Please try again</p>";
            }

            return sellerData;
        }

        private string getTotal(string id)
        {
            SqlConnection con = new SqlConnection(cs);
            SqlCommand count = con.CreateCommand();
            count.CommandText = @"SELECT COUNT(*) FROM Product WHERE SellerID = '"+ id +"'";
            con.Open();
            Int32 prodRow = (Int32)count.ExecuteScalar();
            string total = prodRow.ToString();
            con.Close();
            return total;
        }

        protected void deleteBtn_Click(object sender, EventArgs e)
        {
            try
            {
                string delid = inputDelete.Value;

                string delsql = "DELETE FROM Seller WHERE id = @Id";

                SqlConnection conn = new SqlConnection(cs);
                SqlCommand cmd = new SqlCommand(delsql, conn);
                cmd.Parameters.AddWithValue("@Id", delid);

                conn.Open();

                cmd.ExecuteNonQuery();

                conn.Close();
                deleteAcc(delid);

                Session["status"] = "<p class='alert alert-success'>Seller Deleted Successfully</p>";

                Response.Redirect("sellerList.aspx?deletesuccess");
            }
            catch (Exception ex)
            {
                litResult.Text = "<p class='alert alert-danger'>Something went wrong. Please try again</p>";
            }
            
        }

        private void deleteAcc(string id)
        {
            string sql = @"DELETE FROM Account WHERE Id = @id";

            SqlConnection con = new SqlConnection(cs);
            SqlCommand cmd = new SqlCommand(sql, con);

            cmd.Parameters.AddWithValue("@id", id);
            con.Open();
            cmd.ExecuteNonQuery();


            con.Close();
        }
    }
}