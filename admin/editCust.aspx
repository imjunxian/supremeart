<%@ Page Title="" Language="C#" MasterPageFile="~/Layout/AdminSite.Master" AutoEventWireup="true" CodeBehind="editCust.aspx.cs" Inherits="SupremeArt.admin.editCustomer" %>
<asp:Content ID="Content1" ContentPlaceHolderID="content" runat="server">
            <div class="card">
              <div class="card-header">
                <h4>Buyers</h4>     
              </div>
              <!-- /.card-header -->
              <div class="card-body">
                    <div class="modal-body">

                        <asp:Literal ID="litResult" runat="server"></asp:Literal>

                        <div class="form-group">
                          <label> Buyer ID </label>
                           <asp:TextBox ID="customerId" runat="server" type="text" CssClass="form-control"  name="id" ReadOnly="true"></asp:TextBox>
                            <input type="hidden" name="id" value="" ID="custID" runat="server"/>
                        </div>
                       
                        <div class="form-group">
                          <label> Name </label>
                           <asp:TextBox ID="custName" runat="server" type="text" CssClass="form-control" placeholder="Enter Name" name="name" ReadOnly="true"></asp:TextBox>
                        </div>

                        <div class="form-group">
                          <label> Username </label>
                           <asp:TextBox ID="custUsername" runat="server" type="text" CssClass="form-control" placeholder="Enter Username" name="username" ReadOnly="true"></asp:TextBox>
                        </div>
             
                        <div class="form-group">
                             <label>Email</label>
                              <asp:TextBox ID="custEmail" runat="server" type="text" CssClass="form-control" placeholder="Enter Email" name="email" ReadOnly="true"></asp:TextBox>
                         </div>

                         <div class="form-group">
                              <label>Contact</label>
                              <asp:TextBox ID="custContact" runat="server" type="text" CssClass="form-control" placeholder="Enter Contact" name="contact" ReadOnly="true"></asp:TextBox>
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
                              <label>Membership</label>                               
                            <asp:DropDownList ID="custMembership" CssClass="form-control" runat="server" AutoPostBack ="false">
                            <asp:ListItem Text ="Basic" Value ="Basic"></asp:ListItem>
                            <asp:ListItem Text ="Premium" Value ="Premium"></asp:ListItem>
                            </asp:DropDownList>
                          </div>

                         <div class="form-group">
                              <label>Status</label>                               
                            <asp:DropDownList ID="custStatus" CssClass="form-control" runat="server" AutoPostBack ="false">
                            <asp:ListItem Text ="active" Value ="active"></asp:ListItem>
                            <asp:ListItem Text ="barred" Value ="barred"></asp:ListItem>
                            </asp:DropDownList>
                          </div>

                 
                        </div>

                         <!--Submit button-->
                      <div class="modal-footer justify-content-between">
                        <button type="button" class="btn btn-secondary" onclick='window.location.href="custList.aspx"'>Cancel</button>
                          <asp:Button ID="updateBtn" runat="server" Text="Update" type="submit" CssClass="btn btn-primary" OnClick="updateBtn_Click"/>
                      </div>
                           
              </div>
              <!-- /.card-body -->
            </div>

</asp:Content>



                 