<%@ Page Title="" Language="C#" MasterPageFile="~/Layout/SellerSite.Master" AutoEventWireup="true" CodeBehind="salesReport.aspx.cs" Inherits="SupremeArt.seller.salesReport" %>
<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
    Sales Report
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="server">
    <br />
    <br />
    <br />
    <div class="container-lg">
        <div class="card">
            <div class="card-body">
                <div class="row">
                    <span id="msg" runat="server"></span>
                </div>
                <br />
                <div class="form-group row">
                    <div id="showdate" runat="server"></div>
                        <div class="col-sm-2">
                           <label for="#date" >Select Date</label>
                        </div>

                        <div class=" col-8">
                            <form runat="server">

                                <input type="date" runat="server" class="form-control" id="date" style="width:200px;">
                                &emsp;
                                <asp:Button ID="generate" runat="server" CssClass="btn btn-outline-primary" Text="Generate" OnClick="generate_Click"/>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Please select date" ControlToValidate="date" CssClass="text-danger"></asp:RequiredFieldValidator>
                            </form>
                           
                        </div>

                    
                    
                </div>

                <br />
                <br />
                <br />

                <div id="reportTable">
                    <table id="salestable" class="table table-bordered">
                        <thead>
                            <th>No.</th>
                            <th>Product Name</th>
                            <th>Qty</th>
                            <th>Price</th>
                            <th>Total Price</th>
                           
                            <th>Order Date</th>
                        </thead>

                        <tbody>
                          
                              <asp:Repeater ID="report" runat="server">
                                  <ItemTemplate>
                                        <tr>
                                            <td><%#Container.ItemIndex+1 %></td>
                                            <td><%# Eval("prodname") %></td>
                                            <td><%# Eval("qty") %></td>
                                            <td><%#String.Format("{0:0.##}",Eval("prodprice")) %> </td>
                                            <td><%#String.Format("{0:0.##}",Eval("price")) %></td>

                                            
                                            <td><%# Eval("orderdate") %></td>
                                        </tr>
                                  </ItemTemplate>
                              </asp:Repeater>
                        </tbody>
                    </table>

                </div>
                <!--export Button-->
                      <div class="text-right">
                                 
                                    <div class="dropdown">
                                        <a class="btn btn-primary dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                        <i class="bi bi-download"></i>&emsp;Save As
                                        </a>

                                        <div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
                                            <a class="dropdown-item" href="#" id="downloadExcel" ><i class="bi bi-file-spreadsheet-fill" ></i>&emsp;Excel Spreadsheet</a>
                                            <a class="dropdown-item" href="#" id="pdf"><i class="bi bi-file-earmark-pdf-fill"></i>&emsp;PDF</a>
                                            <a class="dropdown-item" href="#" onclick="printDiv();"><i class="bi bi-printer"></i>&emsp;Print</a>
                                        </div>
                                    </div>
                            </div>

                <!--end-->
            </div>
        </div>
    </div>
   
    <script src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.9.2/html2pdf.bundle.js"></script> 
    <script src="../assets/js/table2excel.js"></script>
<script>
    //var invoiceName = 'ORDER_' + document.getElementById('orderid').children("span#order_id").innerText;
   
    window.onload = function () {

        document.getElementById("downloadExcel")
            .addEventListener("click", () => {
                var table2excel = new Table2Excel();
                
                table2excel.export(document.querySelectorAll("#salestable"));
            });
       
    document.getElementById("pdf")
        .addEventListener("click", () => {
            const invoice = this.document.getElementById("reportTable");
            console.log(invoice);
            console.log(window);
            var opt = {
                margin: 1,
                filename: "SalesReport"+'.pdf',
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
            var divContents = document.getElementById("reportTable").innerHTML;
            var a = window.open('', '', 'height=500, width=500');
            a.document.write(divContents);
            a.document.close();
            a.print();
        }

        function printDiv(){
			var printContents = document.getElementById("reportTable").innerHTML;
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
