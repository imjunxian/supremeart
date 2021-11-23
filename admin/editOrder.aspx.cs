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
    public partial class editOrder : System.Web.UI.Page
    {
        string cs = Global.CS;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                bool found = false;

                string order = Request.QueryString["id"] ?? "";
                
;
                string sql = @"SELECT Orders.*, OrderedItem.status AS itemStatus, Product.name AS prodname, Product.SellerID AS sellid, Seller.username AS sellname, Customer.username AS custname, Address.* FROM Orders
                                    INNER JOIN OrderedItem ON Orders.orderId = OrderedItem.orderId
                                    INNER JOIN Customer ON Customer.id = Orders.CustomerId
                                    INNER JOIN Product ON Product.Id = OrderedItem.productId
                                    INNER JOIN Seller ON Seller.id = Product.SellerID
                                    INNER JOIN Address On Address.CustomerID = Customer.id WHERE Orders.orderId = @id";

                SqlConnection con = new SqlConnection(cs);
                SqlCommand cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("@Id", order);

                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.Read())
                {
                    found = true;
                    orderID.Text = (string)dr["orderId"];
                    orderProduct.Text = (string)dr["prodname"];
                    orderBuyer.Text = (string)dr["custname"];
                    orderAddress.Text = (string)dr["add1"];
                    orderState.Text = (string)dr["state"];
                    orderType.Text = (string)dr["type"];
                    orderPost.Text = (string)dr["postcode"];
                    orderCity.Text = (string)dr["city"];
                   
                    orderDate.Text = Convert.ToString(dr["OrderDate"]);
                    //orderStatus.Text = (string)dr["itemStatus"];
                    string sta = (string)dr["itemStatus"];
                    if (sta.Equals("Order Received"))
                    {
                        orderStatus.SelectedIndex = 0;
                    }
                    else if(sta.Equals("To Ship"))
                    {
                        orderStatus.SelectedIndex = 1;
                    }
                    else if (sta.Equals("Out Of Delivered"))
                    {
                        orderStatus.SelectedIndex = 2;
                    }
                    else if (sta.Equals("Item Delivered"))
                    {
                        orderStatus.SelectedIndex = 3;
                    }
                    else if (sta.Equals("Return"))
                    {
                        orderStatus.SelectedIndex = 4;
                    }
                }

                dr.Close();
                con.Close();

                if (!found)
                {
                    Response.Redirect("orderList.aspx?idnotfound");
                }
            }
        }

        protected void updateBtn_Click(object sender, EventArgs e)
        {
            try
            {
                string id = orderID.Text;
                string status = orderStatus.Text;


           

                updateStatus(id, status);

                Session["status"] = "<p class='alert alert-success'>Order Updated Successfully</p>";

                Response.Redirect("orderList.aspx?updatesuccess");

            }
            catch (Exception ex)
            {
                litResult.Text = "<p class='alert alert-danger'>Something went wrong. Please try again</p>";
            }
        }
        private void updateStatus(string id, string status)
        {

            string sql = @"UPDATE OrderedItem SET status=@status WHERE orderId=@Id";

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