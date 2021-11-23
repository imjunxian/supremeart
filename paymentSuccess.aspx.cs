using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Net.Mail;
using System.IO;
namespace SupremeArt
{
    public partial class paymentSuccess : System.Web.UI.Page
    {
        private static string cs = Global.CS;
        private SqlConnection con = new SqlConnection(cs);
        private SqlCommand cmd;
        private SqlDataReader reader;

        private string custId;
        private string paymentId;
        private string name;
        private string email;
        private string[] cartID;

        public string orderDateTime = DateTime.Now.ToString("dddd, dd MMMM yyyy HH:mm:ss");
        public DateTime now = DateTime.Now;
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["paymentStatus"] = "success";
            if (Session["custId"] != null)
            {
                cartID = (string[])Session["item"];
                custId = Session["custId"].ToString();
                getUserAndOrderDetails(custId);
                addOrder();
            }


        }

        private string generateOrderID()
        {
            Random r = new Random();
            int num = r.Next(10000, 99999);
            return num.ToString();
        }
        private void addOrder()
        {
            string[] itemid = (string[])Session["item"];
            double total = Math.Round(Double.Parse(Session["total"].ToString()), 2);
            double subtotal = Math.Round(Double.Parse(Session["subtotal"].ToString()), 2);
            double discount = Math.Round(Double.Parse(Session["discount"].ToString()), 2);
            double deliveryFee = Math.Round(Double.Parse(Session["totaldelivery"].ToString()), 2);
            string paymentMethod = Session["method"].ToString();
            string custID = Session["custId"].ToString();
            string status = "Processing";

            string orderId = "ORD_" + DateTime.Now.ToString("MMddyyyy") + generateOrderID();

            string addordersql = "Insert into orders (orderid,customerid,subtotal,delivery,discount,total,paymentMethod,orderDate,status,time) VALUES (@orderid,@custid,@subtotal,@delivery,@discount,@total,@paymentMethod,@orderDate,@status,@now)";
            cmd = new SqlCommand(addordersql, con);
            cmd.Parameters.AddWithValue("@orderid", orderId);
            cmd.Parameters.AddWithValue("@custid", custId);
            cmd.Parameters.AddWithValue("@subtotal", subtotal);
            cmd.Parameters.AddWithValue("@delivery", deliveryFee);
            cmd.Parameters.AddWithValue("@discount", discount);
            cmd.Parameters.AddWithValue("@total", total);
            cmd.Parameters.AddWithValue("@paymentMethod", paymentMethod);
            cmd.Parameters.AddWithValue("@orderDate", orderDateTime);
            cmd.Parameters.AddWithValue("@status", status);
            cmd.Parameters.AddWithValue("@now", now);
            con.Open();
            int addorder = cmd.ExecuteNonQuery();
            con.Close();
            if (addorder > 0)
            {


                //remove item from cart
                //add item to iem database
                //add payment to payment database
                //generate receipt
                //email
                //update Stock
                //1, update payment
                updatePayment(orderId, total, paymentMethod);
                //2.add item into ordereditem table
                bool addordereditem = AddOrderItem(orderId);
                if (addordereditem)
                {
                    //if added,remove item from cart

                    removeItemFromCart();


                    //send email
                    generateEmail(orderId,total);

                    Session["paymentStatus"] = "success";
                }

            }

        }

        private void updatePayment(string orderid, double amount, string method)
        {
            paymentId = String.Empty;
            string paymentsql = "Insert Into Payment (paymentId,orderid,amount,paytime,method) VALUES(@paymentid,@orderid,@amount,@paytime,@method)";
            string paymentid = "PAY_" + DateTime.Now.ToString("MMddyyyy") + generateOrderID();
            paymentId = paymentid;
            con.Open();
            cmd = new SqlCommand(paymentsql, con);
            cmd.Parameters.AddWithValue("@paymentid", paymentid);
            cmd.Parameters.AddWithValue("@orderid", orderid);
            cmd.Parameters.AddWithValue("@amount", amount);
            cmd.Parameters.AddWithValue("@paytime", orderDateTime);
            cmd.Parameters.AddWithValue("@method", method);

            cmd.ExecuteNonQuery();
            con.Close();

        }

        private void removeItemFromCart()
        {
            string[] itemid = (string[])Session["item"];
            string sql = "DELETE FROM Cart Where id=@id";
            con.Open();
            for (int i = 0; i < cartID.Length; i++)
            {

                cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("@id", cartID[i]);
                cmd.ExecuteNonQuery();
            }
            con.Close();

        }



        private bool AddOrderItem(string orderid)
        {

            string getProductDetails = "SELECT * FROM Cart Where id=@id";




            string[] deliveryFeeArr = (string[])Session["delivery"];
            string[] priceArr = (string[])Session["price"];

            List<String> productid = new List<string>();
            List<int> qtylist = new List<int>();
            con.Open();
            // retrieve item details from cart and copy to ordereditem table
            for (int i = 0; i < cartID.Length; i++)
            {
                string productID = "";
                double price = 0;
                int qty = 0;
                double delivery = 0;
                cmd = new SqlCommand(getProductDetails, con);
                cmd.Parameters.AddWithValue("@id", cartID[i]);
                reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    productID = reader["productId"].ToString();
                    productid.Add(productID);

                    qty = Int32.Parse(reader["qty"].ToString());
                    qtylist.Add(qty);

                }
                reader.Close();

            }
            con.Close();

            string[] productIDArr = productid.ToArray();
            int[] qtyArr = qtylist.ToArray();

            //retrieve item seller
            List<string> sellerlist = new List<string>();
            string getSeller = "SELECT sellerID from Product where id = @prodID ";
            con.Open();
            for (int i = 0; i < productIDArr.Length; i++)
            {
                string thisSeller = "";
                cmd = new SqlCommand(getSeller, con);
                cmd.Parameters.AddWithValue("@prodID", productIDArr[i]);
                reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    thisSeller = reader["sellerid"].ToString();
                    sellerlist.Add(thisSeller);

                }
                reader.Close();
            }
            con.Close();
            string[] seller = sellerlist.ToArray();




            // move item to ordereditem table
            string status = "Order Received";
            string additem = "INSERT INTO ordereditem (orderid,customerId,productid,sellerid,qty,price,delivery,orderDate,status,time) VALUES (@orderid,@custid,@productid,@sellerid,@qty,@price,@delivery,@orderDate,@status,@time)";
            int insert = 0;
            bool inserted = false;
            con.Open();
            for (int i = 0; i < cartID.Length; i++)
            {
                cmd = new SqlCommand(additem, con);
                cmd.Parameters.AddWithValue("@orderid", orderid);
                cmd.Parameters.AddWithValue("@custid", custId);
                cmd.Parameters.AddWithValue("@productid", productIDArr[i]);
                cmd.Parameters.AddWithValue("@sellerid", seller[i]);
                cmd.Parameters.AddWithValue("@qty", qtyArr[i]);
                cmd.Parameters.AddWithValue("@price", Double.Parse(priceArr[i]));
                cmd.Parameters.AddWithValue("@delivery", Double.Parse(deliveryFeeArr[i]));
                cmd.Parameters.AddWithValue("@orderDate", orderDateTime);
                cmd.Parameters.AddWithValue("@status", status);
                cmd.Parameters.AddWithValue("@time", now.ToString("yyyy/MM/dd"));

                insert = cmd.ExecuteNonQuery();

            }
            con.Close();
            if (insert > 0)
            {
                inserted = true;
                updateStock(productIDArr, qtyArr);

            }

            return inserted;


        }

        private void updateStock(string[] productid, int[] qty)
        {


            string updatestock = "Update Product SET stock = stock - @qty Where id = @prodid";
            con.Open();
            for (int i = 0; i < productid.Length; i++)
            {
                cmd = new SqlCommand(updatestock, con);
                cmd.Parameters.AddWithValue("@qty", qty[i]);
                cmd.Parameters.AddWithValue("@prodid", productid[i]);
                cmd.ExecuteNonQuery();
            }
            con.Close();


        }

        private void getUserAndOrderDetails(string custid)
        {
             name = String.Empty;
            email = String.Empty;
            string namesql = "Select name,email from customer where id=@custid";
            con.Open();
            cmd = new SqlCommand(namesql, con);
            cmd.Parameters.AddWithValue("@custid", custid);
            reader = cmd.ExecuteReader();
            if (reader.Read()){
                name = reader["name"].ToString();
                email = reader["email"].ToString();
            }
            reader.Close();
            con.Close();
            

        }
     

        //email function
        protected void sendEmail(string message)
        {
            MailMessage mailMessage = new MailMessage("supremeartwad@gmail.com", this.email);
            mailMessage.Subject = "Payment Receipt";
            
            mailMessage.Body = message;
            mailMessage.IsBodyHtml = true;

            SmtpClient smtpClient = new SmtpClient("smtp.gmail.com", 587);
            smtpClient.UseDefaultCredentials = false;
            smtpClient.Credentials = new System.Net.NetworkCredential()
            {
                UserName = "supremeartwad@gmail.com",
                Password = "wadrsd4."
            };
            smtpClient.EnableSsl = true;

            smtpClient.Send(mailMessage);
        }

        private void generateEmail(string orderid,double amount)
        {
            string body = string.Empty;
            StreamReader sreader = new StreamReader(Server.MapPath("~/invoiceTemplate.html"));
            body = sreader.ReadToEnd();
            body = body.Replace("{{name}}", name);
            body = body.Replace("{{order_id}}",orderid);
            body = body.Replace("{{date}}",orderDateTime);
            body = body.Replace("{{paymentID}}",paymentId);
            body = body.Replace("{{amount}}",String.Format("{0:0.00}",amount));
            body = body.Replace("{{total}}", String.Format("{0:0.00}", amount));

            sendEmail(body);

        }
    }
}