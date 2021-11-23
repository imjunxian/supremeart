using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;

namespace SupremeArt.seller
{
    public partial class editOrder : System.Web.UI.Page
    {
        string cs = Global.CS;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                bool found = false;

                string order = Request.QueryString["id"] ?? "";
                string seller = Session["sellerId"].ToString()
;
                string sql = @"SELECT CustOrder.*,ItemsOrdered.*, Product.name AS prodname, Product.SellerID AS sellid, Seller.username AS sellname, Customer.username AS custname, Address.* FROM CustOrder
                                    INNER JOIN ItemsOrdered ON CustOrder.OrderID = ItemsOrdered.OrderID
                                    INNER JOIN Customer ON Customer.id = CustOrder.CustomerID
                                    INNER JOIN Product ON Product.Id = ItemsOrdered.item
                                    INNER JOIN Seller ON Seller.id = Product.SellerID
                                    INNER JOIN Address On Address.CustomerID = Customer.id WHERE Seller.id = @id";

                SqlConnection con = new SqlConnection(cs);
                SqlCommand cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("@Id", seller);

                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.Read())
                {
                    found = true;
                    orderID.Text = (string)dr["OrderID"];
                    orderProduct.Text = (string)dr["prodname"];
                    orderBuyer.Text = (string)dr["custname"];
                    orderAddress.Text = (string)dr["add1"];
                    orderState.Text = (string)dr["state"];
                    orderType.Text = (string)dr["type"];
                    orderPost.Text = (string)dr["postcode"];
                    orderCity.Text = (string)dr["city"];
                    orderStatus.Text = (string)dr["status"];
                    orderDate.Text = Convert.ToString(dr["date"]);
                }

                dr.Close();
                con.Close();

                if (!found)
                {
                    Response.Redirect("Dashboard.aspx?idnotfound");
                }
            }
        }

        protected void updateBtn_Click(object sender, EventArgs e)
        {
            try
            {
                string id = orderID.Text;
                string status = orderStatus.Text;
               

                //parameterized query
                string sql = @"UPDATE CustOrder SET status=@status WHERE OrderID=@Id";

                SqlConnection con = new SqlConnection(cs);
                SqlCommand cmd = new SqlCommand(sql, con);

                cmd.Parameters.AddWithValue("@status", status);
                cmd.Parameters.AddWithValue("@Id", id);

                con.Open();
                cmd.ExecuteNonQuery();


                con.Close();

                updateStatus(id, status);

                Session["status"] = "<p class='alert alert-success'>Update Successfully</p>";

                Response.Redirect("Dashboard.aspx?updatesuccess");

            }
            catch (Exception ex)
            {
                litResult.Text = "<p class='alert alert-danger'>Something went wrong. Please try again</p>";
            }

        }

        private void updateStatus(string id, string status)
        {

            string sql = @"UPDATE ItemsOrdered SET status=@status WHERE OrderID=@Id";

            SqlConnection con = new SqlConnection(cs);
            SqlCommand cmd = new SqlCommand(sql, con);

            cmd.Parameters.AddWithValue("@status", status);
            cmd.Parameters.AddWithValue("@Id", id);

            con.Open();
            cmd.ExecuteNonQuery();


            con.Close();


        }
    }
}