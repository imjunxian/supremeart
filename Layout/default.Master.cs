using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

namespace SupremeArt.Layout
{
    public partial class _default : System.Web.UI.MasterPage
    {
        public static string cs = Global.CS;
        public SqlConnection con = new SqlConnection(cs);
        public SqlCommand cmd;

        private string userbutton;
        public string dropdown =@" <button type='button' class='btn btn-secondary-outline dropdown-toggle' data-toggle='dropdown' aria-haspopup='true' aria-expanded='false'><i class='bi bi-person'></i>";
 
                     
                 

        public string setUsername(string id)
        {
            string username="";
            string sql = "SELECT username FROM Customer where id = '" + id + "'";
            cmd = new SqlCommand(sql, con);
            con.Open();
            SqlDataReader rd = cmd.ExecuteReader();
            while (rd.Read())
            {
                username = rd["username"].ToString();
            }
            con.Close();
            return username;
            
           //user.Text = username;
        }

        private void getCart(string id)
        {
           
            string sql = "SELECT COUNT(*) FROM CART WHERE customerID ='"+id+"'";
            cmd = new SqlCommand(sql, con);
            con.Open();
             int cart = (int)cmd.ExecuteScalar();
            if (cart <= 0)
                cart = 0;
            totalCart.InnerHtml = cart.ToString();
            con.Close();

        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                
                Session["custLoggedIn"] = true;

                if (Session["custLoggedIn"] != null)
                {

                    string id = Session["custId"].ToString();
                    //profile_link.NavigateUrl = "../buyer/Profile.aspx?ID=" + id;
                    string username = setUsername(id);
                    userbutton =dropdown+" <span>"+username+"</span></button><div class='dropdown-menu'> <a href = '../Buyer/Profile.aspx?ID="+id+"' class='dropdown-item'>Profile</a> <div class='dropdown-divider'></div><a class='dropdown-item' href='../Logout.aspx'>Logout</a></div>";
                    getCart(id);
                      
                    
                     
                  
                    //get total amount of cart

                }
                else if(Session["custLoggedIn"] == null)
                {
               
                    Response.Redirect("~\\Login.aspx");
                }

                user_.InnerHtml = userbutton;
            }
         
        }
      
    }
}