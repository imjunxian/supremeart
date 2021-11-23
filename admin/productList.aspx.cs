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
    public partial class productList : System.Web.UI.Page
    {
        string cs = Global.CS;
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

     

        public string getProductData()
        {

            string productData = "";
            try
            {
                SqlConnection con = new SqlConnection(cs);
                SqlCommand cmd = con.CreateCommand();
                cmd.CommandText = @"SELECT Product.*, Seller.name FROM Product INNER JOIN Seller ON Seller.id = Product.SellerID";
                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    string id = reader["id"].ToString();
                    string sellname = reader.GetString(11);
                    string cat = reader["category"].ToString();
                    string name = reader["name"].ToString();
                    string prodImg = reader["imagePath"].ToString();
                    int qtt = reader.GetInt32(6);
                    double price = Math.Round(Double.Parse(reader["price"].ToString()), 2);
                    string desc = reader["description"].ToString();


                    productData += @"<tr>" +
                                   "<td><img src='../Storage/ProductImage/" + prodImg + "' alt='productImage' height='150px' width='150px'/></td>" +
                                   "<td>" + name + "</td>" +
                                   "<td>" + price + "</td>" +
                                   "<td>" + qtt + "</td>" +
                                   "<td>" + sellname + "</td>" +
                                   "<td>" + cat + "</td>" +
                                   "<td>" + desc + "</td>" +
                                    "<td>" +
                                   "<a ID='editBtn' class='btn btn-sm btn-primary' href='editProduct.aspx?id=" + id + "'><i class='fa fa-edit' style='font-size:12px;'></i></a>" +
                                  
                                   "</td>" +
                            "</tr>";

                }
                con.Close();
            }
            catch (SqlException ex)
            {
                productData += "<p class='alert alert-danger'>Something went wrong. Please try again</p>";
            }
            catch (Exception ex)
            {
                productData += "<p class='alert alert-danger'>Something went wrong. Please try again</p>";
            }

            return productData;
        }



        protected void deleteBtn_Click(object sender, EventArgs e)
        {
            try
            {
                string delid = inputDelete.Value;

                string delsql = "DELETE FROM Product WHERE Id = @prodId";

                SqlConnection conn = new SqlConnection(cs);
                SqlCommand cmd = new SqlCommand(delsql, conn);
                cmd.Parameters.AddWithValue("@prodId", delid);

                conn.Open();

                cmd.ExecuteNonQuery();

                conn.Close();

                Session["status"] = "<p class='alert alert-success'>Product Deleted Successfully</p>";
                Response.Redirect("productList.aspx");
            }
            catch(Exception ex)
            {
                litResult.Text = "<p class='alert alert-danger'>Something went wrong. Please try again</p>";
            }
            
        }
    }
}