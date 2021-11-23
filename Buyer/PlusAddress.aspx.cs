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
    public partial class PlusAddress : System.Web.UI.Page
    {
        private static string cs = Global.CS;
        private SqlConnection con = new SqlConnection(cs);
        protected void Page_Load(object sender, EventArgs e)
        {

            if (Session["custID"] == null)
            {
                Response.Redirect("../Login.aspx");
            }
        }

        protected void btnChange_Click(object sender, EventArgs e)
        {
            string custId = Session["custId"].ToString();

            string add = txtAddress.Text;
            string pos = txtPostal.Text;
            string city = txtCity.Text;
            string state = ddstate.Text;
            string getrole = label.SelectedValue;// B or S
            
            if(add == "")
            {
                litResult.Text = "<p class='alert alert-danger'>Address is required.<p>";
            }
            else if(pos == "")
            {
                litResult.Text = "<p class='alert alert-danger'>PostCode is required.<p>";
            }
            else if (city == "")
            {
                litResult.Text = "<p class='alert alert-danger'>City is required.<p>";
            }
            else if (state == "")
            {
                litResult.Text = "<p class='alert alert-danger'>State is required.<p>";
            }
            else if (getrole == "")
            {
                litResult.Text = "<p class='alert alert-danger'>Address Type is required.<p>";
            }
            else
            {
                string sql = "INSERT INTO Address(customerId, add1, city, state, postcode, type) VALUES (@CustomerId, @add1, @city, @state, @postcode, @type)";

                SqlConnection con = new SqlConnection(cs);
                SqlCommand cmd = new SqlCommand(sql, con);

                cmd.Parameters.AddWithValue("@CustomerId", custId);
                cmd.Parameters.AddWithValue("@add1", add);
                cmd.Parameters.AddWithValue("@city", city);
                cmd.Parameters.AddWithValue("@state", state);
                cmd.Parameters.AddWithValue("@postcode", pos);
                cmd.Parameters.AddWithValue("@type", getrole);

                con.Open();
                cmd.ExecuteNonQuery(); //insert,delete,update

            
                Session["Success"] = "<p class='alert alert-success'>The Address is Added</p>";
                Response.Redirect("Profile.aspx");

                con.Close();
            }

        }
    }
}