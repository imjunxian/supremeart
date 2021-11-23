<%@ Page Title="" Language="C#" MasterPageFile="~/Layout/AdminSite.Master" AutoEventWireup="true" CodeBehind="editProduct.aspx.cs" Inherits="SupremeArt.admin.editProduct" %>
<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
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
         
             
                     <table class="table" width="50%">
                         <asp:Literal ID="litResult" runat="server"></asp:Literal>
                     <tr>
             
                         <th >Product ID</th>
             
             
                         <td>
                            <asp:TextBox ID="prod_id" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>                    

                         </td>
                     </tr> 
                     <tr>
             
                         <th >Product Name</th>
             
             
                         <td>
                            <asp:TextBox ID="prod_name" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>                    

                         </td>
                     </tr>
 
                     <tr>
                         <th>Price (RM)</th>
                         <td>
                 
                             <asp:TextBox ID="prod_price" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                    
                         </td>
                     </tr>

                     <tr>
                         <th>Stock</th>
                         <td>
                 
                             <asp:TextBox ID="prod_stock" TextMode="Number" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                    
                         </td>
                     </tr>
 
                     <tr>
                         <th>Product Description</th>
                         <td>
                 
                             <asp:TextBox ID="prod_des" TextMode="MultiLine"  runat="server" CssClass="form-control paragraph" ReadOnly="true"></asp:TextBox>
                    
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

                             <asp:TextBox ID="prod_deliveryFee"  runat="server" CssClass="form-control smallBox " ReadOnly="true"></asp:TextBox>

                            
                         </td>
                     </tr>
 
 
                     <tr>
                     <th>Product Image</th>
                     <td>

                         <asp:FileUpload ID="prod_image" runat="server" CssClass="d-none" onchange="image_select()" ReadOnly="true"/>
<%--                        <input type="file" name="image" id="image" multiple="multiple" class="d-none" onchange="image_select();">--%>
                              <button class="btn btn-outline-primary" type="button" onclick="document.getElementById('<%=prod_image.ClientID %>').click()" disabled>Browse</button>
                        
                
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
                         <asp:Button ID="update" runat="server" Text="Save Changes" CssClass="btn btn-primary" OnClick="update_Click"/>
                     </div>
            
     
            </div>
        </div>
    </div>

    <script>
       


           
        

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
