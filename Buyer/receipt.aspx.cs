using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
namespace SupremeArt.Buyer
{
    public partial class receipt : System.Web.UI.Page


    {

        private static string cs = Global.CS;
        private SqlConnection con = new SqlConnection(cs);
        private SqlCommand cmd;
        private SqlDataAdapter dta;
        private SqlDataReader reader;
        protected void Page_Load(object sender, EventArgs e)
        {

       

            if (!IsPostBack)
            {
                if(Session["custLoggedIn"]==null || Session["custId"] == null)
                {
                    Response.Redirect("~/Login.aspx");
                }
                else
                {
                    string orderid = Request.QueryString["orderid"];
                    string custid = Session["custId"].ToString();
                    order_id.InnerHtml = orderid;
                    getOrder(orderid);
                    getCustDetails(custid);
                    BindItem(orderid);
                }
            }

        }


        private void getCustDetails(string custid)
        {
            string address = String.Empty;
            string address2 = "";
            string name = String.Empty;
            string sql = "SELECT customer.name as custname ,* FROM Address inner join customer on address.CustomerID = customer.id where address.CustomerID = @custId";
            cmd = new SqlCommand(sql, con);
            con.Open();
            cmd.Parameters.AddWithValue("@custId", custid);
            reader = cmd.ExecuteReader();
            if (reader.Read())
            {
                name = reader["custname"].ToString();
                address = reader["add1"].ToString();
                address2 = reader["postcode"].ToString() + ", " + reader["city"].ToString() + ", " + reader["state"].ToString();
            }
            reader.Close();
            con.Close();
            custname.InnerHtml = name;
            add1.InnerHtml = address;
            add2.InnerHtml = address2;

        }

        private void BindItem(string orderid)
        {

            string getItem = @"
SELECT ordereditem.price as price,ordereditem.qty as qty, ordereditem.status as status,product.price as prodprice,
product.name as prodname FROM ordereditem inner join product on ordereditem.productid = product.id WHERE ordereditem.orderid = @orderid ORDER BY time DESC";

            cmd = new SqlCommand(getItem, con);

            con.Open();
            cmd.Parameters.AddWithValue("@orderid", orderid);
            dta = new SqlDataAdapter(cmd);
            DataTable table = new DataTable();
            dta.Fill(table);
            itemRepeater.DataSource = table;
            itemRepeater.DataBind();
            con.Close();
        }

        private void getOrder(string orderid)
        {
            string order = "SELECT * FROM ORDERS WHERE orderid = @orderid ";
            string subtotal = String.Empty;
            string total = String.Empty;
            string discount = String.Empty;
            string delivery = String.Empty;
            string date = String.Empty;
            string payment = String.Empty;
            cmd = new SqlCommand(order, con);
            con.Open();
            cmd.Parameters.AddWithValue("@orderid", orderid);
            reader = cmd.ExecuteReader();
            if (reader.Read())
            {
                payment = reader["paymentMethod"].ToString();
                date = reader["orderdate"].ToString();
                subtotal = String.Format("{0:0.00}", reader["subtotal"].ToString());
                total = String.Format("{0:0.00}", reader["total"].ToString());
                discount = String.Format("{0:0.00}", reader["discount"].ToString());
                delivery = String.Format("{0:0.00}", reader["delivery"].ToString());
            }
            con.Close();
            orderdate.InnerHtml = date;
            thisSubtotal.InnerHtml = subtotal;
            ttldelivery.InnerHtml = delivery;

            ttldiscount.InnerHtml = "- " +discount;
            ttl.InnerHtml = total;
        }
    }
}