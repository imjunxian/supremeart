<%@ Page Language="C#"  MasterPageFile="~/Layout/default.Master" AutoEventWireup="true" CodeBehind="UpdatePassword.aspx.cs" Inherits="SupremeArt.Buyer.UpdatePassword" %>
<asp:Content ID="Content1" ContentPlaceHolderID="content" runat="server">
<br />
    <br />
    <form runat="server" id="profile_form">
    <div class="container">
        <h3><b>Update Password</b></h3>
        <div class="card">
            <div class="card-body">

                 <asp:Label ID="lblPass" runat="server"  Font-Bold="true" Display="Dynamic"></asp:Label>
                
                    <div class="row">
                       
                        <table class="table table-bordered">
                             
                            <tbody>
                              
                                
                                  <tr>
                                    <th>Current Password</th>
                                    <td>
                                         <asp:TextBox ID="txtCrrPass" runat="server" type="text" CssClass="form-control" placeholder="Enter Current Password" name="cpass"  TextMode="Password"></asp:TextBox>
                                         <asp:RequiredFieldValidator ID="RequiredFieldValidator" runat="server" ErrorMessage="*Current Password is Required"  ControlToValidate="txtCrrPass" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                         <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" Display="Dynamic" ErrorMessage="Password should be at least 8 characters include 1 uppercase, 1 lowercase and 1 number" ValidationExpression="^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$" ControlToValidate="txtCrrPass" Font-Bold="False" Font-Italic="False" ForeColor="Red" ></asp:RegularExpressionValidator>

                                    </td>
                                </tr>

                                

                                 <tr>
                                    <th>New Password</th>
                                    <td>
                                      <asp:TextBox ID="txtNewPass" runat="server" type="text" CssClass="form-control" placeholder="Enter New Password" name="npass" TextMode="Password"></asp:TextBox>
                                      <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="New Password is Required" ControlToValidate="txtNewPass" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                         <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" Display="Dynamic" ErrorMessage="Password should be at least 8 characters include 1 uppercase, 1 lowercase and 1 number" ValidationExpression="^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$" ControlToValidate="txtNewPass" Font-Bold="False" Font-Italic="False" ForeColor="Red" ></asp:RegularExpressionValidator>
                                    </td>
                                </tr>

                                 <tr>
                                    <th>Confirm Password</th>
                                    <td>
                                        <asp:TextBox ID="txtConfPass" runat="server" type="text" CssClass="form-control" placeholder="Confirm New Password" name="confirmpass" TextMode="Password"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="*Confirm Password is Required" ControlToValidate="txtConfPass" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                     
                                         <asp:CompareValidator ID="CompareValidator" runat="server" ErrorMessage="Confirm Password must be matched to the New Password" ControlToCompare="txtNewPass" ControlToValidate="txtConfPass" Display="Dynamic" ForeColor="Red"></asp:CompareValidator>
                                         
                                    </td>
                                </tr>

                                
                                

                            </tbody>
                        </table>
                     
                    </div>
                        <div class="text-center">
                            
                            <asp:Button ID="btnUpdate" class="btn btn-success" runat="server" Text="Update Password" OnClick="btnUpdate_Click" />
                        </div>

                <br />
                  
            </div>
        </div>

        <br />
        <br />
    </div>
   </form>
</asp:Content>