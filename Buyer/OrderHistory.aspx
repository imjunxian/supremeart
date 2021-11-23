<%@ Page Title="" Language="C#" MasterPageFile="~/Layout/default.Master" AutoEventWireup="true" CodeBehind="OrderHistory.aspx.cs" Inherits="SupremeArt.Buyer.OrderHistory" %>
<asp:Content ID="Content1" ContentPlaceHolderID="content" runat="server">
    
    <div id="msg" runat="server"></div>
    <div class="container-fluid">
        <div class="card">
            <div class="card-body">
                <div id="order_table_div">
                    <table class="table table-bordered" id="order_table">
                        <thead>
                            <th>No.</th>
                            <th>OrderID</th>          
                            <th>Total (RM)</th>
                            <th>Order Date</th>
                            <th>Status</th>
                            <th>Action</th>

                        </thead>
                        <tbody>
                            <asp:Repeater ID="order_repeater" runat="server">
                                <ItemTemplate>
                                    <tr>
                                       <td><%# Container.ItemIndex+1 %></td>
                                        <td><i class="bi-shop"></i>&emsp;<%# Eval("orderid") %>


                                        </td>
                                        <td><%#  String.Format("{0:0.##}",Eval("total"))%></td>
                                        <td><%# Eval("OrderDate")%></td>
                                    
                                        <td ><span class="badge-pill <%# Eval("status").ToString() == "completed" ? "badge-success" : "badge-warning" %>"><%# Eval("status") %></span></td>
                                        <td>
                                            <a href="orderDetails.aspx?orderid=<%# Eval("orderid") %>"> <i class="bi bi-eye"></i> </a> &emsp;
                                            <a href="receipt.aspx?orderid=<%# Eval("orderid") %>" target="_blank"><i class="bi bi-receipt"></i></a>
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

    <br />
    <hr />
   
    <script>
        $(document).ready(function () {
            $('#order_table').DataTable({
                "dom": '<lf<t>ip>',
                lengthMenu: [[ 10, 25, 50, 100, -1], [ 10, 25, 50, 100, "ALL ITEMS"]]

            });

         




        })
    </script>
</asp:Content>
