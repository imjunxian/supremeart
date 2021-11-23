<%@ Page Title="" Language="C#" MasterPageFile="~/Layout/SellerSite.Master" AutoEventWireup="true" CodeBehind="editProduct.aspx.cs" Inherits="SupremeArt.seller.editProduct" %>
<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
    Edit Product Details
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="server">
     <style>
        .smallBox{
            width:100px;
        }
        .paragraph{
            height:200px;
        }
    </style>
    <link href="../admin/assets/css/imageDisplay.css" rel="stylesheet" />
    <div class="card">
        <div class="card-body">
            <div class="container-fluid">
                <div id="divmsg" runat="server">
                    
                </div>
                 <form id="Additem" runat="server">
             
                     <table class="table" width="50%">
                     <tr>
             
                         <th >Product ID</th>
             
             
                         <td>
                            <asp:TextBox ID="prod_id" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>                    

                         </td>
                     </tr> 
                     <tr>
             
                         <th >Product Name</th>
             
             
                         <td>
                            <asp:TextBox ID="prod_name" runat="server" CssClass="form-control"></asp:TextBox>                    
                              <asp:RequiredFieldValidator ID="prodname_rvalidation" runat="server" ErrorMessage="*[Product Name is Required]" ControlToValidate="prod_name" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                         </td>
                     </tr>
 
                     <tr>
                         <th>Price (RM)</th>
                         <td>
                 
                             <asp:TextBox ID="prod_price" runat="server" CssClass="form-control"></asp:TextBox>
                             <asp:RequiredFieldValidator ID="price_rvalidation" runat="server" ErrorMessage="*Price is required" ControlToValidate="prod_price" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                             <asp:RegularExpressionValidator ID="price_validation" runat="server" ErrorMessage="Only Number is Allowed" ControlToValidate="prod_price" Font-Bold="False" Font-Italic="False" ForeColor="Red" ValidationExpression="^\d+.\d{0,2}$" Display="Dynamic"></asp:RegularExpressionValidator>
                         </td>
                     </tr>

                     <tr>
                         <th>Stock</th>
                         <td>
                 
                             <asp:TextBox ID="prod_stock" TextMode="Number" runat="server" CssClass="form-control"></asp:TextBox>
                                 <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="*Stock is Required" Display="Dynamic" ControlToValidate="prod_stock" ForeColor="Red"></asp:RequiredFieldValidator>
                              <asp:RegularExpressionValidator ID="stock_validation" runat="server" ErrorMessage="Only number allowed" ControlToValidate="prod_stock" Font-Bold="False" Font-Italic="False" ForeColor="Red" ValidationExpression="^[0-9]{0,3}$" Display="Dynamic"></asp:RegularExpressionValidator>

                         </td>
                     </tr>
 
                     <tr>
                         <th>Product Description</th>
                         <td>
                 
                             <asp:TextBox ID="prod_des" TextMode="MultiLine"  runat="server" CssClass="form-control paragraph"></asp:TextBox>
                         <asp:RequiredFieldValidator ID="rv_proddesc" runat="server" ErrorMessage="*Product Description is Required" ControlToValidate="prod_des" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                         </td>
                     </tr>

                     <tr>
                        <th>Product Category</th>
                        <td>
                              
                            <asp:DropDownList ID="prodCat" CssClass="form-control" runat="server" AutoPostBack ="false">
                            <asp:ListItem Text ="Basic" Value ="Basic"></asp:ListItem>
                            <asp:ListItem Text ="Premium" Value ="Premium"></asp:ListItem>
                            </asp:DropDownList>

                        </td>
                    </tr>

                     <tr>
                         <th>Delivery Fees (RM)</th>
                         <td>

                             <asp:TextBox ID="prod_deliveryFee"  runat="server" CssClass="form-control smallBox "></asp:TextBox>

                             <asp:CheckBox ID="freeDeli" runat="server" CssClass="form-check-inline" onchange="freeDelivery()"/>
                             <span>Free Delivery</span><br />
                             <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*Delivery Fee is Required" Display="Dynamic" ControlToValidate="prod_deliveryFee" ForeColor="Red"></asp:RequiredFieldValidator>
                             <asp:RegularExpressionValidator ID="deliFee_validation" runat="server" ErrorMessage="Only Numbers is Allowed" ControlToValidate="prod_deliveryFee" Font-Bold="False" Font-Italic="False" ForeColor="Red" ValidationExpression="^\d+$" Display="Dynamic"></asp:RegularExpressionValidator>

                         </td>
                     </tr>
 
 
                     <tr>
                     <th>Product Image</th>
                     <td>

                         <asp:FileUpload ID="prod_image" runat="server" CssClass="d-none" onchange="image_select()" />
<%--                        <input type="file" name="image" id="image" multiple="multiple" class="d-none" onchange="image_select();">--%>
                              <button class="btn btn-outline-primary" type="button" onclick="document.getElementById('<%=prod_image.ClientID %>').click()" >Browse</button>
                         
                
                
                     </td>
                     </tr>
             
                     <tr>
                         <th></th>
                 
                         <td> 
                             <span id="invalid"></span>
                             <div class="row" id="image-container">
                                    <div class="image_container d-flex justify-content-center position-relative" id="imageCon" runat="server">
                                      
                                    </div>
                             </div>
                         </td>
                     </tr>
                 </table>
                     <div align="center"> 
                         <asp:Button ID="update" runat="server" Text="Save Changes" CssClass="btn btn-primary" OnClick="update_Click" />
                     </div>
            
         </form>
            </div>
        </div>
    </div>

    <script>
       

        function freeDelivery() {
            var deliFee = document.getElementById("<%=prod_deliveryFee.ClientID%>")
            if (document.getElementById("<%=freeDeli.ClientID%>").checked) {
                deliFee.readOnly = "readonly";
                deliFee.value = 0;

            } else {
             
                deliFee.readOnly = "";
                
            }

        }
           
        

        var images = [];
        var imageFile = document.getElementById("<%=prod_image.ClientID%>");
        var isValid = false;
        var error = document.getElementById("invalid");
        function image_select() {
            var image = document.getElementById("<%=prod_image.ClientID%>").files;
            isValid = ValidateFile();
            if (isValid) {
                var i = 0;
                images.push({
                    "name": image[i].name,
                    "url": URL.createObjectURL(image[i]),
                    "file": image[i],
                })



                document.getElementById('image-container').innerHTML = image_show();
            } else {
                image = null;
               
            }
            
        }

        function check_duplicate(name) {
            var image = true;
            if (images.length > 0) {
                for (e = 0; e < images.length; e++) {
                    if (images[e].name == name) {
                        image = false;
                        break;
                    }
                }
            }
            return image;
        }

        function image_show() {
            var image = "";
            images.forEach((i) => {
                image = '<div class="image_container d-flex justify-content-center position-relative"> <img src="' + i.url + '" alt="" class="img-thumbnail" id="image_preview"> <span class="position-absolute" onclick="delete_image(`+ images.indexOf(i) +`)"><i class="ti ti-close"></i></span></div>';
            })
            return image;
        }

        function delete_image(e) {
            images.splice(e, 1);
            document.getElementById('image-container').innerHTML = image_show();
        }

        function ValidateFile() {

            var validFilesTypes = ["jpg","png","jpeg"];



            var path = imageFile.value;

            var ext = path.substring(path.lastIndexOf(".") + 1, path.length).toLowerCase();

            var isValidFile = false;

            for (var i = 0; i < validFilesTypes.length; i++) {

                if (ext == validFilesTypes[i]) {

                    isValidFile = true;
                    error.innerHTML = "";
                    break;

                }

            }

            if (!isValidFile) {

                
                imageFile.value = null;

                error.innerHTML = "<p class='text text-danger'>Only (png,jpg,jpeg) file types are allowed to upload";
                delete_image(this);

            }

            return isValidFile;

        }

    </script>
</asp:Content>
