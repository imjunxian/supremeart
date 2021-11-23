<%@ Page Title="" Language="C#" MasterPageFile="~/Layout/default.Master" AutoEventWireup="true" CodeBehind="SupremeArt.aspx.cs" Inherits="SupremeArt.SupremeArt" %>
<asp:Content ID="Content1" ContentPlaceHolderID="content" runat="server">
     <link href="assets/css/product.css" rel="stylesheet" />
    <br />
    <br />
    <br />
   <div class="container">
    <div class="row">
        <div class="col-12 col-sm-3">
            <div class="card bg-light mb-3">
                <div class="card-header bg-primary text-white text-uppercase"><i class="fa fa-list"></i> Categories</div>
                <ul class="list-group category_block">
                    <li class="list-group-item"><a href="category.html">App Product</a></li>
                   
                </ul>
            </div>
          
        </div>
        <div class="col">
            <div class="row">
                <asp:Repeater ID="productRepeater" runat="server">
                    <ItemTemplate>
                    <div class="col-12 col-md-6 col-lg-4">
                        <div class="card">
                            <img class="card-img-top" src="../Storage/ProductImage/<%#Eval("imagePath") %>" alt="Card image cap">
                            <div class="card-body">
                                <h4 class="card-title"><a href="" title="View Product"><%#Eval("name") %></a></h4>
                                <p class="card-text">Stock : <%#Eval("stock") %></p>
                                <div class="row">
                                    <div class="col">
                                        <p class="text-dark">RM <%# String.Format("{0:0.##}",Eval("price"))  %></p>
                                    </div>
                                    <div class="col">
                                        <a href="../Product/ViewProduct.aspx?prodID=<%#Eval("id") %>" class=" btn btn-outline-primary">View</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    </ItemTemplate>
                </asp:Repeater>
            <!--    <div class="col-12">
                    <nav aria-label="...">
                        <ul class="pagination">
                            <li class="page-item disabled">
                                <a class="page-link" href="#" tabindex="-1">Previous</a>
                            </li>
                            <li class="page-item"><a class="page-link" href="#">1</a></li>
                            <li class="page-item active">
                                <a class="page-link" href="#">2 <span class="sr-only">(current)</span></a>
                            </li>
                            <li class="page-item"><a class="page-link" href="#">3</a></li>
                            <li class="page-item">
                                <a class="page-link" href="#">Next</a>
                            </li>
                        </ul>
                    </nav>
                </div>-->
            </div>
        </div>

    
    </div>
</div>
</asp:Content>
