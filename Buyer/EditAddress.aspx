<%@ Page Title="" Language="C#" MasterPageFile="~/Layout/default.Master" AutoEventWireup="true" CodeBehind="EditAddress.aspx.cs" Inherits="SupremeArt.Buyer.EditAddress" %>
<asp:Content ID="Content1" ContentPlaceHolderID="content" runat="server">
    <br />
    <br />
    <form runat="server" id="edit_form">
    <div class="container">
        <asp:Label ID="EditResult" runat="server"  Font-Bold="true" Display="Dynamic"></asp:Label>
        <h3><b>Edit Address</b></h3>
        <div class="card">
            <div class="card-body">
               <asp:Literal ID="litResult" runat="server"></asp:Literal>
                    <div class="row">
                        <table class="table table-bordered">
                            <tbody>
                                 
                                <tr>
                                    <th>Address</th>
                                    <td>
                                         <asp:TextBox ID="txtAddress" runat="server" type="text" CssClass="form-control" name="state"></asp:TextBox>
                                         <asp:RequiredFieldValidator ID="RequiredFieldValidator" runat="server" ErrorMessage="Please Enter [Address]" ForeColor="Red" Display="Dynamic" ControlToValidate="txtAddress"></asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Invalid address" ControlToValidate="txtAddress" Display="Dynamic"  ForeColor="Red" ValidationExpression="^[a-zA-Z0-9\s,'-]*$"></asp:RegularExpressionValidator>
                                    </td>
                                </tr>

                                

                                 <tr>
                                    <th>Postal Code</th>
                                    <td>
                                        <asp:TextBox ID="txtPostal" runat="server" CssClass="form-control"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Please Enter [Postal Code]" ForeColor="Red" Display="Dynamic" ControlToValidate="txtPostal"></asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="txtPostal" ForeColor="Red" Display="Dynamic" ErrorMessage="Please Enter [5 Numeric] only" ValidationExpression="^[0-9]{5}$"></asp:RegularExpressionValidator>
                                    </td>
                                </tr>

                                 <tr>
                                    <th>City</th>
                                    <td>
                                        <asp:TextBox ID="txtCity" runat="server" type="text" CssClass="form-control"  name="city"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Please Enter [City]" ForeColor="Red" Display="Dynamic" ControlToValidate="txtcity"></asp:RequiredFieldValidator>
                                      <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="txtCity" ForeColor="Red" Display="Dynamic" ErrorMessage="Please Enter [Alphabet] only" ValidationExpression="^[a-zA-Z ]*$"></asp:RegularExpressionValidator>
                                    </td>
                                </tr>

                                 <tr>
                                    <th>State , Area</th>
                                    <td>
                                         <asp:DropDownList ID="ddstate" CssClass="form-control" runat="server" AutoPostBack ="false">
                                        <asp:ListItem Text ="Johor" Value ="Johor"></asp:ListItem>
                                        <asp:ListItem Text ="Kedah" Value ="Kedah"></asp:ListItem>
                                        <asp:ListItem Text ="Kelantan" Value ="Kelantan"></asp:ListItem>
                                        <asp:ListItem Text ="Malacca" Value ="Malacca"></asp:ListItem>
                                        <asp:ListItem Text ="Negeri Sembilan" Value ="Negeri Sembilan"></asp:ListItem>
                                        <asp:ListItem Text ="Pahang" Value ="Pahang"></asp:ListItem>
                                        <asp:ListItem Text ="Penang" Value ="Penang"></asp:ListItem>
                                        <asp:ListItem Text ="Perak" Value ="Perak"></asp:ListItem>
                                        <asp:ListItem Text ="Perlis" Value ="Perlis"></asp:ListItem>
                                        <asp:ListItem Text ="Sabah" Value ="Sabah"></asp:ListItem>
                                        <asp:ListItem Text ="Sarawak" Value ="Sarawak"></asp:ListItem>
                                        <asp:ListItem Text ="Selangor" Value ="Selangor"></asp:ListItem>
                                        <asp:ListItem Text ="Terangganu" Value ="Terangganu"></asp:ListItem>
                                        <asp:ListItem Text ="Kuala Lumpur" Value ="Kuala Lumpur"></asp:ListItem>
                                        <asp:ListItem Text ="Labuan" Value ="Labuan"></asp:ListItem>
                                        <asp:ListItem Text ="Putrajaya" Value ="Putrajaya"></asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="Please Enter [State , Area]" ForeColor="Red" Display="Dynamic" ControlToValidate="ddstate"></asp:RequiredFieldValidator>
                     
                                    </td>
                                </tr>
                               

                                <tr>
                                    <th>Label As</th>
                                    <td>
                                          <asp:DropDownList ID="ddtype" CssClass="form-control" runat="server" AutoPostBack ="false">
                                            <asp:ListItem Text ="Home" Value ="Home"></asp:ListItem>
                                            <asp:ListItem Text ="Office" Value ="Office"></asp:ListItem> 
                                        </asp:DropDownList>
                                         <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="Please Enter [Address Type]" ForeColor="Red" Display="Dynamic" ControlToValidate="ddtype"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>


                            </tbody>
                        </table>
                     
                    </div>
                        <div class="text-center">
                            <asp:Button ID="btnChange" class="btn btn-success" runat="server" Text="Edit Address" OnClick="btnChange_Click"/>
                        </div>

                <br />
                  
            </div>
        </div>

        <br />
        <br />

    
        </div>
   </form>
      
</asp:Content>
