using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Collections;
using System.Data;


namespace SupremeArt.Buyer
{
    
   
    public partial class checkout : System.Web.UI.Page
    {
        private static string cs = Global.CS;
        private SqlConnection con = new SqlConnection(cs);
        private SqlCommand cmd;
        private SqlDataReader reader;
        private SqlDataAdapter dta;
        protected void Page_Load(object sender, EventArgs e)
        {
            // getData();
            if (!IsPostBack)
            {
                if(Session["custId"] == null)
                {
                    Response.Redirect("Login.aspx");
                }
                else
                {
                    string custid = Session["custId"].ToString();
                    bool haveAddress = checkAddress(custid);
                    if (haveAddress)
                    { 
                        if(Session["item"] != null)
                        {
                            bool stockchange = stockChange();
                            if (stockchange)
                            {
                                Response.Redirect("Buyer/cart.aspx");

                            }
                            else
                            {
                                address.InnerHtml = getAddress(custid);
                                getCheckOutCart();
                            }
                          
                        }
                        else
                        {
                            
                            Response.Redirect("Buyer/cart.aspx");
                        }

                    }
                    else
                    {
                        Session["noAddress"] = "<p class='alert alert-danger'>Please Update your address details to proceed checkout</p>";
                        Response.Redirect("Buyer/Profile.aspx");
                    }
                   

                }
             
               
            }

        }
        protected string AddArrayParameters(SqlCommand sqlCommand, string[] array, string paramName)
        {
            /* An array cannot be simply added as a parameter to a SqlCommand so we need to loop through things and add it manually. 
             * Each item in the array will end up being it's own SqlParameter so the return value for this must be used as part of the
             * IN statement in the CommandText.
             */
            var parameters = new string[array.Length];
            for (int i = 0; i < array.Length; i++)
            {
                parameters[i] = string.Format("@{0}{1}", paramName, i);
                sqlCommand.Parameters.AddWithValue(parameters[i], array[i]);
            }

            return string.Join(", ", parameters);
        }

        private bool checkAddress(string custid)
        {
            bool found = false;
            string sql = "SELECT COUNT(*) FROM ADDRESS WHERE CustomerId = @custid";
            con.Open();
            cmd = new SqlCommand(sql, con);
            cmd.Parameters.Add("@custid", custid);
            int count = (int)cmd.ExecuteScalar();

            if(count > 0)
            {
                found = true;
            }
            con.Close();
            return found;
        }

        private string getAddress(string custid) {
            string address = "";
            string sql = "SELECT * FROM ADDRESS WHERE CustomerId = @custid";
            con.Open();
            cmd = new SqlCommand(sql, con);
            cmd.Parameters.AddWithValue("@custid", custid);
            reader = cmd.ExecuteReader();
            if (reader.Read())
            {
                address = reader["add1"].ToString() + ", " + reader["postcode"].ToString() + ", " + reader["city"].ToString() + ", " + reader["state"].ToString();
            }
            con.Close();
            return address;

        }
        

        
      
        private void getCheckOutCart()
        {
            string[] itemid = (string[])Session["item"];
           
            cmd = new SqlCommand();
            cmd.Connection = con;
            string idParameters = AddArrayParameters(cmd, itemid, "id");
            string sql = String.Format("SELECT Cart.qty,Product.imagePath as image,Product.name,Product.price,Product.deliveryFee,total = Product.price*Cart.qty FROM Cart inner join product on cart.ProductID = product.Id WHERE Cart.Id in ({0})", idParameters);
            cmd.CommandText = sql;
            
            con.Open();
            dta = new SqlDataAdapter(cmd);
            DataTable table = new DataTable();
            dta.Fill(table);
            checkoutRepeater.DataSource = table;
            checkoutRepeater.DataBind();
            reader = cmd.ExecuteReader();
          /*  while (reader.Read())
            {
                test.InnerHtml += "<tr><td>" + reader["productId"] + "</td></tr>";
            }*/
            con.Close();
            
           

        }
      

        private bool stockChange()
        {
            bool stockChange = false;
            string[] itemid = (string[])Session["item"];
            List<int> stocklist = new List<int>();
            List<int> qtyList = new List<int>();

            

            string sql = "SELECT product.stock as stock,qty FROM Cart inner join product on cart.productid = product.id where cart.id = @itemid";
            con.Open();
            for(int i = 0; i < itemid.Length; i++)
            {
                int stock = 0;
                int qty = 0;
                cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("@itemid",itemid[i]);

                reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    stock = Int32.Parse(reader["stock"].ToString());
                    qty= Int32.Parse(reader["qty"].ToString());
                    stocklist.Add(stock);
                    qtyList.Add(qty);

                }
                reader.Close();
                

            }
            con.Close();

            int[] stockArr = stocklist.ToArray();
            int[] qtyArr = qtyList.ToArray();


           

            
            List<int> changed = new List<int>();
            for(int x= 0; x<qtyArr.Length && x<stockArr.Length; x++)
            {
                if(qtyArr[x] > stockArr[x])
                {
                    changed.Add(x);
                    stockChange = true;
                }
            }
            int[] sequence = changed.ToArray();

            if (stockChange)
            {
                removeFromCart(sequence);
            }
            return stockChange;

        }

        private void removeFromCart(int[] sequence)
        {
            string[] itemid = (string[])Session["item"];
            string sql = "DELETE FROM Cart Where id = @cartid";
            con.Open();
            int delete = 0;
            for(int i = 0; i < itemid.Length; i++)
            {
                cmd = new SqlCommand(sql, con);
                
                cmd.Parameters.AddWithValue("@cartid", itemid[sequence[i]]);

                delete = cmd.ExecuteNonQuery();
                
            }
            con.Close();
            if(delete > 0)
            {
                Session["cartUpdateStat"] = "Sorry, some of your selected product's stock has been changed. Please add to cart again";
            }
        }


    }
}