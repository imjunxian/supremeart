<%@ Page Title="" Language="C#" MasterPageFile="~/Layout/default.Master" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="SupremeArt.Buyer.Profile" %>
<asp:Content ID="Content1" ContentPlaceHolderID="content" runat="server">
    <br />
    <br />
    <form runat="server" id="profile_form">
    <div class="container">
        <asp:Label ID="passResult" runat="server"  Font-Bold="true" Display="Dynamic"></asp:Label>
        <h3><b>My Profile</b></h3>
        <div class="card">
            <div class="card-body">
               
                    <div class="row">
                        <table class="table table-bordered">
                            <tbody>
                                 
                                <tr>
                                    <th>User ID</th>
                                    <td>
                                        <span runat="server" id="userid"></span>
                                    </td>
                                </tr>

                                 <tr>
                                    <th>Account Type</th>
                                    <td>
                                        <span class="bold">Buyer</span>
                                    </td>
                                </tr>
                                 <tr>
                                    <th>Membership</th>
                                    <td>
                                        <asp:Literal ID="litMembership" runat="server"></asp:Literal>
                                    </td>
                                </tr>

                                 <tr>
                                    <th>Name</th>
                                    <td>
                                        <asp:TextBox ID="name" runat="server" CssClass="form-control"></asp:TextBox>
                                         <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*Name is required" ControlToValidate="name" Display="Dynamic"  ForeColor="Red"></asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="name_validation" runat="server" ErrorMessage="Invalid Format [Only Alphabets Allow]" ControlToValidate="name" Font-Bold="False" Font-Italic="False" ForeColor="Red" ValidationExpression="^(?![\s.]+$)[a-zA-Z\s.]*$" Display="Dynamic"></asp:RegularExpressionValidator>
                                    </td>
                                </tr>

                                <tr>
                                    <th>Username</th>
                                    <td> 
                                         <asp:Literal ID="username" runat="server"></asp:Literal>
                                    </td>
                                </tr>


                                <tr>
                                    <th>Email</th>
                                    <td>
                                        <asp:TextBox ID="email" runat="server" CssClass="form-control"></asp:TextBox>
                                          <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="*Email is required" ControlToValidate="email" Display="Dynamic"  ForeColor="Red"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="email"  Display="Dynamic" ErrorMessage="Invalid Email" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" CssClass="error" ForeColor="Red"></asp:RegularExpressionValidator>
                                    </td>
                                </tr>

                                 <tr>
                                    <th>Contact</th>
                                    <td>
                                        <asp:TextBox ID="contact" runat="server" CssClass="form-control"></asp:TextBox>
                                         <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="*Contact is required" ControlToValidate="contact" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                          <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="contact"  Display="Dynamic" ErrorMessage="Invalid Format [Format must start with (601)or(01) and not longer than 11 digits and NO Alphabets]" ValidationExpression="^6?01\d{8}$" CssClass="error" ForeColor="Red"></asp:RegularExpressionValidator>
                                    </td>
                                </tr>

                                <tr>
                                    <th>Password</th>
                                    
                                    <td>
                                        <a class="btn btn-primary" href="UpdatePassword.aspx">change</a>
                                      <!--  <button class="btn btn-primary" data-toggle="modal" data-target="#password">Change</button> -->
                                    </td>
                                </tr>
 

                            </tbody>
                        </table>
                     
                    </div>
                        <div class="text-center">
                            
                            <asp:Button ID="btnInsert" class="btn btn-success" runat="server" Text="Save Changes" OnClick="btnInsert_Click"  />
                        </div>

                <br />
                  
            </div>
        </div>

        <br />
        <br />
      
       
        <div id="noaddress" runat="server"></div>
        <h3><b>My Addresses</b></h3>
        
        <!--address card-->
        <div class="card">
            <div class="card-body">

                <!--
                    ***DONT remove this comment until you are finish ***

                 1.Display all address here with edit and dlt button beside  (refer shopee/lazada) can display using DataBound if can
                 2.Add address -> With Modal that can let user add address (modal can refer register.aspx) OR you want open another page call address.aspx also can. 
                 3. For state. use selection instead of let user enter by themselves
                 4. Post Code only allowed numbers. make use of regex 
                 5. Type can use checkboxes or radio button like (house, office ...)

                    -->

                  <!--Submit button-->
                   <div id="addAddress" runat="server"></div>
                           
                
                <br/>
             
                 <div id="shwaddress" runat="server"></div>
                
            </div>
        </div>
    
        </div>
   </form>
    <script>
        if (window.history.replaceState) {
            window.history.replaceState(null, null, window.location.href);
        }
    </script>
</asp:Content>
