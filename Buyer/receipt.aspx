<%@ Page Title="" Language="C#" MasterPageFile="~/Layout/LoginLayout.Master" AutoEventWireup="true" CodeBehind="receipt.aspx.cs" Inherits="SupremeArt.Buyer.receipt" %>
<asp:Content ID="Content1" ContentPlaceHolderID="content" runat="server">

     <style>
    .table {
    border-radius: 5px;
    width: 50%;
    margin: 0px auto;
    float: none;
}
    .invoice-buttons a{
       color:none;
    }

    .logo-image{
            width:300px;
            heigth:300px;
    }

</style>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">
    <div class="text-left">

        <a href="orderhistory.aspx" class=" btn btn-outline-primary" onclick="close();">Back to Order History Page</a>
    </div>
<div class="row">
                    <div class="col-lg-12 mt-5">
                        <div class="card" id="invoice_div">
                            <div class="card-body">
                                <div class="invoice-area">
                                    <div class="invoice-head">
                                        <div class="row">
                                            <div class="iv-left col-6">
                                            <div class="logo-image">
                                                <a href="#">
                                                    <img src="../assets/img/logo.png" alt="logo" />

                                                </a>
                                            </div>
                                                <span>RECEIPT</span>
                                            </div>
                                            <div class="iv-right col-6 text-md-right">
                                                <div id="orderid"> <span id="order_id" runat="server"></span></div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row align-items-center">
                                        <div class="col-md-6">
                                            <div class="invoice-address">
                                                <h3>Invoiced To</h3>
                                                <h5 runat="server" ID="custname"></h5>
                                                <p runat="server" id="add1"></p>
                                                <p runat="server" id="add2"></p>
                                                
                                            </div>
                                        </div>
                                        <div class="col-md-6 text-md-right">
                                            <ul class="invoice-date">
                                                <li>Order Date : <span id="orderdate" runat="server"></span></li>
                                               
                                            </ul>
                                        </div>
                                    </div>
                                    <div class="invoice-table table-responsive mt-5">
                                        
                                        <table class="table table-bordered table-hover text-right " style="width:80%;" align="center">
                                            <thead>
                                                <tr class="text-capitalize">
                                                    <th class="text-center" >No.</th>
                                                    <th class="text-left" style="width: 40%;">Item</th>
                                                    <th>Qty</th>
                                                    <th style="min-width: 100px">Price(RM)</th>
                                                    <th>total</th>
                                                </tr>
                                            </thead>
                                            <tbody>

                                                <asp:Repeater ID="itemRepeater" runat="server">

                                                    <ItemTemplate>
                                                        <tr>
                                                            <td class="text-center"><%# Container.ItemIndex+1 %></td>
                                                            <td class="text-left"><%# Eval("prodname") %></td>
                                                            <td><%#Eval("qty") %></td>
                                                            <td><%# String.Format("{0:0.00}",Eval("prodprice")) %></td>
                                                            <td><%# String.Format("{0:0.00}",Eval("price")) %></td>
                                                        </tr>

                                                    </ItemTemplate>
                                                </asp:Repeater>
                                                
                                               
                                            </tbody>
                                            <tfoot>
                                                <tr>
                                                    <td></td>
                                                    <td></td>
                                                    <td></td>
                                                    <td colspan="">SubTotal (RM)</td>
                                                    <td id="thisSubtotal" runat="server"></td>
                                                </tr>
                                                <tr>
                                                    <td></td>
                                                    <td></td>
                                                    <td></td>
                                                    <td colspan="">Total Delivery(RM)</td>
                                                    <td id="ttldelivery" runat="server"></td>
                                                </tr>
                                                <tr>
                                                    <td></td>
                                                    <td></td>
                                                    <td></td>
                                                    <td colspan="">Total Discount (RM)</td>
                                                    <td id="ttldiscount" runat="server"></td>
                                                </tr>

                                                <tr>
                                                    <td></td>
                                                    <td></td>
                                                    <td></td>
                                                    <td colspan="">Total(RM)</td>
                                                    <td id="ttl" runat="server"></td>
                                                </tr>
                                            </tfoot>
                                        </table>
                                    </div>
                                </div>
                               
                            </div>
                        </div>
                        <br>
						 <div class="text-right">
                                    <!-- <a href="#" class="invoice-btn" id="print">print invoice</a>
                                    <a href="#" class="invoice-btn" id="saveImg" onclick="downloadtable();">Save as Image</a> -->
                                    <div class="dropdown">
                                        <a class="btn btn-primary dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                        <i class="bi bi-download"></i>&emsp;Save As
                                        </a>

                                        <div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
                                            <a class="dropdown-item" href="#" id="saveImg" onclick="downloadtable()"><i class="bi bi-image" ></i>&emsp;Image</a>
                                            <a class="dropdown-item" href="#" id="pdf"><i class="bi bi-file-earmark-pdf-fill"></i>&emsp;PDF</a>
                                            <a class="dropdown-item" href="#" onclick="printDiv();"><i class="bi bi-printer"></i>&emsp;Print</a>
                                        </div>
                                    </div>
                            </div>

                                  
                          </div>
                    </div>
                </div>
            </div>
</div>
<script src="https://cdnjs.cloudflare.com/ajax/libs/dom-to-image/2.6.0/dom-to-image.js"></script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.9.2/html2pdf.bundle.js"></script>
<script>
    //var invoiceName = 'ORDER_' + document.getElementById('orderid').children("span#order_id").innerText;
    var invoiceName = document.getElementById("<%=order_id.ClientID%>").innerHTML;
    window.onload = function () {
       
    document.getElementById("pdf")
        .addEventListener("click", () => {
            const invoice = this.document.getElementById("invoice_div");
            console.log(invoice);
            console.log(window);
            var opt = {
                margin: 1,
                filename: invoiceName+'.pdf',
                image: { type: 'jpeg', quality: 0.98 },
                html2canvas: { scale: 2 },
                jsPDF: { unit: 'in', format: 'letter', orientation: 'portrait' }
            };
            html2pdf().from(invoice).set(opt).save();
        })

}

function downloadtable() {

var node = document.getElementById('invoice_div');

domtoimage.toPng(node)
    .then(function (dataUrl) {
        var img = new Image();
        img.src = dataUrl;
        downloadURI(dataUrl, invoiceName+".png")
    })
    .catch(function (error) {
        console.error('oops, something went wrong!', error);
        alert(error);
    });

}



function downloadURI(uri, name) {
var link = document.createElement("a");
link.download = name;
link.href = uri;
document.body.appendChild(link);
link.click();
document.body.removeChild(link);
delete link;

}

function printInvoice() {
            var divContents = document.getElementById("invoice_div").innerHTML;
            var a = window.open('', '', 'height=500, width=500');
            a.document.write(divContents);
            a.document.close();
            a.print();
        }

        function printDiv(){
			var printContents = document.getElementById("invoice_div").innerHTML;
			//var originalContents = document.body.innerHTML;

			document.body.innerHTML = printContents;

			window.print();
            window.location.reaload();
			//.document.body.innerHTML = originalContents;

		}


    function download(text, name, type) {
        var a = document.getElementById("a");
        var file = new Blob([text], { type: type });
        a.href = URL.createObjectURL(file);
        a.download = name;
    }

    function close() {
        window.close();
    }

</script>
</asp:Content>
