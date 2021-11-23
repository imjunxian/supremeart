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
   
        
        
    
  
     public partial class addProduct : System.Web.UI.Page
     {

        private static string cs = Global.CS;
        private SqlConnection con = new SqlConnection(cs);
        private SqlCommand cmd;
        private SqlDataReader reader;

            
        
         protected void Page_Load(object sender, EventArgs e)
         {
            if (!IsPostBack)
            {
                if (Session["success"] != null)
                {
                    msg.Text = Session["success"].ToString();
                    
                }
                Session["success"] = null;
            }
         }

        public void clear()
        {
            prod_name.Text = null;
            stock.Text = null;
          
            desc.Text = null;
            price.Text = null;
            
        }

        private string productId(string product)
        {
            Random r = new Random();
            int num = r.Next(10000, 99999);
            product += num;
            return product;
        }
         
      
        private void addProd()
        {
            Session["success"] = null;

             string error = "<p class='alert alert-danger'>";

             string sellerId = "";

            /*aspx field */
            string prodName = "";
            int prodStock = 0;
            double prodPrice = 0;
            string descp = "";
            double deliFee = 0;
            bool freepost = freeDeli.Checked;
            int freeDelivery = 0;
            string category = "";
            /*end*/

            if (Session["sellerId"]!=null)
            {
                 sellerId = Session["SellerId"].ToString();

                if (prod_name.Text == "")
                {
                    error += "Product name cannot be empty</br>";

                }

                else if (stock.Text == "")
                {
                    error += "Stock cannot be empty</br>";
                }
                else if (price.Text == "")
                {
                    error += "Price cannot be empty</br>";
                }
                else if (!freeDeli.Checked && deliveryFee.Text == "")
                {
                    error += "Delivery Fee cannot be empty</br>";
                }
                else
                {
                    /* aspx field*/
                    prodName = prod_name.Text;
                    prodStock = int.Parse(stock.Text);
                    prodPrice = double.Parse(price.Text);
                    descp = desc.Text;
                    deliFee = double.Parse(deliveryFee.Text);
                    category = prodCat.Text;

                    freeDelivery = 1;
                    if (freepost)
                    {
                        deliFee = 0;
                        freeDelivery = 0;
                    }
                    /*end*/
                }
            }

          

            bool added = false;
            

            string[] validFile = { ".jpg",".png",".jpeg"};
            string savePath = Server.MapPath("~/Storage/ProductImage/")+sellerId;

           

           

           
           

            if (image.HasFile)
            {
                string fileName = image.FileName;
                string extension = Path.GetExtension(image.PostedFile.FileName);
                string newFileName = prodName.Trim() + extension;
                string pathName = sellerId + "\\" + newFileName;
                
                if(image.PostedFile.ContentLength > 10000000)
                {
                    error += "Maximum size of file upload is 10MB</br>";
                }
                if (!Directory.Exists(savePath))
                {
                    Directory.CreateDirectory(savePath);
                }
                


                string productID = productId(prodName.Trim());
                string sql = "Insert into Product(Id,SellerID,name,stock,price,imagePath,description,freeDel,deliveryFee,category) VALUES(@id,@sellerid,@name,@stock,@price,@imagePath,@description,@freeDel,@deliveryFee,@category)";

                cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("@id", productID);
                cmd.Parameters.AddWithValue("@sellerid",sellerId);
                cmd.Parameters.AddWithValue("@name",prodName);
                cmd.Parameters.AddWithValue("@stock",prodStock);
                cmd.Parameters.AddWithValue("@price", prodPrice);
                cmd.Parameters.AddWithValue("@imagePath",pathName);
                cmd.Parameters.AddWithValue("@description", descp);
                cmd.Parameters.AddWithValue("@freeDel", freeDelivery);
                cmd.Parameters.AddWithValue("@deliveryFee", deliFee);
                cmd.Parameters.AddWithValue("@category", category);
                con.Open();
               
                    int insert = cmd.ExecuteNonQuery();
                    if (insert > 0)
                    {
                      added = true;
                      image.SaveAs(savePath + "\\" + newFileName);
                      Session["success"] = "<p class='alert alert-success'>Product successfully added</p>";
                    Response.Redirect("addProduct.aspx");
                      clear();
                       
                    }
                    else
                    {
                      error += "Product add failed !</br>";
                    }
                    con.Close();

                
                

            }

            if (!added)
            {
                msg.Text = error;
            }

            
          
        }

        

       
         protected void submit_Click(object sender, EventArgs e)
         {
            addProd();  
         }

     }
    
}