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
    public partial class orderList : System.Web.UI.Page
    {
        string cs = Global.CS;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["status"] != null)
                {
                    litResult.Text = Session["status"].ToString();
                }
                Session["status"] = null;
            }
        }

        public string getOrderData()
        {

            string orderData = "";
            try
            {
                SqlConnection con = new SqlConnection(cs);
                SqlCommand cmd = con.CreateCommand();
                cmd.CommandText = @"SELECT Orders.*, OrderedItem.status AS itemStatus, Product.name AS prodname, Product.SellerID AS sellid, Seller.username AS sellname, Customer.username AS custname, Address.* FROM Orders
                                    INNER JOIN OrderedItem ON Orders.orderId = OrderedItem.orderId
                                    INNER JOIN Customer ON Customer.id = Orders.CustomerId
                                    INNER JOIN Product ON Product.Id = OrderedItem.productId
                                    INNER JOIN Seller ON Seller.id = Product.SellerID
                                    INNER JOIN Address On Address.CustomerID = Customer.id ORDER BY Orders.OrderDate DESC";
                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {

                    string id = reader["orderId"].ToString();
                    string sellname = reader["sellname"].ToString();
                    string custName = reader["custname"].ToString();
                    string prodName = reader["prodname"].ToString();
                    string status = reader["itemStatus"].ToString();
                    string datetime = reader["OrderDate"].ToString();
                    string address = reader["add1"].ToString();
                    string type = reader["type"].ToString();
                    string state = reader["state"].ToString();
                    string city = reader["city"].ToString();
                    string postcode = reader["postcode"].ToString();

                    orderData += @"<tr>" +
                                   "<td>" + id + "</td>" +
                                   "<td>" + datetime + "</td>" +
                                   "<td>" + prodName + "</td>" +
                                   "<td>" + custName + "</td>" +
                                   "<td>" + type  +":<br>"+ address +"<br>"+postcode+", "+city+"<br>"+state+"</td>" +
                                   "<td>" + sellname + "</td>" +
                                   "<td><span class='badge badge-warning'>" + status + "</span></td>" +
                                   "<td>" +
                                   "<a ID='editBtn' class='btn btn-sm btn-primary' href='editOrder.aspx?id=" + id + "'><i class='fa fa-edit' style='font-size:12px;'></i></a>" +
                                   
                                   "</td>" +
                            "</tr>";

                }
                con.Close();
            }
            catch(SqlException ex)
            {
                orderData += "<p class='alert alert-danger'>Something went wrong. Please try again</p>";
            }
            catch (Exception ex)
            {
                orderData += "<p class='alert alert-danger'>Something went wrong. Please try again</p>";
            }

            return orderData;
    
        }

       
    }
}