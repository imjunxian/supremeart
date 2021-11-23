<%@ Page Title="" Language="C#" MasterPageFile="~/Layout/default.Master" AutoEventWireup="true" CodeBehind="Issues.aspx.cs" Inherits="SupremeArt.Buyer.Issues" %>
<asp:Content ID="Content1" ContentPlaceHolderID="content" runat="server">
     <br />
    <br />
     <style>
  
        .paragraph{
            height:500px;
        }
    </style>
    <form runat="server" id="issue_orm">
    <div class="container">
        <asp:Label ID="litResult" runat="server"  Font-Bold="true" Display="Dynamic"></asp:Label>
        <h3><b>Reporting Issue</b></h3>
        <div class="card">
            <div class="card-body">
               
                    <div class="row">
                        <table class="table table-bordered">
                          
                             
                     <tr>
                         <th>Issues</th>
                         <td>
                 
                             <asp:TextBox ID="issue" TextMode="MultiLine"  runat="server" CssClass="form-control paragraph" ></asp:TextBox>
                              <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="This field is required" ControlToValidate="issue" Display="Dynamic"  ForeColor="Red"></asp:RequiredFieldValidator>
                             
                         </td>
                     </tr>

                                 
                        </table>
                     
                    </div>
                        <div class="text-center">
                            
                            <asp:Button ID="btnInsert" class="btn btn-success" runat="server" Text="Send" OnClick="btnInsert_Click"/>
                        </div>

                <br />
                  
            </div>
        </div>

        <br />
        <br />
      
        

    
        </div>
   </form>
    <script>
        if (window.history.replaceState) {
            window.history.replaceState(null, null, window.location.href);
        }
    </script>
</asp:Content>
