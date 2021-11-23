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
    public partial class Profile : System.Web.UI.Page
    {
        private static string cs = Global.CS;
        private SqlDataReader reader;
        private SqlConnection con = new SqlConnection(cs);
        private SqlCommand cmd;
        private SqlDataAdapter dta;

        protected int count = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["custID"] == null)
            {
                Response.Redirect("../Login.aspx");
            }


            if (!Page.IsPostBack)
            {
                addAddress.InnerHtml = "";
                if (Session["Success"] != null)
                {
                    passResult.Text = Session["Success"].ToString();
                }

                
                Session["Success"] = null;

                if(Session["noAddress"] != null)
                {
                    noaddress.InnerHtml = Session["noAddress"].ToString();
                }
                Session["noAddress"] = null;


                string custId = Session["custId"].ToString();

                string userID = Request.QueryString["ID"];
                userid.InnerText = custId;

                BindAdd(custId);


                string uname = "";
                string nme = "";
                string eml = "";
                string mem = "";
                string pho = "";
                //retrieve the customer record from database
                string sql = "SELECT * FROM Customer Where Id = '" + custId + "'";



                //enstablish conncetion btw web app with the databse
                SqlConnection con = new SqlConnection(cs);
                SqlCommand cmd = new SqlCommand(sql, con);


                //open database connection
                con.Open();

                SqlDataReader dr = cmd.ExecuteReader();

                //data reader

                while (dr.Read())
                {

                    nme += string.Format("{0}",
                        dr["name"]);
                    eml += string.Format("{0}",
                        dr["email"]);
                    uname += string.Format("{0}",
                        dr["username"]);
                    mem += string.Format("{0}", dr["membership"]);
                    pho += string.Format("{0}", dr["phone_number"]);

                }


                dr.Close();
                con.Close();

                name.Text = nme;
                email.Text = eml;
                username.Text = uname;
                litMembership.Text = mem;
                contact.Text = pho;
            }
        }

        private int checkEmail(String email, String id)
        {
            SqlConnection con = new SqlConnection(cs);
            string query = "SELECT COUNT(*) FROM Customer WHERE email = '" + email + "' AND id != '" + id + "'";
            SqlCommand cmd = new SqlCommand(query, con);
            con.Open();
            int count = (int)cmd.ExecuteScalar();
            con.Close();
            return count;
        }

        private int checkPhone(string phone, string id)
        {
            SqlConnection con = new SqlConnection(cs);
            string query = "SELECT COUNT(*) FROM Customer WHERE phone_number = '" + phone + "' AND id != '" + id + "'";
            SqlCommand cmd = new SqlCommand(query, con);
            con.Open();
            int count = (int)cmd.ExecuteScalar();
            con.Close();
            return count;
        }

        private void updateStat(string id, string email, string contact)
        {

            string sql = @"UPDATE Account SET email= @email, phone_number = @contact WHERE id=@Id";

            SqlConnection con = new SqlConnection(cs);
            SqlCommand cmd = new SqlCommand(sql, con);

            cmd.Parameters.AddWithValue("@email", email);
            cmd.Parameters.AddWithValue("@contact", contact);
            cmd.Parameters.AddWithValue("@Id", id);

            con.Open();
            cmd.ExecuteNonQuery(); //insert,delete,update
            con.Close();
        }


        protected void btnInsert_Click(object sender, EventArgs e)
        {  
            //check if page contains error?
            if (Page.IsValid)
            {

                string custId = Session["custId"].ToString();

                string userID = Request.QueryString["ID"];
                userid.InnerText = userID;


                string cname = name.Text;
                string cemail = email.Text;
                string ccontact = contact.Text;

                int emailExists = checkEmail(cemail, custId);
                int phoneExists = checkPhone(ccontact, custId);

                if (cname == "")
                {
                    passResult.Text = "<p class='alert alert-danger'>Name is required.</p>";
                }
                else if (cemail == "")
                {
                    passResult.Text = "<p class='alert alert-danger'>Email is required.</p>";
                }
                else if (ccontact == "")
                {
                    passResult.Text = "<p class='alert alert-danger'>Phone No is required.</p>";
                }
                else
                {
                    if(emailExists > 0)
                    {
                        passResult.Text = "<p class='alert alert-danger'>Email already exists. Please try again.</p>";
                    }
                    else if (phoneExists > 0)
                    {
                        passResult.Text = "<p class='alert alert-danger'>Phone No already exists. Please try again.</p>";
                    }
                    else
                    {
                        string sql = "UPDATE Customer SET name= @name, email = @email, phone_number=@contact Where Id = '" + custId + "'";

                        SqlConnection con = new SqlConnection(cs);
                        SqlCommand cmd = new SqlCommand(sql, con);


                        cmd.Parameters.AddWithValue("@name", cname);
                        cmd.Parameters.AddWithValue("@email", cemail);
                        cmd.Parameters.AddWithValue("@contact", ccontact);

                        con.Open();
                        cmd.ExecuteNonQuery(); //insert,delete,update
                        con.Close();

                        updateStat(custId, cemail, ccontact);

                        Session["Success"] = "<p class='alert alert-success'>The Profile is Updated</p>";


                        Response.Redirect("Profile.aspx");
                    }
                }

            }
        }
       

        private void BindAdd(string id)
        {

            // SELECT[Id], [CustomerID], [add1], [postcode], [state], [city], [type] FROM[Address] WHERE CustomerID = @userid
            string sql = "SELECT COUNT (*) FROM Address WHERE CustomerID = '" + id + "'";
            cmd = new SqlCommand(sql, con);
            con.Open();
            string address = "";
            int count = (int)cmd.ExecuteScalar();
            if(count <= 0)
            {
                                    
                addAddress.InnerHtml = "<a class='btn btn-primary' href='PlusAddress.aspx'> + Add Address </a>";
            }
            else
            {
               string sqlAdd = "SELECT * FROM Address WHERE CustomerID = '" + id + "'";
                cmd = new SqlCommand(sqlAdd, con);
                reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    address = reader["add1"].ToString() + " <br/> " + reader["postcode"].ToString() + " " + reader["city"].ToString() + " <br/>" + reader["state"].ToString()+" <br/> <b>Label As:</b> <br/>"+ reader["type"].ToString();
                    shwaddress.InnerHtml = @"<b>Address:</b> <br/> <a class='btn btn-danger' href='DeleteAdd.aspx?Id=" + id + "' style='float:right' > Delete </a> <a  class='btn btn-primary' href='EditAddress.aspx' style='float:right'>Edit</a> <tr><td>" + address + "</td></tr>";
                                 
                }

                
            }
           // dta = new SqlDataAdapter(cmd);
           // DataTable table = new DataTable();
           // dta.Fill(table);
           // AddressRepeater.DataSource = table;
           // AddressRepeater.DataBind();
            con.Close();
        }

     
        
    }
}