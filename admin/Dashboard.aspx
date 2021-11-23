<%@ Page Title="" Language="C#" MasterPageFile="~/Layout/AdminSite.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="SupremeArt.admin.Dashboard" %>
<asp:Content ID="Content2" ContentPlaceHolderID="title" runat="server">
    Dashboard
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="content" runat="server">
         <asp:Literal ID="litError" runat="server"></asp:Literal>
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
                            <div class="card border-left-info shadow h-100 py-2">
                                <div class="card-body">
                                    <div class="row no-gutters align-items-center">
                                        <div class="col mr-2">
                                            <div class="text-xs font-weight-bold text-warning text-uppercase mb-1">
                                               Total Buyers</div>
                                            <asp:Label ID="lbltotalcust" runat="server" Text="" CssClass="h5 mb-0 font-weight-bold text-gray-800"></asp:Label>
                                        </div>
                                        <div class="col-auto">
                                            <i class="fa fa-user fa-2x text-gray-300"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                     
                        <div class="col-xl-3 col-md-6 mb-4">
                            <div class="card border-left-warning shadow h-100 py-2">
                                <div class="card-body">
                                    <div class="row no-gutters align-items-center">
                                        <div class="col mr-2">
                                            <div class="text-xs font-weight-bold text-warning text-uppercase mb-1">
                                                Total Sellers</div>
                                            <asp:Label ID="lbltotalseller" runat="server" Text="" CssClass="h5 mb-0 font-weight-bold text-gray-800"></asp:Label>
                                        </div>
                                        <div class="col-auto">
                                            <i class="fa fa-user fa-2x text-gray-300"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                     </div> 


        </div>
            

</asp:Content>
