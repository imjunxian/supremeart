<%@ Page Title="" Language="C#" MasterPageFile="~/Layout/AdminSite.Master" AutoEventWireup="true" CodeBehind="editAdmin.aspx.cs" Inherits="SupremeArt.admin.editAdmin" %>
<asp:Content ID="Content1" ContentPlaceHolderID="content" runat="server">
     <div class="card">
              <div class="card-header">
                <h4>Admins</h4>     
              </div>
              <!-- /.card-header -->
              <div class="card-body">

                    <div class="modal-body">

                        <asp:Literal ID="litResult" runat="server"></asp:Literal>

                        <input type="hidden" name="id" value="" ID="adminID" runat="server"/>
          
                       
                        <div class="form-group">
                          <label> Name </label>
                           <asp:TextBox ID="adminName" runat="server" type="text" CssClass="form-control" placeholder="Enter Name" name="name" ReadOnly="true"></asp:TextBox>
                             <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Name is Required" ControlToValidate="adminName" Display="Dynamic" CssClass="error" ForeColor="Red"></asp:RequiredFieldValidator>
                             <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Invalid Format [Only Alphabets Allow]" ControlToValidate="adminName" Font-Bold="False" Font-Italic="False" ForeColor="Red" ValidationExpression="^(?![\s.]+$)[a-zA-Z\s.]*$" Display="Dynamic"></asp:RegularExpressionValidator>
                        </div>

                        <div class="form-group">
                             <label>Email</label>
                              <asp:TextBox ID="adminEmail" runat="server" type="text" CssClass="form-control" placeholder="Enter Email" name="email" ></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="*Email is Required" ControlToValidate="adminEmail" Display="Dynamic" CssClass="error" ForeColor="Red"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="adminEmail"  Display="Dynamic" ErrorMessage="Invalid Email" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" CssClass="error" ForeColor="Red"></asp:RegularExpressionValidator>

                         </div>

                         <div class="form-group">
                              <label>Contact</label>
                              <asp:TextBox ID="adminContact" runat="server" type="text" CssClass="form-control" placeholder="Enter Contact" name="contact" ></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="*Contact is Required" ControlToValidate="adminContact" Display="Dynamic" CssClass="error" ForeColor="Red"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="adminContact"  Display="Dynamic" ErrorMessage="Invalid Format [Format must start with (601)or(01) and not longer than 11 digits and NO Alphabets]" ValidationExpression="^6?01\d{8}$" CssClass="error" ForeColor="Red"></asp:RegularExpressionValidator>
                          </div>

                   

                        </div>

                         <!--Submit button-->
                      <div class="modal-footer justify-content-between">
                        <button type="button" class="btn btn-secondary" onclick='window.location.href="adminList.aspx"'>Cancel</button>
                          <asp:Button ID="updateBtn" runat="server" Text="Update" type="submit" CssClass="btn btn-primary" OnClick="updateBtn_Click"/>
                      </div>
                           
              </div>
              <!-- /.card-body -->
            </div>



    <script>
        if (window.history.replaceState) {
            window.history.replaceState(null, null, window.location.href);
        }
    </script>

</asp:Content>
