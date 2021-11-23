<%@ Page Title="" Language="C#" MasterPageFile="~/Layout/LoginLayout.Master" AutoEventWireup="true" CodeBehind="paymentFail.aspx.cs" Inherits="SupremeArt.paymentFail" %>
<asp:Content ID="Content1" ContentPlaceHolderID="content" runat="server">
     <style>
        .done-image{
            width:100px;
            height:100px;
        }
         .col-example {
      padding: 1rem;
      background-color: #33b5e5;
      border: 2px solid #fff;
      color: #fff;
      text-align: center;
    }
    </style>
     <div class="container my-4">


   

    <div class="border border-light p-3 mb-4">
        <div class="d-flex align-items-center justify-content-left" style="height: 350px">
        </div>
        
      <div class="d-flex align-items-center justify-content-center" style="height: 350px">
          <div class="row">
              
                     <img src="assets/img/fail.png" class="done-image"/> &emsp; <h5>Payment Fail</h5>&emsp; <p>Page will be redirect to merchant site after <span id="sec"></span> second(s) </p>
              <br />
          

           </div>
          <div class="row">

                  
          </div>

              
       
      </div>

    </div>

  </div>

     <script>
    var sec = 5;
    function counting() {
       
        if (sec <= 5 && sec!=0) {
            document.getElementById("sec").innerHTML = sec;
        }
       
        if (sec == 0) {
            window.location.href = "Buyer/Cart.aspx";
        }
        sec -= 1;
    }
   
        setInterval(counting, 1000);
    
   
     </script>

</asp:Content>
