<%@ Page Title="" Language="C#" MasterPageFile="~/Layout/LoginLayout.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="SupremeArt.Login" %>
<asp:Content ID="Content1" ContentPlaceHolderID="content" runat="server">
    <style>
        .login-area{
               background-image: url('admin/assets/images/timon-klauser.jpg');
                height: 100%;
                /* Center and scale the image nicely */
                background-position: center;
                background-repeat: no-repeat;
                background-size: cover;
        }

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
                    
                    <div class="login-form-head">
                        <h4>Sign In</h4>
                      
                    </div>
                    <div class="login-form-body">
                        <div id="loginmsg" runat="server">

                        </div>
                        <br />
                        <div class="form-gp">
                            <label for="exampleInputEmail1">Username</label>
                            <asp:TextBox  runat="server" ID="username"></asp:TextBox>
                            <i class="ti-user"></i>
                            <div class="text-danger" id="empty_uname" runat="server"></div>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*Username is Required"  ForeColor="Red" ControlToValidate="username" Display="Dynamic" CssClass="error"></asp:RequiredFieldValidator>
                          
                        </div>
                        <div class="form-gp">
                            <label for="exampleInputPassword1">Password</label>
                             <asp:TextBox ID="password" TextMode="Password" runat="server"></asp:TextBox>

                            <i class="ti-lock"></i>
                            <div class="text-danger" id="empty_pass" runat="server"></div>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="*Password is Required" ForeColor="Red"  ControlToValidate="password" Display="Dynamic" CssClass="error"></asp:RequiredFieldValidator>
                           
                        </div>
                        
                        <div class="row mb-4 rmber-area">
                           <!-- <div class="collapse">
                                <div class="custom-control custom-checkbox mr-sm-2">
                                    <input type="checkbox" class="custom-control-input" id="customControlAutosizing">
                                    <label class="custom-control-label" for="customControlAutosizing">Remember Me</label>
                                </div>
                            </div>-->
                            <div class=" col-12 text-center">
                                <a href="ForgotPassword.aspx">Forgot Password?</a>
                            </div>
                        </div> 
                        <div class="row">
                            <div class="col-12 text-center">
                                <asp:Button ID="login" runat="server" CssClass="btn btn-primary" Text="Login" OnClick="login_Click"  />
                            </div>
                        </div>
                        <div class="submit-btn-area">

                           
                           
                            <br />
                            <br />
                            <div class="text-center">
                                  <a href="AdminLogin.aspx">Login as Admin</a>
                            </div>
                        </div>
                        <div class="form-footer text-center mt-5">
                            <p class="text-muted">Don't have an account? <a href="register.aspx">Sign up</a></p>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</asp:Content>

