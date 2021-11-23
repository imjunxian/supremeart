<%@ Page Title="" Language="C#" MasterPageFile="~/Layout/default.Master" AutoEventWireup="true" CodeBehind="Cart.aspx.cs" Inherits="SupremeArt.Buyer.Cart" %>
<asp:Content ID="Content1" ContentPlaceHolderID="content" runat="server">
    <style>
        img{
            width:200px;
            height:200px;
        }
    </style>
     <div class="container-lg">
         <div id="payStat" runat="server"></div>
         <div id="cartStat" runat="server"></div>
            <div class="card">
                
       
                 <div class="card-body width="70%">
                     <p>Total Items : <span class="badge badge-warning" id="count"><%= count  %></span></p>
                     <div id="table"">
                         <table id="cart_table" class="table table-bordered" >
                             <thead>
                                 <th width="1%"><input type="checkbox" class="checkAll form-control-inline" /></th>
                                 <th width="1%">No.</th>
                                 <th width="15%"></th>
                                 <th width="15%">Item</th>
                                 <th width="6%">Price per Unit (RM)</th>
                                 <th width="5%">Qty</th>
                                 <th width="8%">Price (RM)</th>
                                 <th width="10%">Delivery Fee (RM)</th>
                                 <th width="8%">Action</th>
                             </thead>

                             <tbody>
                                 <asp:Repeater ID="cartRepeater" runat="server">
                                     <ItemTemplate>
                                 <tr>
                                     <td><input type="checkbox" id="<%# Eval("id") %>" class="want form-control-inline" ></td>
                                     <td><%#Container.ItemIndex+1 %></td>
                                     <td>
                                         <a href="../Product/ViewProduct.aspx?prodID=<%# Eval("productID") %>" target="_blank">
                                      <img src="../Storage/ProductImage/<%#Eval("image")%> "/></a>
                                     </td>
                                     <td><%# Eval("name") %></td>
                                     <td><%# String.Format("{0:0.##}",Eval("price"))%></td> 
                                     <td><%# Eval("qty")%></td>
                                     <td class="price"><%# String.Format("{0:0.##}",Eval("total")) %></td>
                                     <td class="deliveryFee"><%# String.Format("{0:0.##}",Eval("deliveryFee"))%></td>
                                     <td>
                                         <a href="javascript:void(0)" id="<%# Eval("id") %>" class="editbtn" data-toggle="modal" data-target="#itemQty_Modal"><i class="bi-alarm bi-pencil-square"></i></a> 
                                         &emsp;
                                          <a href="removeCart.aspx?cartId=<%# Eval("id") %>" id="<%# Eval("id") %>"" class=" removebtn"><i class="bi-alarm bi-trash"></i></a>
                                     </td>
                                      


                                 </tr>
                                </ItemTemplate>
                                 </asp:Repeater>
                             </tbody>
                             <br >
                            
                             
                         </table>
                         <br />
                         <br />
                         
                         <table id="counter" class="table table-bordered">
                           <!--  <div class="row" >
                                 
                                     <div class="col-7"  id="voucherStat"></div>
                                 
                                    <div class="col-5"> Voucher Code &emsp; <input type="text" class="form-control-sm" id="voucher"/>&emsp; <button class="btn btn-primary">Apply</button></div>
                              
                              
                             </div>
                             <br />-->
                         
                             <tbody>
                               
                               
                                 <tr>
                                     <th width="70%" class="text-right">Subtotal (RM)</th>
                                     <td id="subtotal"></td>
                                 </tr>

                                  <tr>
                                     <th width="70%" class="text-right">Total DeliveryFee(RM)</th>
                                     <td id="totalDelivery"></td>
                                 </tr>


                                  <tr>
                                     <th width="70%" class="text-right">Grand Total (RM)</th>
                                     <td id="total"></td>
                                 </tr>
                             </tbody>
                         </table>
                         <div class="text-right">
                             <button class="btn btn-primary" id="checkout"><i class="bi-alarm bi-cart-check"></i> Checkout</button>

                         </div>
                         
                     </div>
                 </div>
            </div>
     </div>

    <!--modal-->
  
                    <div class="modal fade" id="itemQty_Modal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                          <div class="modal-dialog">
                            <div class="modal-content">
                              <div class="modal-header">
                                <h5 class="modal-title" id="exampleModalLabel">Edit Qty</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                  <span aria-hidden="true">&times;</span>
                                </button>
                              </div>
                              <div class="modal-body">
                              <input type="hidden" id="itemid"  />
                                   <div class=" form-group row">
                                         <div class="col-sm-4">
                                             <label for="modal_item">Item :</label>
                                         </div>
                                         <input type="text" id="modal_item" class="form-control"style="width:250px;" readonly/>
                                     </div>
                                     <div class=" form-group row">
                                         <div class="col-4">
                                             <label for="modal_qty">Quantity :</label>
                                         </div>
                                         <input type="number" id="modal_qty" min="1" class="form-control"style="width:65px;" />

                                     </div>
                                  
                              </div>
                              <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-dismiss="modal" id="close">Close</button>
                                  <button class="btn btn-success" id="update">Update</button>
                              </div>
                            </div>
                          </div>
                    </div>


                    <!--end modal-->

    <script>
        $(document).ready(function () {
            uncheckall();
            $('#discount').html(0.00);
            $('#totalDelivery').html(0.00);
            $('#total').html(0.00);
            $('#subtotal').html(0.00);

            var deliverydiscount = 0;
            var voucherdiscount = 0;
            var subtotal = 0;
            var totalDelivery = 0;
            var total = 0;
            var redeem = false;
            var freeDeliveryRedeem = false;
            var row = $('#cart_table tbody tr').length;
            // calculate();
            //show Voucher

            var selected = [];
            var price = [];
            var deliFee = [];
            // calculate total 

            function resetAmount() {
                deliverydiscount = 0;
                voucherdiscount = 0;
                subtotal = 0;
                totalDelivery = 0;
                total = 0;
                redeem = false;
            }
            function uncheckall(){
                $(".want").prop("checked", false);
            }

            $('.checkAll').click(function () {
                $('.want').click();
                if (this.checked) {
                    $(".want").prop("checked", true);

                } else {
                    $(".want").prop("checked", false);

                    if (freeDeliveryRedeem == true) {
                        cancelFreeDelivery();
                    }
                    if (redeem == true) {

                        unlockVoucher();
                    }
                    resetAmount();
                    selected = [];
                    price = [];
                    deliFee = [];
                }
                calculate();

            });

            $('.want').click(function () {
                var numberOfCheckboxes = $(".want").length;
                var numberOfCheckboxesChecked = $('.want:checked').length;
                if (numberOfCheckboxes == numberOfCheckboxesChecked) {
                    $(".checkAll").prop("checked", true);
                } else {
                    $(".checkAll").prop("checked", false);

                    resetAmount();


                }
                calculate();
            });


            $(document).on('change', '.want', function () {
                var thisid = $(this).attr("id");
                var currentRow = $(this).closest("tr");
                var itemName = currentRow.find("td:eq(3)").text();
                var itemPrice = currentRow.find("td:eq(6)").text();
                var itemDeliveryFee = currentRow.find("td:eq(7)").text();


                if ($(this).is(":checked")) {
                    selected.push(thisid);
                    price.push(itemPrice);
                    deliFee.push(itemDeliveryFee);


                }
                else if ($(this).is(":not(:checked)")) {
                    for (var i = 0; i < selected.length; i++) {

                        if (selected[i] == thisid) {
                            selected.splice(i, 1);

                        }
                        if (price[i] == itemPrice) {
                            price.splice(i, 1);

                        }
                        if (deliFee[i] == itemDeliveryFee) {
                            deliFee.splice(i, 1);
                        }
                    }
                }
                calculate();


            })



            function calculate() {

                //alert(row)
                subtotal = 0;
                // sum up all items price and delivery fee
                for (var i = 0; i < price.length; i++) {
                    subtotal += parseFloat(price[i]);

                }

                $('#subtotal').html(subtotal.toFixed(2));
                getTotalDelivery();
                calTotal();
            }

            function getTotalDelivery() {
                // sum up all items price and delivery fee
                totalDelivery = 0;
                for (var i = 0; i < deliFee.length; i++) {

                    // totalDelivery += parseFloat($('.deliveryFee').eq(i).html())
                    totalDelivery += parseFloat(deliFee[i]);
                }
                $('#totalDelivery').html(totalDelivery.toFixed(2));
            }

            function calTotal() {
                total = (subtotal + totalDelivery) - deliverydiscount - voucherdiscount;
                var totaldiscount = deliverydiscount + voucherdiscount;
                $('#discount').html("- " + totaldiscount.toFixed(2));
                $('#total').html(total.toFixed(2));
            }

            //delivery Voucher
          
            //Modal and update qty

            $('#cart_table').on('click', '.editbtn', function () {
                var itemID = $(this).attr('id');

                var currentRow = $(this).closest("tr");
                var itemName = currentRow.find("td:eq(3)").text();
                var itemQty = currentRow.find("td:eq(5)").text();
                $('#modal_item').val(itemName);
                $('#modal_qty').val(itemQty);
                $('#itemid').val(itemID);



            })

            $('#update').click(function () {
                var itemID = $('#itemid').val();
                var itemQty = $('#modal_qty').val();
                var url = "updateCart.aspx?id=" + itemID + "&qty=" + itemQty;
                location.href = url;
            })

            $('#checkout').click(function () {
                if (total <= 0) {
                    alert("Please select an item to place order");
                } else {
                     var url = "../setcheckoutsession.aspx?item=" + selected;
                    location.href = url;
                }
              
            });

           


        });

       
      
    </script>
</asp:Content>
