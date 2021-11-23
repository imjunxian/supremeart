<%@ Page Title="" Language="C#" MasterPageFile="~/Layout/SellerSite.Master" AutoEventWireup="true" CodeBehind="orderDetails.aspx.cs" Inherits="SupremeArt.seller.orderDetails" %>
<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
    Order Details
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="server">
    <style>
        .image{
            width:300px;
            height:300px;
        }
    </style>
    <!---   To do 
    1. let seller able to edit each product status using modal
    2. status must be also drop down list

 -->
   
<br />
<br />
<br />
       <form runat="server" id="edit">
    <div class="card">
       
        <div class="card-body">
             <asp:Literal ID="litResult" runat="server"></asp:Literal>
             <div class="row">
                        <h3 >Reference</h3>
                    
                        <table class="table table-bordered table-stripped" width="50%">
                        
                           

                            <tr>
                            <th>OrderID</th>
                            <td>
                                <asp:Label ID="orderId" runat="server"></asp:Label>
                        
                            </td>
                            </tr>

                            <tr>
                            <th>Customer</th>
                            <td>
                                <asp:Literal ID="customer" runat="server"></asp:Literal>
                            </td>
                            </tr>

                            <tr>
                            <th>Customer Email</th>
                            <td>
                                <asp:Literal ID="custEmail" runat="server"></asp:Literal>
                            </td>
                            </tr>

                            <tr>
                            <th>Customer Contact</th>
                            <td>
                                <asp:Literal ID="custContact" runat="server"></asp:Literal>
                            </td>
                            </tr>

                            <tr>
                            <th>Delivered Address</th>
                            <td>
                                
                                <asp:Literal ID="orderAddress" runat="server"></asp:Literal>

                            </td>
                            </tr>

                            <tr>
                            <th>Order Date</th>
                            <td>
                                
                                <asp:Literal ID="orderDate" runat="server"></asp:Literal>

                            </td>
                            </tr>
           
                        
                        </table>
                 <div class="col-10"></div>
                 
            </div>
             
          
        </div>
    </div>
    <br />
    <br />
    <hr />
    
    <div class="card">
        <div class="card-body">
             <h3 align="center">Item Details</h3>
            <br>
            
                <table class="table table-bordered " id="itemsTable" >
                <div class="msg">
                   
                </div>
                        <thead class="thead-dark">
                            <tr>
                                <th>No.</th>
                                <th>Item Image</th>
                                <th>Item Description</th>                               
                                <th>Order Quantity</th>
                                <th>Sell Price (RM)</th>                             
                                <th>Total Price (RM)</th>                             
                                <th>Delivery Status</th>                              
                                <th width="20%">Action</th>

                            </tr>
                        </thead>
                        <tbody>
                            <asp:Repeater ID="itemRepeater" runat="server">
                                <ItemTemplate>
                                       <tr>
                                             <td><%#Container.ItemIndex+1 %></td>
                                                <td >  <img src="../Storage/ProductImage/<%#Eval("image")%> " class="image"/></td>
                                             <td><%#Eval("name") %></td>
                                             <td><%#Eval("qty") %></td>
                                             <td><%#String.Format("{0:0.##}",Eval("prodprice")) %></td>
                                             <td><%# String.Format("{0:0.##}",Eval("price")) %></td>
                                              <td id="status"><span class="badge-pill <%# Eval("status").ToString() == "Item Delivered" ? "badge-success" : "badge-warning" %>"><%# Eval("status") %> </span></td>
                                
                              
                                            <td>
                                                <a href="javascript:void(0)" class="editbtn" id="<%# Eval("id") %>" ><i class="bi-alarm bi-pencil-square"></i>&emsp; Edit</a>
                        
                                           </td>
                                      </tr>
                                </ItemTemplate>

                           </asp:Repeater>
                           

                          
                        </tbody>
                    </table>

                 <br />
                

        </div>
    </div>


       <!--modal-->
                    <div class="modal fade" id="itemModal" tabindex="-1" aria-labelledby="itemModalLabel" aria-hidden="true">
                          <div class="modal-dialog">
                            <div class="modal-content">
                              <div class="modal-header">
                                <h5 class="modal-title" id="itemModalLabel">Edit Status</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                  <span aria-hidden="true">&times;</span>
                                </button>
                              </div>
                              <div class="modal-body">
                                  
                                  <div class="form-group row">
                                      <div class="col-4">
                                          <label for="#status">Status :</label>
                                      </div>
                                      <!--<select id ="status_selection" class="form-control" style="width:300px;height:50px;">
                                          <option value="Order Received">Order Received</option>
                                          <option value="To Ship">To Ship</option>
                                          <option value="Out of Delivery">Out for Delivery</option>
                                          <option value="Item Delivered">Item Delivered</option>
                                          <option value="Return">Return</option>
                                          
                                      </select>-->

                                      <select id ="status_selection" class="form-control" style="width:300px;height:50px;" >
                                          <option value="" disabled selected>Please select status</option>
                                          <option value="1">Order Received</option>
                                          <option value="2">To Ship</option>
                                          <option value="3">Out for Delivery</option>
                                          <option value="4">Item Delivered</option>
                                          <option value="5">Return</option>
                                          
                                      </select>
                                        <!--<asp:DropDownList ID="prodCat" CssClass="form-control" runat="server" AutoPostBack ="false" Width="300px" Height="50px">
                                        <asp:ListItem Text ="Order Received" Value ="1"></asp:ListItem>
                                        <asp:ListItem Text ="To Ship" Value ="2"></asp:ListItem>
                                        <asp:ListItem Text ="Out Of Delivery" Value ="3"></asp:ListItem>
                                        <asp:ListItem Text ="Item Delivered" Value ="4"></asp:ListItem>
                                        <asp:ListItem Text ="Return" Value ="5"></asp:ListItem>
                                        </asp:DropDownList>-->
                                      
                                  </div>
                                  
                              </div>
                              <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                 <a href="#" id="updateStatBtn" class="btn btn-primary" >Update</a>
                                
                              </div>
                            </div>
                          </div>
                    </div>
                    <!--end modal-->
           </form>

    <script>
        $(document).ready(function () {
            var thisid = "";
            var selected = "";
            $(document).on("click", '.editbtn', function (e) {
                e.preventDefault();
                thisid = $(this).attr("id");

                $('#itemModal').modal("show");

            })

            $("#status_selection").on('change', function () {
                selected = $(this).children("option:selected").val();
                // var url = "updateItemStatus.aspx/?itemid=" + thisid + "&status=" + selected;
                //$('#updateStatBtn').attr("href", url);
            });

            $('#updateStatBtn').on('click', function () {
                if (selected == "") {
                    alert("Please select status to update !");
                } else {
                    location.href = "updateItemStatus.aspx/?itemid=" + thisid + "&status=" + selected;
                }
            })
        })
    </script>

</asp:Content>
