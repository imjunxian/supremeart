<%@ Page Title="" Language="C#" MasterPageFile="~/Layout/AdminSite.Master" AutoEventWireup="true" CodeBehind="editOrder.aspx.cs" Inherits="SupremeArt.admin.editOrder" %>
<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="server">
    <div class="card">
              <div class="card-header">
                <h4>Edit Order</h4>     
              </div>
              <!-- /.card-header -->
              <div class="card-body">
                    <div class="modal-body">

                        <asp:Literal ID="litResult" runat="server"></asp:Literal>

                       
                        <div class="form-group">
                          <label> Order ID </label>
                           <asp:TextBox ID="orderID" runat="server" type="text" CssClass="form-control" placeholder="Enter Name" name="name" ReadOnly="true"></asp:TextBox>
                        </div>

                        <div class="form-group">
                          <label> Order Date </label>
                           <asp:TextBox ID="orderDate" runat="server" type="text" CssClass="form-control" placeholder="Enter Username" name="username" ReadOnly="true"></asp:TextBox>
                        </div>
             
                        <div class="form-group">
                             <label>Products</label>
                              <asp:TextBox ID="orderProduct" runat="server" type="text" CssClass="form-control" placeholder="Enter Email" name="email" ReadOnly="true"></asp:TextBox>
                         </div>

                         <div class="form-group">
                              <label>Buyer</label>
                              <asp:TextBox ID="orderBuyer" runat="server" type="text" CssClass="form-control" placeholder="Enter Contact" name="contact" ReadOnly="true"></asp:TextBox>
                          </div>

                        <div class="form-group">
                              <label>Address</label>                               
                            <asp:TextBox ID="orderAddress" runat="server" type="text" CssClass="form-control" placeholder="Enter Contact" name="contact" ReadOnly="true"></asp:TextBox>
                          </div>

                        <div class="form-group">
                              <label>City</label>                               
                            <asp:TextBox ID="orderCity" runat="server" type="text" CssClass="form-control" placeholder="Enter Contact" name="contact" ReadOnly="true"></asp:TextBox>
                          </div>

                        <div class="form-group">
                              <label>State</label>                               
                            <asp:TextBox ID="orderState" runat="server" type="text" CssClass="form-control" placeholder="Enter Contact" name="contact" ReadOnly="true"></asp:TextBox>
                          </div>

                        <div class="form-group">
                              <label>PostCode</label>                               
                            <asp:TextBox ID="orderPost" runat="server" type="text" CssClass="form-control" placeholder="Enter Contact" name="contact" ReadOnly="true"></asp:TextBox>
                          </div>

                         <div class="form-group">
                              <label>Address Type</label>                               
                            <asp:TextBox ID="orderType" runat="server" type="text" CssClass="form-control" placeholder="Enter Contact" name="contact" ReadOnly="true"></asp:TextBox>
                          </div>


                         <div class="form-group">
                              <label>Status</label>                               
                            <asp:DropDownList ID="orderStatus" CssClass="form-control" runat="server" AutoPostBack ="false">
                            <asp:ListItem Text ="Order Received" Value ="Order Received"></asp:ListItem>
                                     <asp:ListItem Text ="To Ship" Value ="To Ship"></asp:ListItem>
                                      <asp:ListItem Text ="Out for Delivery" Value ="Out for Delivery"></asp:ListItem>
                                        <asp:ListItem Text ="Item Delivered" Value ="Item Delivered"></asp:ListItem>
                                        <asp:ListItem Text ="Return" Value ="Return"></asp:ListItem>
                            </asp:DropDownList>
                          </div>

                 
                        </div>

                         <!--Submit button-->
                      <div class="modal-footer justify-content-between">
                        <button type="button" class="btn btn-secondary" onclick='window.location.href="orderList.aspx"'>Cancel</button>
                          <asp:Button ID="updateBtn" runat="server" Text="Update" type="submit" CssClass="btn btn-primary" OnClick="updateBtn_Click"/>
                      </div>
                           
              </div>
              <!-- /.card-body -->
            </div>
</asp:Content>
