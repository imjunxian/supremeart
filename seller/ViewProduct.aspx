<%@ Page Title="" Language="C#" MasterPageFile="~/Layout/SellerSite.Master" AutoEventWireup="true" CodeFile="ViewProduct.aspx.cs" Inherits="SupremeArt.seller.ViewProduct" %>
<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="server">
<form id="form1" runat="server">
      <style>
        img{
            width:150px;
            height:150px;
        }
    </style>
    <br />

    <div class="card">
        <div class="card-body">
            <div class="row">
                <div class="col-12">
                    <div class="container">
                        <asp:Literal ID="litResult" runat="server" Text="" EnableViewState="False"></asp:Literal>
                        <table class="table table-bordered" id="product_table">
                            <thead>
                                <th>No.</th>
                                <th>Product Image</th>
                                <th>Product </th>
                                <th>Price</th>
                                <th>Stock</th>
                                <th>Category</th>
                                <th>Action</th>
                            </thead>

                            <tbody>
                                <asp:Repeater ID="product_repeater" runat="server">
                                    <ItemTemplate>
                                        <tr>
                                            <td><%#Container.ItemIndex+1 %></td>
                                            <td>
                                                 <img src="../Storage/ProductImage/<%#Eval("imagePath")%>" class="img-thumbnail"/>                             

                                            </td>
                                            <td><%# Eval("name") %></td>
                                            <td><%# Eval("price") %></td>
                                            <td><%# Eval("stock") %></td>
                                            <td><%# Eval("category") %></td>
                                             <td>
                                      
                                                <a href="editProduct.aspx?productid=<%#Eval("id") %>" class="editbtn" id="<%# Eval("id") %>"><i class="bi bi-pencil-square"></i></a>
                                                &emsp;
                                                <a href="#" id="<%# Eval("id") %>"  onclick='qqq(this)'><i class="bi bi-trash"></i></a>
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

    </div>

    <!--modal-->
                    <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                          <div class="modal-dialog">
                            <div class="modal-content">
                              <div class="modal-header">
                                <h5 class="modal-title" id="exampleModalLabel">Confirmation</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                  <span aria-hidden="true">&times;</span>
                                </button>
                              </div>
                              <div class="modal-body">
                                  
                                     <p>Confirm delete product [<span ID="deleteId"></span>] ?</p> <p class="text-danger">Caution: Changes cannot be made after delete successful.</p> 
                           
                              </div>
                              <div class="modal-footer">              
                                  <input type="hidden" name="name" id="inputDelete" value="" runat="server"/>
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>                            
                                <asp:Button ID="deleteBtn" CssClass="btn btn-success" runat="server" Text="Confirm" OnClick="deleteBtn_Click" CausesValidation="false"/>
                              </div>
                            </div>
                          </div>
                    </div>
         
     

    <script>
        $(document).ready(function () {
            $('#product_table').DataTable({
                "dom": '<lf<t>ip>',
                lengthMenu: [[5, 10, 25, 50, 100, -1], [5, 10, 25, 50, 100, "ALL ITEMS"]]

            });
        });

        function qqq(e) {

            var id = $(e).attr('id');
            document.getElementById("deleteId").innerText = id;
            var thisid = document.getElementById("<%=inputDelete.ClientID%>");
            thisid.value = document.getElementById("deleteId").innerText;
            $('#exampleModal').modal("show");

        }
        if (window.history.replaceState) {
            window.history.replaceState(null, null, window.location.href);
        }
    </script>
</form>
</asp:Content>
