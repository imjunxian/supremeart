<%@Page Title="" Language="C#" MasterPageFile="~/Layout/AdminSite.Master" AutoEventWireup="true" CodeBehind="adminList.aspx.cs" Inherits="SupremeArt.admin.adminList" %>
<asp:Content ID="Content2" ContentPlaceHolderID="title" runat="server">

</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="content" runat="server">

            <!--Add Toggles-->
    <div class="modal fade" id="addForm">
        <div class="modal-dialog">
          <div class="modal-content">
            <div class="modal-header">
              <h4 class="modal-title">Add Admin</h4>
              <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                <span aria-hidden="true">&times;</span>
              </button>
            </div>


              <div class="modal-body">
                    <div class="form-group">
                      <label> Name </label>
                       <asp:TextBox ID="adminName" runat="server" type="text" CssClass="form-control" placeholder="Enter Name" name="adminName"></asp:TextBox>
                       <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*Name is Required" ControlToValidate="adminName" Display="Dynamic" CssClass="error" ForeColor="Red"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Invalid Format [Only Alphabets Allow]" ControlToValidate="adminName" Font-Bold="False" Font-Italic="False" ForeColor="Red" ValidationExpression="^(?![\s.]+$)[a-zA-Z\s.]*$" Display="Dynamic"></asp:RegularExpressionValidator>
                     </div>

                    <div class="form-group">
                         <label>Email</label>
                          <asp:TextBox ID="adminEmail" runat="server" type="text" CssClass="form-control" placeholder="Enter Email" name="adminEmail"></asp:TextBox>
                           <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="*Email is Required" ControlToValidate="adminEmail" Display="Dynamic" CssClass="error" ForeColor="Red"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="adminEmail"  Display="Dynamic" ErrorMessage="Invalid Email" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" CssClass="error" ForeColor="Red"></asp:RegularExpressionValidator>
                     </div>

                     <div class="form-group">
                          <label>Contact</label>
                          <asp:TextBox ID="adminPhoneNo" runat="server" type="text" CssClass="form-control" placeholder="Enter Contact" name="contact"></asp:TextBox>
                             <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="*Contact is Required" ControlToValidate="adminPhoneNo" Display="Dynamic" CssClass="error" ForeColor="Red"></asp:RequiredFieldValidator>
                             <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="adminPhoneNo"  Display="Dynamic" ErrorMessage="Invalid Format [Format must start with (601)or(01) and not longer than 11 digits and NO Alphabets]" ValidationExpression="^6?01\d{8}$" CssClass="error" ForeColor="Red"></asp:RegularExpressionValidator>
                      </div>
                  <div class="form-group">              
                      <label>Password</label>
                      <asp:TextBox ID="adminPassword" runat="server" type="text" TextMode="Password" CssClass="form-control" placeholder="Password" name="pass"></asp:TextBox>
                         <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="*Password is required" ControlToValidate="adminPassword" Display="Dynamic" CssClass="error" ForeColor="Red"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ControlToValidate="adminPassword"  Display="Dynamic" ErrorMessage="Password should be at least 8 characters include 1 uppercase, 1 lowercase and 1 number" ValidationExpression="^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$" CssClass="error" ForeColor="Red"></asp:RegularExpressionValidator>
                  </div>
                   <div class="form-group">              
                      <label>Confirm Password</label>
                      <asp:TextBox ID="cpassword" runat="server" type="text"  TextMode="Password" CssClass="form-control" placeholder="Confirm Password" name="cpass"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="*Confirm Password is required" ControlToValidate="cpassword" Display="Dynamic" CssClass="error" ForeColor="Red"></asp:RequiredFieldValidator>
                           
                       <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToCompare="adminPassword" ControlToValidate="cpassword" ErrorMessage="Confirm Password must be same with Password" CssClass="error" ForeColor="Red"></asp:CompareValidator>
                  </div>
                 
              </div>

              <!--Submit button-->
              <div class="modal-footer justify-content-between">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                  <asp:Button ID="addBtn" runat="server" Text="Add" type="submit" CssClass="btn btn-primary" OnClick="addBtn_Click"/>
              </div>
           
          </div>
          <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
      </div>
      <!-- /.modal -->

   
       
            <div class="card">
                 
              <div class="card-header">
                <h4>Admins</h4>
       
                             <asp:LinkButton ID="addCustBtn" runat="server" type="button" CssClass="btn btn-primary float-right" style="margin-top:-2.5%;" data-toggle="modal" data-target="#addForm">
                                Add 
                            </asp:LinkButton>
              </div>
              <!-- /.card-header -->
              <div class="card-body">
                  
                     <asp:Literal ID="litResult" runat="server" Text="" EnableViewState="False"></asp:Literal>                
             
                            <div class="table-responsive">
                                  <table class="table table-bordered table-striped" id="datatable" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th>Name</th>
                                            <th>Email</th>
                                            <th>Contact</th>
                                            <th width="15%">Actions</th>
                                         
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%= getAdminData() %>
                                    </tbody>     
                                </table>
                            </div>
              </div>
              <!-- /.card-body -->
            </div>
            <!-- /.card -->

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
                                  
                                     <p>Confirm delete admin [<span ID="deleteId"></span>] ?</p> <p class="text-danger">Caution: Changes cannot be made after delete successful.</p> 
                           
                              </div>
                              <div class="modal-footer">              
                                  <input type="hidden" name="name" id="inputDelete" value="" runat="server"/>
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                  <asp:Button ID="deleteBtn" CssClass="btn btn-success" runat="server" Text="Confirm" OnClick="deleteBtn_Click" CausesValidation="false"/>
                                
                              </div>
                            </div>
                          </div>
                    </div>
                    <!--end modal-->


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

        function qqq(e) {

            var id = $(e).attr('id');
            document.getElementById("deleteId").innerText = id;
            var thisid = document.getElementById("<%=inputDelete.ClientID%>");
            thisid.value = document.getElementById("deleteId").innerText;
            $('#exampleModal').modal("show");
       
        }

        
    </script>


</asp:Content>
