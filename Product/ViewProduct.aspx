<%@ Page Title="" Language="C#" MasterPageFile="~/Layout/default.Master" AutoEventWireup="true" CodeBehind="ViewProduct.aspx.cs" Inherits="SupremeArt.Product.ViewProduct" %>
<asp:Content ID="Content1" ContentPlaceHolderID="content" runat="server">

    <style>
        body {
    background-color: #ecedee
}

.card {
    border: none;
    overflow: hidden
}

.thumbnail_images ul {
    list-style: none;
    justify-content: center;
    display: flex;
    align-items: center;
    margin-top: 10px
}

.thumbnail_images ul li {
    margin: 5px;
    padding: 10px;
    border: 2px solid #eee;
    cursor: pointer;
    transition: all 0.5s
}

.thumbnail_images ul li:hover {
    border: 2px solid #000
}

.main_image {
    display: flex;
    justify-content: center;
    align-items: center;
    border-bottom: 1px solid #eee;
    height: 400px;
    width: 100%;
    overflow: hidden
}

.heart {
    height: 29px;
    width: 29px;
    background-color: #eaeaea;
    border-radius: 50%;
    display: flex;
    justify-content: center;
    align-items: center
}

.content p {
    font-size: 12px
}

.ratings span {
    font-size: 14px;
    margin-left: 12px
}

.colors {
    margin-top: 5px
}

.colors ul {
    list-style: none;
    display: flex;
    padding-left: 0px
}

.colors ul li {
    height: 20px;
    width: 20px;
    display: flex;
    border-radius: 50%;
    margin-right: 10px;
    cursor: pointer
}

.colors ul li:nth-child(1) {
    background-color: #6c704d
}

.colors ul li:nth-child(2) {
    background-color: #96918b
}

.colors ul li:nth-child(3) {
    background-color: #68778e
}

.colors ul li:nth-child(4) {
    background-color: #263f55
}

.colors ul li:nth-child(5) {
    background-color: black
}

.right-side {
    position: relative
}

.search-option {
    position: absolute;
    background-color: #000;
    overflow: hidden;
    align-items: center;
    color: #fff;
    width: 200px;
    height: 200px;
    border-radius: 49% 51% 50% 50% / 68% 69% 31% 32%;
    left: 30%;
    bottom: -250px;
    transition: all 0.5s;
    cursor: pointer
}

.search-option .first-search {
    position: absolute;
    top: 20px;
    left: 90px;
    font-size: 20px;
    opacity: 1000
}

.search-option .inputs {
    opacity: 0;
    transition: all 0.5s ease;
    transition-delay: 0.5s;
    position: relative
}

.search-option .inputs input {
    position: absolute;
    top: 200px;
    left: 30px;
    padding-left: 20px;
    background-color: transparent;
    width: 300px;
    border: none;
    color: #fff;
    border-bottom: 1px solid #eee;
    transition: all 0.5s;
    z-index: 10
}

.search-option .inputs input:focus {
    box-shadow: none;
    outline: none;
    z-index: 10
}

.search-option:hover {
    border-radius: 0px;
    width: 100%;
    left: 0px
}

.search-option:hover .inputs {
    opacity: 1
}

.search-option:hover .first-search {
    left: 27px;
    top: 25px;
    font-size: 15px
}

.search-option:hover .inputs input {
    top: 20px
}

.search-option .share {
    position: absolute;
    right: 20px;
    top: 22px
}

.buttons .btn {
    height: 50px;
    width: 150px;
    border-radius: 0px !important
}

.smallBox{
    width:100px;
}
    </style>
  <div class=" mt-5 mb-5">
    <div class="card">
        <div id="divmsg" runat="server">
        
            </div>
        <div class="row g-0">
            <div class="col-md-6 border-end">
                <div class="d-flex flex-column justify-content-center">
                    <div class="main_image" id="prod_image" runat="server"><%-- <img src="../Storage/ProductImage/S0708202199975nc/MBCO2017.jpg" id="main_product_image" width="400">--%> </div>
                    <%--<div class="thumbnail_images">
                        <ul id="thumbnail">
                            <li><img onclick="changeImage(this)" src="https://i.imgur.com/TAzli1U.jpg" width="70"></li>
                            <li><img onclick="changeImage(this)" src="https://i.imgur.com/w6kEctd.jpg" width="70"></li>
                            <li><img onclick="changeImage(this)" src="https://i.imgur.com/L7hFD8X.jpg" width="70"></li>
                            <li><img onclick="changeImage(this)" src="https://i.imgur.com/6ZufmNS.jpg" width="70"></li>
                        </ul>
                    </div>--%>
                </div>
            </div>
          
            <div class="col-md-6">
                <div class="p-3 right-side">
                    <div class="d-flex justify-content-between align-items-center">
                        <h3 id="prod_name" runat="server"></h3> <span class="heart"><i class='bx bx-heart'></i></span>
                        <h6 id="prod_id" runat="server" class="collapse"></h6>
                    </div>
                    <div class="mt-2 pr-3 content">
                        <h6 class="font-italic font-weight-bold text"><u>Description</u></h6>
                        <p id="description" runat="server"></p>
                    </div>
                    <h3 id="prod_price" runat="server"></h3>
                    <div class="ratings d-flex flex-row align-items-center">
                        <div class="d-flex flex-row"> <i class='bx bxs-star'></i> <i class='bx bxs-star'></i> <i class='bx bxs-star'></i> <i class='bx bxs-star'></i> <i class='bx bx-star'></i> </div> <span>441 reviews</span>
                    </div>

                 
                    <div class="mt-5"> <span class="fw-bold">Stock : <span class="font-weight-bold" id="stock_label" runat="server"></span></span>
                         <div class="mt-5"> <span class="fw-bold">Delivery Fee : <span class="font-weight-bold" id="delivery" runat="server"></span></span>

                       
                    </div>
                        <form runat="server">
                            <div class="mt-5 row">
                                &emsp;<span class="fw-bold">Qty : </span>&emsp;
                        <asp:TextBox ID="prod_qty" runat="server" TextMode="Number" Text="1" CssClass="form-control smallBox" ></asp:TextBox></div>
                    <div class="buttons d-flex flex-row mt-5 gap-3" >
                        <!--button class="btn btn-outline-dark" id="buy" onclick="hide()">Buy Now</!--button--> 
                 <asp:Button Text="Add To WishList" ID="wishlist" OnClick="wishlist_Click" CssClass="btn btn-danger" runat="server" />
                        &emsp;
                  <asp:Button Text="Add To Cart" ID="cart" OnClick="add_Click" CssClass="btn btn-dark" runat="server" />
                    </div>
                   </form>
                    <!--    <button class="btn btn-outline-dark" id="addtocart" onclick="getItem();" >Add TO CART</button>-->
                </div>
            </div>
        </div>
       
    </div>
</div>
           <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

    <script>

        var product_id = document.getElementById("<%=prod_id.ClientID%>").innerHTML;
        $(document).ready(function (){

            /*$('#addtocart').on("click", function () {
               
                $.ajax({
                    type: "POST",
                    url: "AddToCart.aspx/addtocart",
                    data: { product_id: product_id },
                    dataType: 'json',
                    success: function (data) {

                        alert(data.d);
                    }
                   
                });

            })*/
            setTimeout(function () {
                $("#<%=divmsg.ClientID%>").hide("fade");
            }, 2000);

           
            
        })
   
        function hide() {
            
        }
        function changeImage(element) {

            var main_prodcut_image = document.getElementById('main_product_image');
            main_prodcut_image.src = element.src;


         }


            var xmlhttp = new XMLHttpRequest();
     function getItem(){

          xmlhttp.onreadystatechange = function() {
              if (this.readyState == 4 && this.status == 200) {
                  var data = this.responseText;
                  alert(data);
                
               


              }
         };
         xmlhttp.open("POST","AddToCart.aspx/addtocart" ,true);
         xmlhttp.onload = function(){



         }
         xmlhttp.send("product_id=" + product_id);
     }

        

        //ajax 
       
       
        
    </script>

</div>
</asp:Content>
