<%@ Page Title="" Language="C#" MasterPageFile="~/Layout/SellerSite.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="SupremeArt.seller.Dashboard" %>
<asp:Content ID="Content2" ContentPlaceHolderID="title" runat="server">
    Dashboard
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="content" runat="server">
    <br />
    <asp:Literal ID="litError" runat="server"></asp:Literal>

    <form runat="server" id="edit">
        <!-- main content area start -->
        <div class="main-content">
            <div class="card">

            </div>

            <!-- Page Heading -->
                    <div class="d-sm-flex align-items-center justify-content-between mb-4">
                        <h1 class="h3 mb-0 text-gray-800"></h1>
                        
                    </div>

                    <!-- Content Row -->
                    <div class="row">

               
                        <div class="col-xl-3 col-md-6 mb-4">
                            <div class="card border-left-primary shadow h-100 py-2">
                                <div class="card-body">
                                    <div class="row no-gutters align-items-center">
                                        <div class="col mr-2">
                                            <div class="text-xs font-weight-bold text-success text-uppercase mb-1">
                                                Total Orders</div>
                                  
                                            <asp:Label ID="lbltotalOrder" runat="server" Text="" CssClass="h5 mb-0 font-weight-bold text-gray-800"></asp:Label>
                                        </div>
                                        <div class="col-auto">
                                            <i class="ti-agenda fa-2x text-gray-300"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        
                        <div class="col-xl-3 col-md-6 mb-4">
                            <div class="card border-left-success shadow h-100 py-2">
                                <div class="card-body">
                                    <div class="row no-gutters align-items-center">
                                        <div class="col mr-2">
                                            <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">
                                               Total Products</div>
                                            <asp:Label ID="lbltotalprod" runat="server" Text="" CssClass="h5 mb-0 font-weight-bold text-gray-800"></asp:Label>
                                        </div>
                                        <div class="col-auto">
                                            <i class="ti-harddrive fa-2x text-gray-300"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="col-xl-3 col-md-6 mb-4">
                            <div class="card border-left-success shadow h-100 py-2">
                                <div class="card-body">
                                    <div class="row no-gutters align-items-center">
                                        <div class="col mr-2">
                                            <div class="text-xs font-weight-bold text-warning text-uppercase mb-1">
                                               Premium Products</div>
                                            <asp:Label ID="lbltotalPre" runat="server" Text="" CssClass="h5 mb-0 font-weight-bold text-gray-800"></asp:Label>
                                        </div>
                                        <div class="col-auto">
                                            <i class="ti-harddrive fa-2x text-gray-300"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="col-xl-3 col-md-6 mb-4">
                            <div class="card border-left-success shadow h-100 py-2">
                                <div class="card-body">
                                    <div class="row no-gutters align-items-center">
                                        <div class="col mr-2">
                                            <div class="text-xs font-weight-bold text-warning text-uppercase mb-1">
                                               Basic Products</div>
                                            <asp:Label ID="lbltotalBasic" runat="server" Text="" CssClass="h5 mb-0 font-weight-bold text-gray-800"></asp:Label>
                                        </div>
                                        <div class="col-auto">
                                            <i class="ti-harddrive fa-2x text-gray-300"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>



                     </div>
                     
            
         
        

    </form>   



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
