<%@ Page Title="" Language="C#" MasterPageFile="~/Layout/default.Master" AutoEventWireup="true" CodeBehind="Wishlist.aspx.cs" Inherits="SupremeArt.Buyer.Wishlist" %>
<asp:Content ID="Content1" ContentPlaceHolderID="content" runat="server">

       <style>
        img{
            width:200px;
            height:200px;
        }
    </style>
    <form runat="server" id="issue_orm">
     <div class="container-lg">
            <div class="card">
                
                 <div class="card-body" width="70%">
                     <asp:Label ID="litResult" runat="server"  Font-Bold="true" Display="Dynamic"></asp:Label>
                     <p>Total Items in Wishlist: <span class="badge badge-warning">
                         <asp:Literal ID="num" runat="server"></asp:Literal></span></p>
                     <div id="table"">
                         <table class="table table-bordered" >
                             <thead>
                                 <th width="1%">No.</th>
                                 <th width="15%">Image</th>
                                 <th width="15%">Item</th>
                                 
                                 <th width="8%">Action</th>
                             </thead>

                             <tbody>
                                 <asp:Repeater ID="WishListRepeater" runat="server">
                                     <ItemTemplate>
                                 <tr>
                                     <td><%#Container.ItemIndex + 1 %></td>
                                     <td>
                                         <a href="../Product/ViewProduct.aspx?prodID=<%# Eval("productID") %>" target="_blank">
                                      <img src="../Storage/ProductImage/<%#Eval("image")%> "/></a>
                                     </td>
                                     <td><%# Eval("name") %></td>
                                     
                                    
                                     <td>
                                         <a href="../Product/ViewProduct.aspx?prodID=<%#Eval("productID")%>" class="btn btn-primary">View</a>
                                         <a href="deleteWishlist.aspx?id=<%#Eval("Id")%>" class="btn btn-danger">Remove</a>
                                     </td>
                                      


                                 </tr>
                                </ItemTemplate>
                                 </asp:Repeater>
                             </tbody>

                           
                         </table>
                      
                         
                     </div>
                 </div>
            </div>
     </div>
        </form>
</asp:Content>
