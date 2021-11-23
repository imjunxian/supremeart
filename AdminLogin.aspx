<%@ Page Title="" Language="C#" MasterPageFile="~/Layout/LoginLayout.Master" AutoEventWireup="true" CodeBehind="AdminLogin.aspx.cs" Inherits="SupremeArt.AdminLogin" %>
<asp:Content ID="Content1" ContentPlaceHolderID="content" runat="server">
    <style>
     
        </style>
     <div id="preloader">
        <div class="loader"></div>
    </div>
    <!-- preloader area end -->
    <!-- login area start -->
    <div class="login-area">
        
        <div class="container">
            
            <div class="login-box ptb--100">
                <form id="adminForm" runat="server">
                    
                    <div class="login-form-head" style="background-color:black;">
                        <h4>Supreme Art (ADMIN Site)</h4>
                       
                    </div>
                    <div class="login-form-body">
                       <asp:Literal ID="loginmsg" runat="server"></asp:Literal>
                        <br />
                        <div class="form-gp">
                            <label for="exampleInputEmail1">Username</label>
                            <asp:TextBox  runat="server" ID="username"></asp:TextBox>  
                            <i class="ti-user"></i>
                            <div class="text-danger"></div>
                           <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*Username is Required"  ForeColor="Red" ControlToValidate="username" Display="Dynamic" CssClass="error"></asp:RequiredFieldValidator>
                      
                        </div>
                        <div class="form-gp">
                            <label for="exampleInputPassword1">Password</label>
                             <asp:TextBox ID="password" TextMode="Password" runat="server"></asp:TextBox>
                            <i class="ti-lock"></i>
                            <div class="text-danger"></div>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="*Password is Required" ForeColor="Red"  ControlToValidate="password" Display="Dynamic" CssClass="error"></asp:RequiredFieldValidator>
                           
                        </div>
                        <div class="row mb-4 rmber-area">
                           <!-- <div class="collapse">
                                <div class="custom-control custom-checkbox mr-sm-2">
                                    <input type="checkbox" class="custom-control-input" id="customControlAutosizing">
                                    <label class="custom-control-label" for="customControlAutosizing">Remember Me</label>
                                </div>
                            </div>-->
               
                        </div> 
                        <div class="row">
                            <div class="text-center col-12">
                                <asp:Button ID="login" runat="server" CssClass="btn btn-primary" Text="Login" OnClick="login_Click" />
                            </div>
                        </div>
                        <div class="submit-btn-area">

                           
                           
                            <br />
                            <br />
                            <div class="text-center">
                                  <a href="Login.aspx">Login as Buyer/Seller</a>
                            </div>
                        </div>
                      
                    </div>
                </form>
            </div>
        </div>
    </div>

</asp:Content>

