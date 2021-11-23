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

                    bool found = false;
                    string productname = "";
                    double price = 0;
                    int stock = 0;
                    double deliveryFee = 0;
                    int freedel = 0;
                    bool free = false;
                    string path = "";
                    string des = "";
                    string cat = "";

                    string product = Request.QueryString["id"] ?? "";

                    string sql = @"SELECT * FROM Product WHERE Id = @id";

                    con = new SqlConnection(cs);
                    cmd = new SqlCommand(sql, con);
                    cmd.Parameters.AddWithValue("@Id", product);

                    con.Open();
                    reader = cmd.ExecuteReader();

                    if (reader.Read())
                    {
                        found = true;
                        productname = reader["name"].ToString();
                        price = Math.Round(Double.Parse(reader["price"].ToString()), 2);
                        stock = Int32.Parse(reader["stock"].ToString());
                        deliveryFee = Math.Round(Double.Parse(reader["deliveryFee"].ToString()), 2);
                        des = reader["description"].ToString();
                        path = reader["imagePath"].ToString();
                        freedel = Int32.Parse(reader["freedel"].ToString());
                        cat = reader["category"].ToString();

                        imageCon.InnerHtml = "<img src='../Storage/ProductImage/" + path + "' alt='' class='img-thumbnail' id='image_preview'>";
                    }

                    prod_id.Text = product;
                    prod_name.Text = productname;
                    prod_price.Text = price.ToString();
                    prod_stock.Text = stock.ToString();
                    prod_deliveryFee.Text = String.Format("{0}", deliveryFee);
                    prod_des.Text = des;
                    //prodCat.Text = cat;
                    if (cat.Equals("Basic"))
                    {
                        prodCat.SelectedIndex = 0;
                    }
                    else
                    {
                        prodCat.SelectedIndex = 1;
                    }

                    reader.Close();
                    con.Close();

                    if (!found)
                    {
                        Response.Redirect("productList.aspx?idnotfound");
                    }
               
            }

        }

        protected void update_Click(object sender, EventArgs e)
        {

            try
            {
                string id = prod_id.Text;
                string cat = prodCat.Text;

                //parameterized query
                string sql = @"UPDATE Product SET category=@category WHERE Id=@id";

                con = new SqlConnection(cs);
                cmd = new SqlCommand(sql, con);

                cmd.Parameters.AddWithValue("@category", cat);
                cmd.Parameters.AddWithValue("@id", id);

                con.Open();
                cmd.ExecuteNonQuery();

                Session["status"] = "<p class='alert alert-success'>Product Updated Successfully</p>";

                Response.Redirect("productList.aspx?updatesuccess");

                con.Close();
            }
            catch(Exception ex)
            {
                litResult.Text = "<p class='alert alert-danger'>Something went wrong. Please try again.</p>";
            }

        }

    }
}