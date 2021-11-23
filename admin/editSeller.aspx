<%@ Page Title="" Language="C#" MasterPageFile="~/Layout/AdminSite.Master" AutoEventWireup="true" CodeBehind="editSeller.aspx.cs" Inherits="SupremeArt.admin.editSeller" %>
<asp:Content ID="Content1" ContentPlaceHolderID="content" runat="server">
        <div class="card">
              <div class="card-header">
                <h4>Seller</h4>     
              </div>
              <!-- /.card-header -->
              <div class="card-body">
                    <div class="modal-body">
                        <asp:Literal ID="litResult" runat="server"></asp:Literal>
                        <div class="form-group">
                          <label> Seller ID </label>
                           <asp:TextBox ID="sellerId" runat="server" type="text" CssClass="form-control"  name="id" ReadOnly="true"></asp:TextBox>
                            <input type="hidden" name="id" value="" ID="sellID" runat="server"/>
                        </div>
                       
                        <div class="form-group">
                          <label> Name </label>
                           <asp:TextBox ID="sellerName" runat="server" type="text" CssClass="form-control" placeholder="Enter Name" name="name" ReadOnly="true"></asp:TextBox>
                        </div>

                        <div class="form-group">
                          <label> Username </label>
                           <asp:TextBox ID="sellerUsername" runat="server" type="text" CssClass="form-control" placeholder="Enter Username" name="username" ReadOnly="true"></asp:TextBox>
                        </div>
             
                        <div class="form-group">
                             <label>Email</label>
                              <asp:TextBox ID="sellerEmail" runat="server" type="text" CssClass="form-control" placeholder="Enter Email" name="email" ReadOnly="true"></asp:TextBox>
                         </div>

                         <div class="form-group">
                              <label>Contact</label>
                              <asp:TextBox ID="sellerContact" runat="server" type="text" CssClass="form-control" placeholder="Enter Contact" name="contact" ReadOnly="true"></asp:TextBox>
                          </div>

                         <div class="form-group">
                              <label>Status</label>
                               
                            <asp:DropDownList ID="sellerStatus" CssClass="form-control" runat="server" AutoPostBack ="false">
                            <asp:ListItem Text ="active" Value ="active"></asp:ListItem>
                            <asp:ListItem Text ="barred" Value ="barred"></asp:ListItem>
                            </asp:DropDownList>
                          </div>

                 
                        </div>

                         <!--Submit button-->
                      <div class="modal-footer justify-content-between">
                        <button type="button" class="btn btn-secondary" onclick='window.location.href="sellerList.aspx"'>Cancel</button>
                          <asp:Button ID="updateBtn" runat="server" Text="Update" type="submit" CssClass="btn btn-primary" OnClick="updateBtn_Click"/>
                      </div>
                           
              </div>
              <!-- /.card-body -->
            </div>
</asp:Content>
