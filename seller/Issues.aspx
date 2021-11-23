<%@ Page Title="" Language="C#" MasterPageFile="~/Layout/SellerSite.Master" AutoEventWireup="true" CodeBehind="Issues.aspx.cs" Inherits="SupremeArt.seller.Issues" %>
<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
    Reporting Issues
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="server">
     <style>
  
        .paragraph{
            height:200px;
        }
    </style>
    <link href="../admin/assets/css/imageDisplay.css" rel="stylesheet" />
    <div class="card">
        <div class="card-body">
            <div class="container-fluid">
                <asp:Literal ID="litResult" runat="server"></asp:Literal>
                 <form id="issueForm" runat="server">
             
                     <table class="table" width="50%">
                 
     
 
                     <tr>
                         <th>Issues</th>
                         <td>
                 
                             <asp:TextBox ID="issue" TextMode="MultiLine"  runat="server" CssClass="form-control paragraph"></asp:TextBox>
                              <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="This field is required" ControlToValidate="issue" Display="Dynamic"  ForeColor="Red"></asp:RequiredFieldValidator>
                             
                         </td>
                     </tr>

                    
             
             
                 </table>
                     <div align="center"> 
                         <asp:Button ID="submit" runat="server" Text="Send" CssClass="btn btn-primary" OnClick="submit_Click"/>
                     </div>
            
         </form>
            </div>
        </div>
    </div>

    <script>
        if (window.history.replaceState) {
            window.history.replaceState(null, null, window.location.href);
        }
    </script>

</asp:Content>
