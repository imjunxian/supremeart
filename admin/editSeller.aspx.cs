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
    public partial class editSeller : System.Web.UI.Page
    {
        string cs = Global.CS;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                bool found = false;

                string id = Request.QueryString["Id"] ?? "";

                string sql = "SELECT * FROM seller WHERE Id = @Id";

                SqlConnection con = new SqlConnection(cs);
                SqlCommand cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("@Id", id);

                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.Read())
                {
                    found = true;
                    sellerId.Text = (string)dr["id"];
                    sellID.Value = (string)dr["id"];
                    sellerName.Text = (string)dr["name"];
                    sellerUsername.Text = (string)dr["username"];
                    sellerEmail.Text = (string)dr["email"];
                    sellerContact.Text = (string)dr["phone_number"];
                    //sellerStatus.Text = (string)dr["status"];
                    string sta = Convert.ToString(dr["status"]);
                    if (sta.Equals("active"))
                    {
                        sellerStatus.SelectedIndex = 0;
                    }
                    else
                    {
                        sellerStatus.SelectedIndex = 1;
                    }
                }

                dr.Close();
                con.Close();

                if (!found)
                {
                    Response.Redirect("sellerList.aspx?idnotfound");
                }
            }

        }

        protected void updateBtn_Click(object sender, EventArgs e)
        {
            try
            {
                string id = sellerId.Text;
                string name = sellerName.Text;
                string username = sellerUsername.Text;
                string email = sellerEmail.Text;
                string contact = sellerContact.Text;
                string status = sellerStatus.Text;

                //parameterized query
                string sql = @"UPDATE Account SET status=@status WHERE id=@Id";

                SqlConnection con = new SqlConnection(cs);
                SqlCommand cmd = new SqlCommand(sql, con);

                cmd.Parameters.AddWithValue("@status", status);
                cmd.Parameters.AddWithValue("@Id", id);

                con.Open();
                cmd.ExecuteNonQuery();


                con.Close();
                updateStat(id, status);

                Session["status"] = "<p class='alert alert-success'>Seller Updated Successfully</p>";
                Response.Redirect("sellerList.aspx?updatesuccess");
            }
            catch (Exception)
            {
                litResult.Text = "<p class='alert alert-danger'>Something went wrong. Please try again</p>";
            }
            

        }

        private void updateStat(string id, string status)
        {
            string sql = @"UPDATE Seller SET status=@status WHERE id=@Id";

            SqlConnection con = new SqlConnection(cs);
            SqlCommand cmd = new SqlCommand(sql, con);

            cmd.Parameters.AddWithValue("@status", status);
            cmd.Parameters.AddWithValue("@Id", id);

            con.Open();
            cmd.ExecuteNonQuery();


            con.Close();
            
        }
    }
}