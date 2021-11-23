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
    public partial class editCustomer : System.Web.UI.Page
    {
        string cs = Global.CS;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                bool found = false;

                string id = Request.QueryString["Id"] ?? "";

                string sql = "SELECT Customer.*, Address.* FROM Customer INNER JOIN Address ON Address.CustomerID = Customer.id WHERE Customer.Id = @Id";

                SqlConnection con = new SqlConnection(cs);
                SqlCommand cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("@Id", id);

                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.Read())
                {
                    found = true;
                    customerId.Text = (string)dr["id"];
                    custID.Value = (string)dr["id"];
                    custName.Text = (string)dr["name"];
                    custUsername.Text = (string)dr["username"];
                    custEmail.Text = (string)dr["email"];
                    custContact.Text = (string)dr["phone_number"];
                    //custStatus.Text = Convert.ToString(dr["status"]);
                    string sta = Convert.ToString(dr["status"]);
                    if (sta.Equals("active"))
                    {
                        custStatus.SelectedIndex = 0;
                    }
                    else
                    {
                        custStatus.SelectedIndex = 1;
                    }
                    string mem = (string)dr["membership"];
                    if (mem.Equals("Basic"))
                    {
                       custMembership.SelectedIndex = 0;
                    }
                    else
                    {
                        custMembership.SelectedIndex = 1;
                    }
                    orderAddress.Text = (string)dr["add1"];
                    orderState.Text = (string)dr["state"];
                    orderType.Text = (string)dr["type"];
                    orderPost.Text = (string)dr["postcode"];
                    orderCity.Text = (string)dr["city"];


                }


               

                dr.Close();
                con.Close();

                if (!found)
                {
                    Response.Redirect("custList.aspx?idnotfound");
                }
            }
        }

        protected void updateBtn_Click(object sender, EventArgs e)
        {
            try
            {
                string id = custID.Value;
                string status = custStatus.Text;
                string membership = custMembership.Text;

                //parameterized query
                string sql = @"UPDATE Account SET status=@status WHERE id=@Id";

                SqlConnection con = new SqlConnection(cs);
                SqlCommand cmd = new SqlCommand(sql, con);

                cmd.Parameters.AddWithValue("@status", status);
                cmd.Parameters.AddWithValue("@Id", id);

                con.Open();
                cmd.ExecuteNonQuery();


                con.Close();

                updateStat(id, status, membership);

                Session["status"] = "<p class='alert alert-success'>Buyer Updated Successfully</p>";

                Response.Redirect("custList.aspx?updatesuccess");

            }
            catch (Exception ex)
            {
                litResult.Text = "<p class='alert alert-danger'>Something went wrong. Please try again</p>";
            }
            

        }

        private void updateStat(string id, string status, string membership)
        {
    
             string sql = @"UPDATE Customer SET membership=@membership, status=@status WHERE id=@Id";

             SqlConnection con = new SqlConnection(cs);
             SqlCommand cmd = new SqlCommand(sql, con);

             cmd.Parameters.AddWithValue("@status", status);
             cmd.Parameters.AddWithValue("@membership", membership);
             cmd.Parameters.AddWithValue("@Id", id);

             con.Open();
             cmd.ExecuteNonQuery();


             con.Close();
            
  
        }


    }
}
