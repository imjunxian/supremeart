<%@ Page Title="" Language="C#" MasterPageFile="~/Layout/AdminSite.Master" AutoEventWireup="true" CodeBehind="orderList.aspx.cs" Inherits="SupremeArt.admin.orderList" %>
<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="server">
    <asp:Literal ID="litError" runat="server"></asp:Literal>
      <div class="card">
              <div class="card-header">
                <h4>Orders</h4>
             
              </div>
              <!-- /.card-header -->
              <div class="card-body">
                <asp:Literal ID="litResult" runat="server" Text="" EnableViewState="False"></asp:Literal> 
                            <div class="table-responsive">
                                  <table class="table table-bordered table-striped" id="datatable" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th>Order ID</th>
                                            <th>Order DateTime</th>
                                            <th>Product</th>
                                            <th>Buyer</th>
                                            <th>Delivered Address</th>
                                            <th>Seller</th>
                                            <th>Status</th>
                                            <th>Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%= getOrderData() %>
                                    </tbody>     
                                </table>
                            </div>
              </div>
              <!-- /.card-body -->
            </div>
            <!-- /.card -->

        

    <script>

        $(document).ready(function () {
            $('#datatable').DataTable({
                "dom": '<lf<t>ip>',
                lengthMenu: [[5, 10, 25, 50, 100, -1], [5, 10, 25, 50, 100, "ALL ITEMS"]]

            });
        });
  

        if (window.history.replaceState) {
            window.history.replaceState(null, null, window.location.href);
        }

  

    </script>
</asp:Content>
