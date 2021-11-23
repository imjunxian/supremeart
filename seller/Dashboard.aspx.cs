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
    public partial class Dashboard : System.Web.UI.Page
    {
        string cs = Global.CS;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
               

                if (Session["sellerId"] != null)
                {
                    try
                    {
                        String id = Session["sellerId"].ToString();
                        SqlConnection prodcon = new SqlConnection(cs);
                        SqlCommand prodCount = prodcon.CreateCommand();
                        prodCount.CommandText = @"SELECT COUNT(*) FROM Product WHERE SellerID='" + id + "'";
                        prodcon.Open();
                        Int32 prodRow = (Int32)prodCount.ExecuteScalar();
                        lbltotalprod.Text = prodRow.ToString();
                        prodcon.Close();


                        SqlConnection precon = new SqlConnection(cs);
                        SqlCommand preCount = precon.CreateCommand();
                        preCount.CommandText = @"SELECT COUNT(*) FROM Product WHERE SellerID='" + id + "' AND category='Premium'";
                        precon.Open();
                        Int32 preRow = (Int32)preCount.ExecuteScalar();
                        lbltotalPre.Text = preRow.ToString();
                        precon.Close();

                        SqlConnection bacon = new SqlConnection(cs);
                        SqlCommand basicCount = bacon.CreateCommand();
                        basicCount.CommandText = @"SELECT COUNT(*) FROM Product WHERE SellerID='" + id + "' AND category='Basic'";
                        bacon.Open();
                        Int32 basicRow = (Int32)basicCount.ExecuteScalar();
                        lbltotalBasic.Text = basicRow.ToString();
                        bacon.Close();

                        
                        SqlConnection ordercon = new SqlConnection(cs);
                        SqlCommand orderCount = ordercon.CreateCommand();
                        //orderCount.CommandText = @"SELECT COUNT(*) FROM CustOrder INNER JOIN  WHERE sellid='" + id + "'";
                        orderCount.CommandText = @"SELECT COUNT(*) FROM Orders
                                                    INNER JOIN OrderedItem ON OrderedItem.orderId = Orders.orderId
                                                    INNER JOIN Customer ON Customer.id = Orders.CustomerId
                                                    INNER JOIN Product ON Product.Id = OrderedItem.productId
                                                    INNER JOIN Seller ON Seller.id = Product.SellerID
                                                    WHERE Seller.id='"+id+"'";
                        ordercon.Open();
                        Int32 orderRow = (Int32)orderCount.ExecuteScalar();
                        lbltotalOrder.Text = orderRow.ToString();
                        ordercon.Close();
                    }
                    catch (Exception ex)
                    {
                        litError.Text = "<p class='alert alert-danger'>Something went wrong.</p>";
                    }
                    
                }
               
                
            }
            
        }

        
    }
}