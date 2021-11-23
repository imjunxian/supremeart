<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="HomeControl.ascx.cs" Inherits="SupremeArt.Buyer.HomeControl" %>

<link href="../assets/css/product.css" rel="stylesheet" />
    <br />
    <br />
    <br />
   <div class="container">
    <div class="row">
        <div class="col-12 col-sm-3">
            <div class="card bg-light mb-3">
                <div class="card-header bg-primary text-white text-uppercase"><i class="fa fa-list"></i> Categories</div>
                <ul class="list-group category_block">

                        <% string membership = Session["membership"].ToString();
                            if (membership == "Premium")
                        { %>
                            <li class="list-group-item menu"><asp:HyperLink ID="linkAll" runat="server" NavigateUrl="Home.aspx?category=all">All</asp:HyperLink></li>
                            <li class="list-group-item menu"><asp:HyperLink ID="linkPremium" runat="server" NavigateUrl="Home.aspx?category=premium">Premium</asp:HyperLink></li>
                            <li class="list-group-item menu"><asp:HyperLink ID="linkBasic" runat="server" NavigateUrl="Home.aspx?category=basic">Basic</asp:HyperLink></li>
                    <%}
                        else
                        { %>
                            <li class="list-group-item menu"><asp:HyperLink ID="linkBasic2" runat="server" NavigateUrl="Home.aspx?category=basic">Basic</asp:HyperLink></li>
                    <%} %>
            
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
<script>
    $(function () {

        activeOnMenu();
    });

    function activeOnMenu() {
        const currentLocation = location.href;
        const menuItem = document.querySelectorAll('a');
        const menuLi = document.querySelectorAll('.list-group-item li');
        const menuLength = menuItem.length;
        for (let i = 0; i < menuLength; i++) {
            if (menuItem[i].href === currentLocation) {


                menuLi[i].className = "active";



            }
        }
    }
                </script>
