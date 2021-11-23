<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="payment.aspx.cs" Inherits="SupremeArt.payment" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Payment Gateway</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

</head>

   
<body>
   
    <form id="form1">
        <div>
            <button type="submit">CheckOut</button>
        </div>
    </form>
</body>
    <script src="https://js.stripe.com/v3/"></script>
<script>
    var stripe = Stripe('pk_test_TYooMQauvdEDq54NiTphI7jx');
   // var form = document.getElementById("form1");
    /*form.addEventListener('submit', function (e) {
        e.preventDefault();
        stripe.redirectToCheckout({
           
        })


    })*/

    $(document).ready(function () {
        stripe.redirectToCheckout({
            sessionId: "<%= sessionId %>",
        })

     

      

    });

  
</script>
</html>
