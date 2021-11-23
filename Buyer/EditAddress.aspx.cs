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
    public partial class EditAddress : System.Web.UI.Page
    {
        private static string cs = Global.CS;
        private SqlConnection con = new SqlConnection(cs);
        protected void Page_Load(object sender, EventArgs e)
        {

            if (Session["custID"] == null)
            {
                Response.Redirect("../Login.aspx");
            }

            if (!Page.IsPostBack)
            {

                string custId = Session["custId"].ToString();


                string add = "";
                string pos = "";
                string city = "";
                string state = "";
                string Label = "";



                //retrieve the customer record from database
                string sql = "SELECT * FROM Address Where CustomerId = '" + custId + "'";


                //enstablish conncetion btw web app with the databse
                SqlConnection con = new SqlConnection(cs);
                SqlCommand cmd = new SqlCommand(sql, con);


                //open database connection
                con.Open();

                SqlDataReader dr = cmd.ExecuteReader();

                //data reader

                while (dr.Read())
                {


                    add += string.Format("{0}",
                        dr["add1"]);
                    pos += string.Format("{0}",
                        dr["postcode"]);
                    city += string.Format("{0}",
                        dr["city"]);
                    state += string.Format("{0}",
                       dr["state"]);
                    Label += string.Format("{0}",
                       dr["type"]);



                }


                dr.Close();
                con.Close();

                txtAddress.Text = add;
                txtPostal.Text = pos;
                txtCity.Text = city;

                //ddstate.Text = state;
                string sta = state;
                if (sta.Equals("Johor"))
                {
                    ddstate.SelectedIndex = 0;
                }
                else if (sta.Equals("Kedah"))
                {
                    ddstate.SelectedIndex =1;
                }
                else if (sta.Equals("Kelantan"))
                {
                    ddstate.SelectedIndex =2;
                }
                else if (sta.Equals("Malacca"))
                {
                    ddstate.SelectedIndex =3;
                }
                else if (sta.Equals("Negeri Sembilan"))
                {
                    ddstate.SelectedIndex =4;
                }
                else if (sta.Equals("Pahang"))
                {
                    ddstate.SelectedIndex =5;
                }
                else if (sta.Equals("Penang"))
                {
                    ddstate.SelectedIndex =6;
                }
                else if (sta.Equals("Perak"))
                {
                    ddstate.SelectedIndex =7;
                }
                else if (sta.Equals("Perlis"))
                {
                    ddstate.SelectedIndex =8;
                }
                else if (sta.Equals("Sabah"))
                {
                    ddstate.SelectedIndex =9;
                }
                else if (sta.Equals("Sarawak"))
                {
                    ddstate.SelectedIndex =10;
                }
                else if (sta.Equals("Selangor"))
                {
                    ddstate.SelectedIndex =11;
                }
                else if (sta.Equals("Terangganu"))
                {
                    ddstate.SelectedIndex =12;
                }
                else if (sta.Equals("Kuala Lumpur"))
                {
                    ddstate.SelectedIndex =13;
                }
                else if (sta.Equals("Labuan"))
                {
                    ddstate.SelectedIndex =14;
                }
                else if (sta.Equals("Putrajaya"))
                {
                    ddstate.SelectedIndex =15;
                }

                //ddtype.Text = Label;
                string typ = Label;
                if (typ.Equals("Home"))
                {
                    ddtype.SelectedIndex =0;
                }
                else
                {
                    ddtype.SelectedIndex =1;
                }
            }

        }

        protected void btnChange_Click(object sender, EventArgs e)
        {
          
                string custId = Session["custId"].ToString();

                string add = txtAddress.Text;
                string pos = txtPostal.Text;
                string city = txtCity.Text;
                string state = ddstate.Text;
                string Label = ddtype.Text;

            if (add == "")
            {
                litResult.Text = "<p class='alert alert-danger'>Address is required.<p>";
            }
            else if (pos == "")
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
            else if (Label == "")
            {
                litResult.Text = "<p class='alert alert-danger'>Address Type is required.<p>";
            }
            else
            {

                SqlConnection con = new SqlConnection(cs);
                string sqlEdit = "UPDATE Address SET add1= @add1, city = @city, state = @state, postcode= @postcode, type= @type Where CustomerId = '" + custId + "'";
                SqlCommand cme = new SqlCommand(sqlEdit, con);


                cme.Parameters.AddWithValue("@add1", add);
                cme.Parameters.AddWithValue("@city", city);
                cme.Parameters.AddWithValue("@state", state);
                cme.Parameters.AddWithValue("@postcode", pos);
                cme.Parameters.AddWithValue("@type", Label);



                //open database connection
                con.Open();
                cme.ExecuteNonQuery(); //insert,delete,update

                Session["Success"] = "<p class='alert alert-success'>The Address is Updated</p>";
                Response.Redirect("Profile.aspx");

                con.Close();
            }



        }
    }
}