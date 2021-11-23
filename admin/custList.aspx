<%@ Page Title="" Language="C#" MasterPageFile="~/Layout/AdminSite.Master" AutoEventWireup="true" CodeBehind="custList.aspx.cs" Inherits="SupremeArt.admin.custList" %>
<asp:Content ID="Content1" ContentPlaceHolderID="content" runat="server">

         
            <div class="card">
              <div class="card-header">
                <h4>Buyers</h4>
             
              </div>
              <!-- /.card-header -->
              <div class="card-body">
                <asp:Literal ID="litResult" runat="server" Text="" EnableViewState="False"></asp:Literal> 
                            <div class="table-responsive">
                                  <table class="table table-bordered table-striped" id="datatable" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th>Buyer ID</th>
                                            <th>Name</th>
                                            <th>Username</th>
                                            <th>Email</th>
                                            <th>Contact</th>
                                            <th>Address</th>
                                            <th>Membership</th>
                                            <th>Status</th>
                                            <th>Actions</th>
                                         
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%= getCustomerData() %>
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
                                  
                                     <p>Confirm delete customer [<span ID="deleteId"></span>] ?</p> <p class="text-danger">Caution: Changes cannot be made after delete successful.</p> 
                           
                              </div>
                              <div class="modal-footer">              
                                 
                                <input type="hidden" name="name" id="inputDelete" value="" runat="server"/>
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                  <asp:Button ID="deleteBtn" CssClass="btn btn-success" runat="server" Text="Confirm" OnClick="deleteBtn_Click"/>
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
            //document.getElementById("delBTN").href = "deleteCustomer.aspx?id="+id;
        }


    
        
    </script>

</asp:Content>
