<%@ Page Title="" Language="C#" MasterPageFile="~/Layout/default.Master" AutoEventWireup="true" CodeBehind="orderDetails.aspx.cs" Inherits="SupremeArt.Buyer.orderDetails" %>
<asp:Content ID="Content1" ContentPlaceHolderID="content" runat="server">
     <style>
        table{
            white-space:nowrap;
            
        }
        img{
            width:150px;
            height:150px;
        }
    </style>

    <div class="text-left">

        <a href="orderhistory.aspx" class=" btn btn-outline-primary" onclick="close();">Back to Order History Page</a>
    </div>
<div class="row">

                    <div class="col-12 mt-5">
                  
                        <div class="card">
                            <div class="card-body">
                                <h4 class="header-title">Reference</h4>
        
       
                    <div class="row">
                    <div class="col-12 col-lg-6">
                    <table class="ordertable table table-bordered table-hovered">
                        <asp:Repeater ID="reference"  runat="server">
                            <ItemTemplate>
                                <tr>
                                    <th >Order ID</th>
                                    <td ><%# Eval("orderid") %></td>
                                </tr>

                                <tr>
                                    <th width="40%">Order Date</th>
                                    <td width="60%"><%# Eval("orderdate") %></td>
                                </tr>

                                <tr>
                                    <th width="40%">Total (RM)</th>
                                    <td width="60%"><%#String.Format("{0:0.##}",Eval("total")) %></td>
                                </tr>

                                <tr>
                                    <th width="40%">Status</th>
                                    <td><span class="badge-pill <%# Eval("status").ToString() == "Completed" ? "badge-success" : "badge-warning" %>"><%# Eval("status") %></span></td>
                                </tr>
                            </ItemTemplate>
                        </asp:Repeater>
                        

                      
                    </table>
                        <br />
                       
                    </div>
                    </div>
        </div>
        </div>
        </div>
        </div>
        <br>
        <div class="row">
             <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
         
                 <div  id="msg"></div>
                    <div class="container">
                <div class="card">
                            <div class="card-body">
                                <h4 class="header-title">Item</h4>
                                <div class="float-right">
                                    
                                </div>
                                <asp:Repeater ID="itemRepeater" runat="server">
                                    <ItemTemplate>
                                          <!--Item repeater start--->
                                        <div class="card">
                                                <span class="header-title"><i class="bi-shop"></i>&emsp; <%# Eval ("name")%></span>
                                                <span class="text-right text-primary"><%# Eval("status") %></span>
                                                    <div class="card-body">
                                                        <hr />
                                                        <div class="row">
                                                            <div  class="col-3 image">
                                                                <img src="../Storage/ProductImage/<%#Eval("image") %>" />
                                                            </div>

                                                            <div class=" col-5 float-left">
                                                                <span><%# Eval("name") %></span>
                                                                <br />
                                                                <span>x <%# Eval("qty") %></span>
                                                            </div>

                                                            <div class="col-4">
                                                                <div class="float-right">
                                                                    <span>RM <%#String.Format("{0:0.##}",Eval("price")) %></span>
                                                                </div>
                                                            </div>

                                                        </div>
                                                        <br />

                                                        <!-- if status = complete-->
                                                         

                                                            
                                                               
                                                        <!--end if-->

                                    
                                                </div>
                      
                                   
                                           </div>

                                <!--End Repeater-->


                                    </ItemTemplate>

                                </asp:Repeater>
                              
                                        
                
            </div><!-- card-body -->

            </div><!-- card --></div>

            </div><!-- col -->
            </div><!-- row -->
</asp:Content>
