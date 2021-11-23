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
    public partial class Dashboard : System.Web.UI.Page
    {
        string cs = Global.CS;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                try
                {
                    SqlConnection custcon = new SqlConnection(cs);
                    SqlCommand custCount = custcon.CreateCommand();
                    custCount.CommandText = @"SELECT COUNT(*) FROM Customer";
                    custcon.Open();
                    Int32 custRow = (Int32)custCount.ExecuteScalar();
                    lbltotalcust.Text = custRow.ToString();
                    custcon.Close();

                    SqlConnection sellcon = new SqlConnection(cs);
                    SqlCommand sellCount = sellcon.CreateCommand();
                    sellCount.CommandText = @"SELECT COUNT(*) FROM Seller";
                    sellcon.Open();
                    Int32 sellRow = (Int32)sellCount.ExecuteScalar();
                    lbltotalseller.Text = sellRow.ToString();
                    sellcon.Close();

                    SqlConnection prodcon = new SqlConnection(cs);
                    SqlCommand prodCount = prodcon.CreateCommand();
                    prodCount.CommandText = @"SELECT COUNT(*) FROM Product";
                    prodcon.Open();
                    Int32 prodRow = (Int32)prodCount.ExecuteScalar();
                    lbltotalprod.Text = prodRow.ToString();
                    prodcon.Close();

                    SqlConnection ordercon = new SqlConnection(cs);
                    SqlCommand orderCount = ordercon.CreateCommand();
                    orderCount.CommandText = @"SELECT COUNT(*) FROM Orders";
                    ordercon.Open();
                    Int32 orderRow = (Int32)orderCount.ExecuteScalar();
                    lbltotalOrder.Text = orderRow.ToString();
                    ordercon.Close();
                }
                catch(Exception ex)
                {
                    litError.Text = "<p class='alert alert-danger'>Something went wrong.</p>";
                }

            }
        }




    }
}