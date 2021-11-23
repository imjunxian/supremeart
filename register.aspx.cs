using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

namespace SupremeArt
{

    public partial class register : System.Web.UI.Page
    {
        //today date
        public static DateTime dt = DateTime.Today;
        public string today = dt.ToString("ddMMyyyy");

        public static string cs = Global.CS;
        private SqlConnection con = new SqlConnection(cs);
        private SqlCommand cmd;

        public string error = "<p class='alert alert-danger'>";
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

        private int generateRandom()
        {
            Random r = new Random();
            int num = r.Next(10000, 99999);
            return num;

        }

        private string encryptPassword(string pass)
        {
            string encrypt = "";
            return encrypt;

        }
        private int checkUsername(string username)
        {
            string query = "SELECT COUNT(*) FROM ACCOUNT WHERE username = '" + username + "'";
            cmd = new SqlCommand(query, con);
            con.Open();
            int count = (int)cmd.ExecuteScalar();
            con.Close();
            return count;



        }

        private int checkEmail(String email)
        {
            string query = "SELECT COUNT(*) FROM ACCOUNT WHERE email = '" + email + "'";
            cmd = new SqlCommand(query, con);
            con.Open();
            int count = (int)cmd.ExecuteScalar();
            con.Close();
            return count;
        }

        private int checkPhone(string phone)
        {
            string query = "SELECT COUNT(*) FROM ACCOUNT WHERE phone_number = '" + phone + "'";
            cmd = new SqlCommand(query, con);
            con.Open();
            int count = (int)cmd.ExecuteScalar();
            con.Close();
            return count;
        }

        private string encryptPass(string pass)
        {
            string encrypted = "";
            byte[] b = System.Text.ASCIIEncoding.ASCII.GetBytes(pass);
            encrypted = Convert.ToBase64String(b);
            return encrypted;
        }
        protected void register_Click(object sender, EventArgs e)
        {

            registration();
        }

        private void registration()
        {
            string getName = name.Text;
            string getEmail = email.Text;
            string getUname = username.Text;
            string getPass = password.Text.Trim();
            string getConPass = confirm_password.Text.Trim();
            string phoneNo = phone_number.Text;
            string getRole = role.SelectedValue;// B or S

            int usernameExist = checkUsername(getUname);
            int emailExist = checkEmail(getEmail);
            int phoneExist = checkPhone(phoneNo.Trim());
            string account = "";
            string status = "active";
            string membership = "Basic";

            if (getRole == "B")
            {
                account = "Customer";
                if (usernameExist == 0 && emailExist == 0 && phoneExist == 0)
                {
                    string id = getRole + today + generateRandom();

                    string encryptedPass = encryptPass(getPass);

                    string addAccount = "Insert into ACCOUNT (id,username,email,password,phone_number,roles,status) VALUES (@id,@username,@email,@password,@phone,@roles,@status)";

                    cmd = new SqlCommand(addAccount, con);
                    cmd.Parameters.AddWithValue("@id", id);
                    cmd.Parameters.AddWithValue("@username", getUname);
                    cmd.Parameters.AddWithValue("@email", getEmail);
                    cmd.Parameters.AddWithValue("@password", encryptedPass);
                    cmd.Parameters.AddWithValue("@phone", phoneNo);
                    cmd.Parameters.AddWithValue("@roles", getRole);
                    cmd.Parameters.AddWithValue("@status", status);
                    con.Open();


                    int inserted = (int)cmd.ExecuteNonQuery();
                    con.Close();
                    if (inserted > 0)
                    {

                        int accountCreated = AddBuyer(account, id, getName, getUname, getEmail, phoneNo, status, dt, membership);
                        if (accountCreated > 0)
                        {
                            Session["register"] = "true";
                            Response.Redirect("login.aspx");
                        }
                       

                    }
                }
                else
                {
                    Session["status"] = "<p class='alert alert-danger'>User already exists. Please try another</p>";
                    Response.Redirect("register.aspx?userexists");
                }

            }
            else if (getRole == "S")
            {
                account = "Seller";
                if (usernameExist == 0 && emailExist == 0 && phoneExist == 0)
                {
                    string id = getRole + today + generateRandom();

                    string encryptedPass = encryptPass(getPass);

                    string addAccount = "Insert into ACCOUNT (id,username,email,password,phone_number,roles,status) VALUES (@id,@username,@email,@password,@phone,@roles,@status)";

                    cmd = new SqlCommand(addAccount, con);
                    cmd.Parameters.AddWithValue("@id", id);
                    cmd.Parameters.AddWithValue("@username", getUname);
                    cmd.Parameters.AddWithValue("@email", getEmail);
                    cmd.Parameters.AddWithValue("@password", encryptedPass);
                    cmd.Parameters.AddWithValue("@phone", phoneNo);
                    cmd.Parameters.AddWithValue("@roles", getRole);
                    cmd.Parameters.AddWithValue("@status", status);
                    con.Open();


                    int inserted = (int)cmd.ExecuteNonQuery();
                    con.Close();
                    if (inserted > 0)
                    {

                        int accountCreated = AddSeller(account, id, getName, getUname, getEmail, phoneNo, status, dt);
                        if (accountCreated > 0)
                        {
                            Session["register"] = "true";
                            Response.Redirect("login.aspx");
                        }
          

                    }
                }
                else
                {

                    Session["status"] = "<p class='alert alert-danger'>User already exists. Please try another</p>";
                     Response.Redirect("register.aspx?userexists");

                }

            }
            role.SelectedIndex = 0;
           
        }

        private int AddBuyer(string accountType, string id, string name, string username, string email, string phone, string status, DateTime date, string membership)
        {
           
            string insert = "Insert into " + accountType + "(id,name,username,email,phone_number,status,JoinedDate, membership) VALUES(@id,@name,@username,@email,@phone,@status,@date,@membership)";

            cmd = new SqlCommand(insert, con);
            con.Open();
            cmd.Parameters.AddWithValue("@id", id);
            cmd.Parameters.AddWithValue("@name", name);
            cmd.Parameters.AddWithValue("@username", username);
            cmd.Parameters.AddWithValue("@email", email);
            cmd.Parameters.AddWithValue("@phone", phone);
            cmd.Parameters.AddWithValue("@status", status);
            cmd.Parameters.AddWithValue("@date", date);
            cmd.Parameters.AddWithValue("@membership", membership);

            int accountCreated = (int)cmd.ExecuteNonQuery();
            con.Close();
            return accountCreated;

        }

        private int AddSeller(string accountType, string id, string name, string username, string email, string phone, string status, DateTime date)
        {

            string insert = "Insert into " + accountType + "(id,name,username,email,phone_number,status,JoinedDate) VALUES(@id,@name,@username,@email,@phone,@status,@date)";

            cmd = new SqlCommand(insert, con);
            con.Open();
            cmd.Parameters.AddWithValue("@id", id);
            cmd.Parameters.AddWithValue("@name", name);
            cmd.Parameters.AddWithValue("@username", username);
            cmd.Parameters.AddWithValue("@email", email);
            cmd.Parameters.AddWithValue("@phone", phone);
            cmd.Parameters.AddWithValue("@status", status);
            cmd.Parameters.AddWithValue("@date", date);
            
            int accountCreated = (int)cmd.ExecuteNonQuery();
            con.Close();
            return accountCreated;

        }

    }
}
