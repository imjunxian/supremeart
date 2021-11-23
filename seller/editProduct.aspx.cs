using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.IO;

namespace SupremeArt.seller
{
    public partial class editProduct : System.Web.UI.Page
    {
        private static string cs = Global.CS;
        private SqlConnection con = new SqlConnection(cs);
        private SqlCommand cmd;
        private SqlDataReader reader;

        public string getPath;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {

               
                if (Request.QueryString["productid"] != "")
                {
                    string productid = Request.QueryString["productid"];
                    fetchProductData(productid);
                    if (Session["updated"] != null)
                    {
                        divmsg.InnerHtml = Session["updated"].ToString();
                    }
                    Session["updated"] = null;
                    //divmsg.InnerHtml = "<p class=' alert alert-success'>LLL</p>";

                }
            }
        }

        private void fetchProductData(string productid)
        {
            string productSQL = "SELECT * FROM Product Where id='" + productid + "'";
            cmd = new SqlCommand(productSQL, con);
            con.Open();
            string productname = "";
            double price = 0;
            int stock = 0;
            double deliveryFee = 0;
            int freedel = 0;
            bool free = false;
            string path = "";
            string des = "";
            string cat = "";
            reader = cmd.ExecuteReader();
            if (reader.Read())
            {
                productname = reader["name"].ToString();
                price = Math.Round(Double.Parse(reader["price"].ToString()),2);
                stock = Int32.Parse(reader["stock"].ToString());
                deliveryFee = Math.Round(Double.Parse(reader["deliveryFee"].ToString()),2);
                des = reader["description"].ToString();
                path = reader["imagePath"].ToString();
                freedel = Int32.Parse(reader["freedel"].ToString());
                cat = reader["category"].ToString();
            }
            else
            {
                divmsg.InnerHtml = "<p class='alert alert-danger'>Product Not Found</p>";
            }
            prod_id.Text = productid;
            prod_name.Text = productname;
            prod_price.Text = price.ToString();
            prod_stock.Text = stock.ToString();
            prod_deliveryFee.Text = String.Format("{0}",deliveryFee);
            prod_des.Text = des;
            prodCat.Text = cat;
            
            if(freedel == 0)
            {
                freeDeli.Checked = true;
                
            }
            else
            {
                freeDeli.Checked = false;
            }
           imageCon.InnerHtml = "<img src='../Storage/ProductImage/"+path+"' alt='' class='img-thumbnail' id='image_preview'>" ;

            con.Close();
        }

       

        protected void update_Click(object sender, EventArgs e)
        {
            string productid = Request.QueryString["productid"];
            string prodName = "";
            int prodStock = 0;
            double prodPrice = 0;
            string descp = "";
            double deliFee = 0;
            bool freepost = freeDeli.Checked;
            int freeDelivery = 0;
            string cat = "";

            string error = "";
            bool updated = false;

            if (prod_name.Text == "")
            {
                error += "Product name cannot be empty</br>";

            }

            else if (prod_stock.Text == "")
            {
                error += "Stock cannot be empty</br>";
            }
            else if (prod_price.Text == "")
            {
                error += "Price cannot be empty</br>";
            }
            else if (!freeDeli.Checked && prod_deliveryFee.Text == "")
            {
                error += "Delivery Fee cannot be empty</br>";
            }

            else
            {
                /* aspx field*/
                prodName = prod_name.Text;
                prodStock = int.Parse(prod_stock.Text);
                prodPrice = double.Parse(prod_price.Text);
                descp = prod_des.Text;
                deliFee = double.Parse(prod_deliveryFee.Text);
                cat = prodCat.Text;

                freeDelivery = 1;
                if (freepost)
                {
                    deliFee = 0;
                    freeDelivery = 0;
                }
                /*end*/
            }

            string updatesql = "UPDATE Product SET name=@name,stock=@stock,description=@des,deliveryFee=@deliFee,freeDel=@freedel,price=@price,category=@category WHERE id='"+productid+"'";
            cmd = new SqlCommand(updatesql, con);
            cmd.Parameters.AddWithValue("@name", prodName);
            cmd.Parameters.AddWithValue("@stock",prodStock);
            cmd.Parameters.AddWithValue("@price",prodPrice);
            cmd.Parameters.AddWithValue("@des",descp);
            cmd.Parameters.AddWithValue("@deliFee",deliFee);
            cmd.Parameters.AddWithValue("@freedel",freeDelivery);
            cmd.Parameters.AddWithValue("@category",cat);
            con.Open();
            int insert =(int) cmd.ExecuteNonQuery();
            if(insert > 0)
            {
                updated = true;
                Session["updated"] = "<p class='alert alert-success'>Product Details Updated</p>";
               
            }

            con.Close();

            if (!updated)
            {
                Session["updated"] = "< p class='alert alert-danger'>Product Not yet updated</p>";
               

            }
            Response.Redirect(HttpContext.Current.Request.Url.AbsoluteUri);
        }
    }
}