<%@ Page Title="" Language="C#" MasterPageFile="~/Layout/SellerSite.Master" AutoEventWireup="true" CodeBehind="addProduct.aspx.cs" Inherits="SupremeArt.seller.addProduct" %>
<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
    Add Product
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
                <asp:Literal ID="msg" runat="server"></asp:Literal>
                 <form id="Additem" runat="server">
             
                     <table class="table" width="50%">
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
                 
                             <asp:TextBox ID="price" runat="server" CssClass="form-control"></asp:TextBox>
                             <asp:RequiredFieldValidator ID="price_rvalidation" runat="server" ErrorMessage="*Price is required" ControlToValidate="price" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                             <asp:RegularExpressionValidator ID="price_validation" runat="server" ErrorMessage="Only Number is Allowed" ControlToValidate="price" Font-Bold="False" Font-Italic="False" ForeColor="Red" ValidationExpression="^\d+.\d{0,2}$" Display="Dynamic"></asp:RegularExpressionValidator>

                         </td>
                     </tr>

                     <tr>
                         <th>Stock</th>
                         <td>
                 
                             <asp:TextBox ID="stock" TextMode="Number" runat="server" CssClass="form-control"></asp:TextBox>
                             <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="*Stock is Required" Display="Dynamic" ControlToValidate="stock" ForeColor="Red"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="stock_validation" runat="server" ErrorMessage="Quantity must between 0 and 999" ControlToValidate="stock" Font-Bold="False" Font-Italic="False" ForeColor="Red" ValidationExpression="^[0-9]{0,3}$" Display="Dynamic"></asp:RegularExpressionValidator>

                         </td>
                     </tr>
 
                     <tr>
                         <th>Product Description</th>
                         <td>
                 
                             <asp:TextBox ID="desc" TextMode="MultiLine"  runat="server" CssClass="form-control paragraph"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rv_proddesc" runat="server" ErrorMessage="*Product Description is Required" ControlToValidate="desc" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
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

                             <asp:TextBox ID="deliveryFee"  runat="server" CssClass="form-control smallBox "></asp:TextBox>

                             <asp:CheckBox ID="freeDeli" runat="server" CssClass="form-check-inline" onchange="freeDelivery()"/>
                             <span>Free Delivery</span><br />
                             <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*Delivery Fee is Required" Display="Dynamic" ControlToValidate="deliveryFee" ForeColor="Red"></asp:RequiredFieldValidator>
                          <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Only number allowed" ControlToValidate="stock" Font-Bold="False" Font-Italic="False" ForeColor="Red" ValidationExpression="^[0-9]{0,3}$" Display="Dynamic"></asp:RegularExpressionValidator>

                         </td>
                     </tr>
 
 
                     <tr>
                     <th>Product Image</th>
                     <td>

                         <asp:FileUpload ID="image" runat="server" CssClass="d-none" onchange="image_select()" />
<%--                        <input type="file" name="image" id="image" multiple="multiple" class="d-none" onchange="image_select();">--%>
                              <button class="btn btn-outline-primary" type="button" onclick="document.getElementById('<%=image.ClientID %>').click()" >Browse</button><br />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Image is Required" Display="Dynamic" ControlToValidate="image" ForeColor="Red"></asp:RequiredFieldValidator>
                
                     </td>
                     </tr>
             
                     <tr>
                         <th></th>
                 
                         <td> 
                             <span id="invalid"></span>
                             <div class="row" id="image-container">
                     
                             </div>
                         </td>
                     </tr>
                 </table>
                     <div align="center"> 
                         <asp:Button ID="submit" runat="server" Text="Add Product" CssClass="btn btn-primary" OnClick="submit_Click" />
                     </div>
            
         </form>
            </div>
        </div>
    </div>

    <script>
        function freeDelivery() {
            var deliFee = document.getElementById("<%=deliveryFee.ClientID%>")
            if (document.getElementById("<%=freeDeli.ClientID%>").checked) {
                deliFee.readOnly = "readonly";
                var free = 0;
                deliFee.value =free

            } else {
             
                deliFee.readOnly = "";
                
            }

        }
           
        

        var images = [];
        var imageFile = document.getElementById("<%=image.ClientID%>");
        var isValid = false;
        var error = document.getElementById("invalid");
        function image_select() {
            var image = document.getElementById("<%=image.ClientID%>").files;
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
        if (window.history.replaceState) {
            window.history.replaceState(null, null, window.location.href);
        }

    </script>
</asp:Content>
