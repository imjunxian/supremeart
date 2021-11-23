using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
namespace SupremeArt.Product
{
    public partial class ViewProduct : System.Web.UI.Page
    {
        private static string cs = Global.CS;
        private SqlConnection con = new SqlConnection(cs);
        private SqlCommand cmd;
        private SqlDataReader dr;

        private string productID;
        private string username;
      
        protected void Page_Load(object sender, EventArgs e)
        {
          
            if (!Page.IsPostBack)
            {
               
                showProduct(); 
                if(Session["msg"] != null)
                {
                    divmsg.InnerHtml = Session["msg"].ToString();
                }
                Session["msg"] = null;

              
            }
            
        }

        private void showProduct()
        {
           productID = Request.QueryString["prodID"];
            string productName = "";
            double productPrice = 0;
            double deliveryFee = 0;
            string descrip = "";
            int stock = 0;
            int freeDel = 0;
            string imagePath = "../Storage/ProductImage/";
            if (String.IsNullOrEmpty(productID))
            {
                Response.Redirect("../SupremeArt.aspx");
            }
            string sql = "SELECT * FROM Product Where Id = '" + productID + "'";
            cmd = new SqlCommand(sql, con);
            con.Open();
            dr = cmd.ExecuteReader();

            while (dr.Read())
            {
                productName = dr["name"].ToString();
                productPrice = Double.Parse(dr["price"].ToString());
                descrip = dr["description"].ToString();
                stock = (int)dr["stock"];
                imagePath += dr["imagePath"].ToString();
                freeDel = (int)dr["freeDel"];
                deliveryFee = Double.Parse(dr["deliveryFee"].ToString());


            }
            prod_image.InnerHtml = "<img src='" + imagePath + "' id='main_product_image' width='400'/>";
            prod_name.InnerHtml = productName;
            stock_label.InnerHtml = stock.ToString();
            prod_price.InnerHtml = "RM" + Math.Round(productPrice, 2);
            description.InnerHtml = descrip;
            prod_id.InnerHtml = productID;

            prod_qty.MaxLength = stock;
         
            if (freeDel == 0)
            {
                delivery.InnerHtml = "Free Delivery";
            }
            else
            {
                delivery.InnerHtml = "RM " + Math.Round((double)deliveryFee, 2);
            }

            if(stock == 0)
            {
                cart.Enabled = false;
            }
            con.Close();
            

          
        }

        private int getStock(string productid)
        {
            int stock = 0;
            string sql = "SELECT * FROM product WHERE id = @productid";
            con.Open();
            cmd = new SqlCommand(sql, con);
            cmd.Parameters.AddWithValue("@productid", productid);
            dr = cmd.ExecuteReader();
            if (dr.Read())
            {
                stock = Int32.Parse(dr["stock"].ToString());

            }
            con.Close();
            return stock;
        }

        private void updateCart()
        {
             productID = Request.QueryString["prodID"];
             username = Session["username"].ToString();

            string custID = Session["custId"].ToString();
            int qty = 0;
            int request_qty = Int32.Parse(prod_qty.Text);
            int cartID = 0;

            bool found = false;
            int updateQty = 0;

            string sql = "SELECT * FROM CART WHERE ProductID = '"+productID+"' AND CustomerID = '"+custID+"'";
            cmd = new SqlCommand(sql, con);
            con.Open();
            dr = cmd.ExecuteReader();
           
            if (dr.Read())
            {
                cartID = (int)dr["id"];
                qty = (int)dr["qty"];
                found = true;
            }
            con.Close();
            if (found)
            {
                int totalincart = qty + request_qty;
                int currentstock = getStock(productID);
                if(totalincart > currentstock)
                {
                    Session["msg"] = "<p class='alert alert-danger'>Your total quantity of this product in your cart cannot exceed the quantity stock</p>";
                    Response.Redirect(HttpContext.Current.Request.Url.AbsoluteUri);

                }
                else
                {
                    qty += request_qty;
                    con.Open();
                    string update = "Update Cart Set qty = '"+qty+"' WHERE id ='"+cartID+"'";
                    cmd = new SqlCommand(update, con);
                    updateQty = cmd.ExecuteNonQuery();
                    con.Close();
                    if (updateQty > 0)
                    {
                        
                        Session["msg"] = "<p class='alert alert-success'>Cart updated</p>";
                        Response.Redirect(HttpContext.Current.Request.Url.AbsoluteUri);
                   
                    }
                }
                

            }

            else
            {
                
                addToCart(productID,custID,request_qty);
            }
           
        }

        private void addToCart(string productID,string custID,int qty)
        {
            int stock = getStock(productID);
            if(qty > stock)
            {
                Session["msg"] = "<p class='alert alert-danger'>Cannot add the quantity that larger than stock into cart</p>";
                Response.Redirect(HttpContext.Current.Request.Url.AbsoluteUri);


            }
            else
            {
                string add = "INSERT INTO Cart(productID,customerID,qty) VALUES(@prodID,@custID,@qty)";
                cmd = new SqlCommand(add, con);
                cmd.Parameters.AddWithValue("@prodID", productID);
                cmd.Parameters.AddWithValue("@custID", custID);
                cmd.Parameters.AddWithValue("@qty", qty);
                con.Open();
            
                int insert = cmd.ExecuteNonQuery();
                if (insert > 0)
                {
                    Session["msg"] = "<p class='alert alert-success'>Items has added into cart</p>";
                    con.Close();
                    Response.Redirect(HttpContext.Current.Request.Url.AbsoluteUri);

                }

            }
          



        }

        private void addToWishList()
        {
            string message = "";
            productID = Request.QueryString["prodID"];

            string custID = Session["custId"].ToString();

            string checkExist = "SELECT COUNT(*) FROM Wishlist WHERE ProductID = '" + productID + "' AND CustomerID = '" + custID + "'";
            cmd = new SqlCommand(checkExist, con);
            con.Open();
            int exist = (int)cmd.ExecuteScalar();
            bool found = false;

            if(exist > 0)
            {
                found = true;
                message = " <p class='alert alert-danger'>Item already exist in wishlist</p>";
               
            }

            if (!found)
            {

                string add = "INSERT into Wishlist (ProductID,CustomerID) VALUES(@prodID,@custID)";
                cmd = new SqlCommand(add, con);
                cmd.Parameters.AddWithValue("@prodID", productID);
                cmd.Parameters.AddWithValue("@custID", custID);
                int insert = cmd.ExecuteNonQuery();
                if (insert > 0)
                {
                    message = "<p class='alert alert-success'>Item added into wishlist</p>";
                }
            }
            Session["msg"] = message;
           
            con.Close();
            Response.Redirect(HttpContext.Current.Request.Url.AbsoluteUri);
        }

        protected void add_Click(object sender, EventArgs e)
        {
            updateCart();
          
        }

        protected void wishlist_Click(object sender,EventArgs e)
        {
            addToWishList();
        }
    }
}
