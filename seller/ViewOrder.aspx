<%@ Page Title="" Language="C#" MasterPageFile="~/Layout/SellerSite.Master" AutoEventWireup="true" CodeBehind="ViewOrder.aspx.cs" Inherits="SupremeArt.seller.ViewOrder" %>
<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
    New Order 
    <br />
    <br />
    <br />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="server">
    <div class="container-fluid">
        <div class="card">
            <div class="card-body">
                <div id="order_table_div">
                    <table class="table table-bordered" id="order_table">
                        <thead>
                            <th>No.</th>
                            <th>OrderID</th>          
                            <th>CustomerID</th>
                            <th>Order Date</th>
                            <th>Status</th>
                            <th>Action</th>

                        </thead>
                        <tbody>
                            <asp:Repeater ID="ordered_repeater" runat="server">
                                <ItemTemplate>
                                    <tr>
                                      <td><%# Container.ItemIndex+1 %></td>
                                        <td><i class="bi-shop"></i>&emsp;<%# Eval("orderid") %></td>
                                         <td><i class="bi-shop"></i>&emsp;<%# Eval("customerid") %></td>
                                         <td><i class="bi-shop"></i>&emsp;<%# Eval("orderdate") %></td>
                                         <td  ><span class="badge-pill <%# Eval("status").ToString() == "Completed" ? "badge-success" : "badge-warning" %>"><%# Eval("status") %></span></td>
                                        <td>
                                            <a href="orderDetails.aspx?orderid=<%# Eval("orderid") %>"> <i class="bi bi-eye"></i>&emsp;View Order  </a>
                                        </td>
                                       
                                        
                                        
                                       
                                    </tr>
                                </ItemTemplate>
                            </asp:Repeater>
                           

                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
      <script>
        $(document).ready(function () {
            $('#order_table').DataTable({
                "dom": '<lf<t>ip>',
                lengthMenu: [[ 10, 25, 50, 100, -1], [ 10, 25, 50, 100, "ALL ITEMS"]]

            });

         




        })
      </script>

</asp:Content>
