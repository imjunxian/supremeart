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
    public partial class orderDetails : System.Web.UI.Page
    {
        private string sellerId;
        private static string cs = Global.CS;
        private SqlConnection con = new SqlConnection(cs);
        private SqlCommand cmd;
        private SqlDataAdapter dta;
        private SqlDataReader dr;
        protected void Page_Load(object sender, EventArgs e)
        {

            if (Session["sellerId"] != null)
            {
                sellerId = Session["sellerId"].ToString();
                bindItem();

            }
            if (!Page.IsPostBack)
            { 

                if (Session["status"] != null)
                {
                    litResult.Text = Session["status"].ToString();
                }
                Session["status"] = null;
                Session["orderId"] = null;

                bool found = false;

                string order = Request.QueryString["orderid"] ?? "";

                string sql = @"SELECT *, Customer.username, OrderedItem.status AS itemStatus, Address.* FROM Orders INNER JOIN Customer ON Customer.id = Orders.CustomerId INNER JOIN OrderedItem ON Orders.orderId = OrderedItem.orderId INNER JOIN Address ON Address.CustomerID = Orders.CustomerId WHERE Orders.orderId = @order";

                SqlConnection con = new SqlConnection(cs);
                SqlCommand cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("@order", order);

                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.Read())
                {
                    found = true;
                    orderId.Text = (string)dr["orderId"];
                    customer.Text = (string)dr["username"];
                    orderDate.Text = (string)dr["OrderDate"];
                    Session["orderId"] = (string)dr["orderId"];
                    custEmail.Text = (string)dr["email"];
                    custContact.Text = (string)dr["phone_number"];
                    string address = dr["add1"].ToString();
                    string type = dr["type"].ToString();
                    string state = dr["state"].ToString();
                    string city = dr["city"].ToString();
                    string postcode = dr["postcode"].ToString();

                    orderAddress.Text = type+":<br>"+address + "<br>" + postcode + ", " + city + "<br>" + state;
                }

                dr.Close();
                con.Close();

                if (!found)
                {
                    Response.Redirect("ViewOrder.aspx?idnotfound");
                }
            }
        }

        private void bindItem()
        {
            string orderid = Request.QueryString["orderid"];

            string sql = "SELECT ordereditem.id as id,ordereditem.price as price,ordereditem.qty as qty, ordereditem.status as status,product.price as prodprice, product.name as name,product.imagePath as image  FROM ordereditem inner join product on ordereditem.productid = product.id WHERE ordereditem.orderid = '"+orderid+"'  AND ordereditem.sellerid = '"+sellerId+"' ORDER BY time DESC";
            cmd = new SqlCommand(sql, con);

            con.Open();
   

            dta = new SqlDataAdapter(cmd);
            DataTable table = new DataTable();
            dta.Fill(table);
            itemRepeater.DataSource = table;
            itemRepeater.DataBind();


        }

    }
}