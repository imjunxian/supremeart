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
    public partial class updateItemStatus : System.Web.UI.Page
    {
        private static string cs = Global.CS;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                string item = Request.QueryString["itemid"] ?? "";
                string status = Request.QueryString["status"] ?? "";
                string order = Session["orderId"].ToString();

               string state = "";

                if (status == "1")
                {
                    state += "Order Received";
                }
                else if(status == "2")
                {
                    state += "To Ship";
                }
                else if (status == "3")
                {
                    state += "Out Of Delivery";
                }
                else if (status == "4")
                {
                    state += "Item Delivered";
                }
                else if (status == "5")
                {
                    state += "Return";
                }

                SqlConnection con = new SqlConnection(cs);
                string sql = @"UPDATE OrderedItem SET status=@status WHERE Id=@Id";
                SqlCommand cmd = new SqlCommand(sql, con);

                cmd.Parameters.AddWithValue("@status", state);
                cmd.Parameters.AddWithValue("@Id", item);

                con.Open();
                int count = cmd.ExecuteNonQuery();
                if(count > 0)
                {
                    updateOrderStatus(order);
                }

                Session["status"] = "<p class='alert alert-success'>Delivery Status Updated Successfully</p>";

                string url = "../orderDetails.aspx?orderid=";
                string parm = order;
                Response.Redirect(url + parm);

                con.Close();
            }
               
            
        }

        private void updateOrderStatus(string orderid)
        {
            string sql = "SELECT status FROM ordereditem where orderid = @orderid";
            SqlConnection con = new SqlConnection(cs);
            SqlCommand cmd = new SqlCommand(sql, con);
            con.Open();
            List<string> status = new List<string>();
            cmd.Parameters.AddWithValue("@orderid",orderid);
            SqlDataReader reader;
            reader = cmd.ExecuteReader();
            while (reader.Read())
            {
                status.Add(reader["status"].ToString());
            }
            reader.Close();
            con.Close();
            string[] statusArray = status.ToArray();
            bool complete = true;
            for(int i = 0; i < statusArray.Length; i++)
            {
                if(!statusArray[i].Equals("Item Delivered"))
                {
                    complete = false;
                }
            }

            if(complete == true)
            {
                string updateOrder = "Update Orders Set status = 'completed'  where orderid = @orderid";
                cmd = new SqlCommand(updateOrder, con);
                con.Open();
                cmd.Parameters.AddWithValue("@orderid", orderid);
                cmd.ExecuteNonQuery();
                con.Close();
            }

        }
    }
}