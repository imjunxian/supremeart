using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SupremeArt.seller
{
    public partial class salesReport : System.Web.UI.Page
    {
        private static string cs = Global.CS;
        private SqlConnection con = new SqlConnection(cs);
        private SqlCommand cmd;
        private SqlDataAdapter dta;
        private SqlDataReader reader;
        public DateTime datetime = DateTime.Now;
        protected void Page_Load(object sender, EventArgs e)
        {
           // date.Value = DateTime.Now.ToString("yyyy/MM/dd");
            
        }

        private void getDate()
        {
            string sql = "SELECT * FROm Ordereditem where time = @time";
            cmd = new SqlCommand(sql, con);
            cmd.Parameters.AddWithValue("@time", date.Value);
            con.Open();
            reader = cmd.ExecuteReader();
            while (reader.Read())
            {
                showdate.InnerHtml += reader["time"].ToString()+ " "+ reader["sellerid"].ToString();
            }
        }

        protected void generate_Click(object sender, EventArgs e)
        {
            if(date.Value == null)
            {
                msg.InnerHtml = "<p class='alert alert-danger'>Please Select Date</p>";
            }
            else
            {
                bool found = searchOrder();
                if (found)
                {
                    msg.InnerHtml = "<p class='alert alert-success'>Sales Found !</p>";
                    BindOrder();
                }
               
                
                else
                {
                    destroyTable();
                    msg.InnerHtml = "<p class='alert alert-danger'>No Sales Found !</p>";
                }
            }
            
        }

        private bool searchOrder()
        {
            bool found = false;
            string sellerid = Session["sellerId"].ToString();
            string search = "SELECT COUNT(*) FROM Ordereditem where sellerid = @sellerid AND time = @time";
            cmd = new SqlCommand(search, con);
            cmd.Parameters.AddWithValue("@sellerid", sellerid);
            cmd.Parameters.AddWithValue("@time", date.Value);
            con.Open();
            int count = (int)cmd.ExecuteScalar();
            if(count > 0)
            {
                found = true;
            }
            con.Close();
            return found;
        }

        private void BindOrder()
        {
            string sellerid = Session["sellerId"].ToString();
            string sql = "SELECT product.name as prodname,product.price as prodprice,* FROM ordereditem inner join product on ordereditem.productid = product.id Where ordereditem.sellerid = @sellerid AND ordereditem.time = @time" ;
            cmd = new SqlCommand(sql, con);
            cmd.Parameters.AddWithValue("@sellerid", sellerid);
            cmd.Parameters.AddWithValue("@time", date.Value);
            con.Open();
            dta = new SqlDataAdapter(cmd);
            DataTable table = new DataTable();
            dta.Fill(table);
           report.DataSource = table;
            report.DataBind();
            


        }

        private void destroyTable()
        {
            report.DataSource = null;
            report.DataBind();
        }
    }
}