<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="success.aspx.cs" Inherits="SupremeArt.success" %>

<!DOCTYPE html>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <h1>
        Payment Success

    </h1>
    <p>Page will be redirect to merchant site after <span id="sec"></span> second(s) </p>
</body>
<script>
    var sec = 5;
    function counting() {
       
        if (sec <= 5 && sec!=0) {
            document.getElementById("sec").innerHTML = sec;
        }
       
        if (sec == 0) {
            //window.location.href = "Buyer/OrderHistory.aspx";
        }
        sec -= 1;
    }
   
        setInterval(counting, 1000);
    
   
</script>
</html>
