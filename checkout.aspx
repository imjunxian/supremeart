<%@ Page Title="" Language="C#" MasterPageFile="~/Layout/LoginLayout.Master" AutoEventWireup="true" CodeBehind="checkout.aspx.cs" Inherits="SupremeArt.Buyer.checkout" %>
<asp:Content ID="Content1" ContentPlaceHolderID="content" runat="server">
    <link href="assets/css/image.css" rel="stylesheet" />
    <style>
        .voucher{
            background-color:peachpuff;
        }
    </style>

    <div class="text-left">
        <a href="../Buyer/Cart.aspx" class="btn btn-outline-primary"><i class="ti ti-bag"></i>&emsp;Back To Cart</a>
    </div>
    <br />
    <br />

    <div class="container">
         <div class="row">
                <!--left side -->
                <div class="col-md-12"> 
                    <h1 align="center">Checkout</h1>
                    <div class="card">
                        <div class="card-body">
                            <h4>Selected Item(s):</h4>

                            <div id="table">
                                <table id="cart_table" class="table table-bordered" >
                                     <thead>
                                        
                                         <th width="1%">No.</th>
                                         <th width="15%"></th>
                                         <th width="15%">Item</th>
                                         <th width="6%">Price per Unit (RM)</th>
                                         <th width="5%">Qty</th>
                                         <th width="8%">Price (RM)</th>
                                         <th width="10%">Delivery Fee (RM)</th>
                                        
                                     </thead>

                                     <tbody>
                                         <asp:Repeater ID="checkoutRepeater" runat="server">
                                             <ItemTemplate>
                                                 <tr>
                                                     <td><%#Container.ItemIndex+1 %></td>
                                                     <td>
                                                 
                                                      <img src="../Storage/ProductImage/<%#Eval("image")%> "/>
                                                     </td>
                                                     <td><%# Eval("name") %></td>
                                                     <td><%# String.Format("{0:0.##}",Eval("price"))%></td> 
                                                     <td><%# Eval("qty")%></td>
                                                     <td class="price"><%# String.Format("{0:0.##}",Eval("total")) %></td>
                                                     <td class="deliveryFee"><%# String.Format("{0:0.##}",Eval("deliveryFee"))%></td>
                                           
                                      


                                                 </tr>
                                             </ItemTemplate>
                                         </asp:Repeater>
                                     </tbody>
                                      

                                   
                                 </table>
                                
                                  <br />
                             <span class="font-italic">** Discount rate will depends on the amount of Subtotal**</span> <br />
                              <span class="font-italic">** The voucher cannot be mixed (Exclude free delivery voucher)**</span>
                             <div id="discount_stat">

                             </div>
                             
                             <div class="row">
                                 <div class="card voucher" style="width: 16rem;">
                                      <div class="card-body">
                                        <h5 class="card-title">FREE DELIVERY</h5>
                                        <h6 class="card-subtitle mb-2 text-muted">Spend RM 150 and above</h6>
                                       
                                          <div id="freeDelDiv">
                                        <a href="javascript:void(0)" id="freedelvoucher" class=" card-link">Use Now</a>
                                        </div>
                                      </div>
                                </div> &emsp;

                                  <div class="card voucher" style="width: 16rem;">
                                      <div class="card-body">
                                        <h5 class="card-title">5% OFF</h5>
                                        <h6 class="card-subtitle mb-2 text-muted">Spend RM 300 and above</h6>
                                       
                                        <a href="javascript:void(0)" id="5off" class="useVoucher card-link">Use Now</a>
                                       
                                      </div>
                                </div> &emsp;

                                  <div class="card voucher" style="width: 16rem;">
                                      <div class="card-body">
                                        <h5 class="card-title">10 % OFF</h5>
                                        <h6 class="card-subtitle mb-2 text-muted">Spend RM 650 and above</h6>
                                       
                                        <a href="javascript:void(0)" id="10off" class="useVoucher card-link" >Use Now</a>
                                       
                                      </div>
                                </div> &emsp;

                                  <div class="card voucher" style="width: 16rem;">
                                      <div class="card-body">
                                        <h5 class="card-title">25% OFF </h5>
                                        <h6 class="card-subtitle mb-2 text-muted">Spend RM 1000 and above </h6>
                                       
                                        <a href="javascript:void(0)" id="25off" class="useVoucher card-link">Use Now</a>
                                       
                                      </div>
                                </div> &emsp;
                             </div>
                           
                            
                           
                        
                           
                            

                        </div>
                    </div>
                    <br />
                  
                </div>

            </div>
    </div>

        <div class="row">
            <div class="col-md-7">
                <div class="card" style="background-color:black">
                    <div class="card-body" style="background-color:ghostwhite">
                        <table class="table table-borderedless">
                            <tr>
                                <th>Subtotal (RM)</th>
                                <td id="subtotal"></td>
                            </tr>
                             <tr>
                                <th>Total Delivery Fee (RM)
                                    <br />
                                   <div id="applied"> </div>
                                
                                </th>
                                <td id="totalDelivery"></td>
                            </tr>
                             <tr>
                                <th>Total Discount (RM)</th>
                                <td id="discount"></td>
                            </tr>
                             <tr>
                                <th>Total (RM)</th>
                                <td id="total"></td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
            <!--end of col 7-->
            <div class="col-md-5">
                <div class="border">
                     <label for="" class="font-weight-bold">Shipping Address :</label>
                    <p id="address" runat="server"></p>
                </div>
                <br />
                <div  class="border">
                     <label for="paymentMethod" class="font-weight-bold">Select Payment Method:</label>
                            <div class="form-check">
                              <input class="form-check-input method" type="radio" name="exampleRadios" id="exampleRadios1" value="1" >
                              <label class="form-check-label" for="exampleRadios1">
                                  <i class="ti ti-credit-card"></i> &emsp; Credit / Debit Card
                              </label>
                               
                                
                            </div>
                        <br />
                            <div class="form-check">
                                  <input class="form-check-input method" type="radio" name="exampleRadios" id="exampleRadios2" value="2" disabled>
                                  <label class="form-check-label" for="exampleRadios2">
                                      <i class="ti ti-id-badge"></i> &emsp; Online Banking  &emsp;
                                  </label><label class="text-danger">**Currently unavailable**</label>
                              
                            </div>
                            <br />
                       
                 </div>
                <br />
                <br />
                <button class="btn btn-success" id="pay"><i class="ti ti-wallet"></i>&emsp;Pay</button>
              </div><!--End of col-5-->
        </div>

        <script>
            $(document).ready(function () {
                var deliverydiscount = 0;
                var voucherdiscount = 0;
                var totaldiscount;
                var subtotal = 0;
                var totalDelivery = 0;
                var total = 0;
                var redeem = false;
                var freeDeliveryRedeem = false;
                var row = $('#cart_table tbody tr').length;
                //select payment method
                var selected = 0;
                var method = "";

                var price = [];
                var deli = [];

                $('#pay').prop("disabled", true);
                $('.method').each(function () {
                    $(this).prop("checked", false);
                })
                $('.method').on('change', function () {
                    selected = $(this).val();
                    switch (selected) {
                        case '1':
                            method = "card";
                            break;
                        case '2':
                            method = "bank";
                            break;
                       
                    }

                    ableToPay();
                });

                function ableToPay() {
                    $('#pay').prop("disabled", false);
                }




                $('#discount').html(0.00);
                $('#totalDelivery').html(0.00);
                $('#total').html(0.00);
                $('#subtotal').html(0.00);

               
                calculate();

                function calculate() {

                    //alert(row)
                    subtotal = 0;
                    // sum up all items price and delivery fee
                    for (var i = 0; i < row; i++) {

                        subtotal += parseFloat($('.price').eq(i).html())
                        price.push(subtotal);

                    }

                    $('#subtotal').html(subtotal.toFixed(2));
                    getTotalDelivery();
                    calTotal();
                }

                function getTotalDelivery() {
                    // sum up all items price and delivery fee
                    totalDelivery = 0;
                    for (var i = 0; i < row; i++) {

                        totalDelivery += parseFloat($('.deliveryFee').eq(i).html())
                        deli.push(totalDelivery);
                    }
                    $('#totalDelivery').html(totalDelivery.toFixed(2));
                }

                function calTotal() {
                    total = (subtotal + totalDelivery) - deliverydiscount - voucherdiscount;
                     totaldiscount = deliverydiscount + voucherdiscount;
                    $('#discount').html("- " + totaldiscount.toFixed(2));
                    $('#total').html(total.toFixed(2));
                }

                //delivery Voucher
                $('#freedelvoucher').click(function () {
                    if (deliverydiscount != 0 && totalDelivery != 0) {
                        cancelFreeDelivery();
                        $(this).html("Use Now");
                    }
                    else if (deliverydiscount <= 0) {

                        if (totalDelivery != 0) {
                            if (subtotal >= 150) {
                                freedelivery();
                                $(this).html("Cancel");
                            }
                            else {
                                voucherError(0);
                            }
                        } else {
                            $('#discount_stat').html("<p class='alert alert-danger'>Delivery fee must more than RM0 only able to redeem this voucher</p>");
                        }

                    }



                })


                $('.useVoucher').on('click', function () {
                    var type = $(this).attr("id");

                    if (redeem == false) {
                        switch (type) {

                            case "5off":

                                if (subtotal >= 300) {
                                    calDiscountAmount(0.05);
                                    voucherRedeem();
                                    $(this).html('Cancel');
                                    lockVoucher(0);

                                }
                                else {
                                    voucherError(1);
                                }
                                break;
                            case "10off":
                                if (subtotal >= 650) {
                                    calDiscountAmount(0.1);
                                    voucherRedeem();
                                    $(this).html('Cancel');
                                    lockVoucher(1);
                                } else {
                                    voucherError(2);
                                }
                                break;
                            case "25off":
                                if (subtotal >= 1000) {
                                    calDiscountAmount(0.25);
                                    voucherRedeem();
                                    $(this).html("Cancel");
                                    lockVoucher(2);
                                }
                                else {
                                    voucherError(3);
                                }



                        }






                    }
                    else {
                        unlockVoucher();

                    }


                });





                function lockVoucher(x) {
                    var voucher = ["5off", "10off", "25off"];
                    voucher.splice(x, 1);

                    for (var i = 0; i < voucher.length; i++) {
                        $('#' + voucher[i]).html("");

                    }
                }

                function unlockVoucher() {
                    redeem = false;
                    cancelVoucher();
                    var voucher = ["5off", "10off", "25off"];


                    for (var i = 0; i < voucher.length; i++) {
                        $('#' + voucher[i]).html("Use Now");
                    }
                    $('#discount_stat').html("<p class='alert alert-danger'>Voucher cancelled</p>");
                }

                function cancelVoucher() {
                    voucherdiscount = 0;
                    redeem = false;
                    calTotal();
                }

                function calDiscountAmount(rate) {
                    var discountAmount = subtotal * rate;
                    voucherdiscount = discountAmount;
                    calTotal();
                }

                function voucherError(x) {
                    var error = "";
                    switch (x) {
                        case 0:

                            error = "Must purchase at least RM150 to redeem this voucher";

                            break;
                        case 1:
                            error = "Must purchase at least RM300 to redeem this voucher";
                            break;
                        case 2:
                            error = "Must purchase at least RM650 to redeem this voucher";
                            break;
                        case 3:
                            error = "Must purchase at least RM1000 to redeem this voucher";
                            break;
                        default:
                            error = "Invalid voucher";
                            break;


                    }
                    $('#discount_stat').html("<p class='alert alert-danger'>" + error + "</p>");

                }

                // voucher appliaed successfully
                function voucherRedeem(x) {
                    /* var voucher = ["5off", "10off", "25off"];
     
                     voucher.splice(x, 1);
                     for (var i = 0; i < voucher.length; i++) {
                         $('#' + voucher[i]).html("");
                     }*/
                    redeem = true;
                    $('#discount_stat').html("<p class='alert alert-success'>Voucher redeemed !</p>");
                }

                function freedelivery() {
                    var deliveryFee = $('#totalDelivery');
                    deliverydiscount += parseFloat(deliveryFee.html());
                    $('#totalDelivery').html("0.00");
                    $('#applied').html("<span class='text-danger'>**Voucher Applied**</span>");


                    calTotal();
                    $('#discount_stat').html("<p class='alert alert-success'>Free Delivery voucher redeemed !</p>");
                    freeDeliveryRedeem = true;
                }

                function cancelFreeDelivery() {
                    freeDeliveryRedeem = false;
                    deliverydiscount = 0;
                    $('#totalDelivery').html(totalDelivery.toFixed(2));
                    calTotal();
                    $('#discount_stat').html("<p class='alert alert-danger'>Voucher cancelled</p>");
                    $("#freedelvoucher").html("Use Now");
                    $('#applied').html("");
                }
                var thistotal = total.toFixed(2).toString();

                $('#pay').click(function () {
                    location.href = "paymentProcess.aspx?subtotal=" + subtotal + "&discount=" + totaldiscount + "&totaldelivery=" + totalDelivery+"&total=" + total + "&method=" + method+"&price="+price+"&delivery="+deli;
                });
            })
        </script>
   
   
</asp:Content>
