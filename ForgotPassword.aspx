<%@ Page Title="" Language="C#" MasterPageFile="~/Layout/LoginLayout.Master" AutoEventWireup="true" CodeBehind="ForgotPassword.aspx.cs" Inherits="SupremeArt.ForgotPassword" %>
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
        .error {
            color: red;
            background-image: url("admin/img/error.png");
            background-repeat: no-repeat;
            background-position: left center;
            padding-left: 20px;
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

                <form id="form" runat="server">
                    
                    <div class="login-form-head">
                        <h4>Forgot Password</h4>
                      
                    </div>
                    <div class="login-form-body">
                        <div id="loginmsg" runat="server">

                        </div>
                        <br />
                        <div class="form-gp">
                            <label for="username">Username</label>
                            <asp:TextBox  runat="server" ID="username"></asp:TextBox>
                            <i class="ti-user"></i>
                            <div class="text-danger" id="empty_uname" runat="server"></div>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Name is required" ControlToValidate="username" Display="Dynamic" CssClass="error"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="username"  Display="Dynamic" ErrorMessage="Name should at least 5 characters" ValidationExpression="^[A-Za-z0-9\s@_]{5,}$" CssClass="error"></asp:RegularExpressionValidator>
                        </div>

                         <div class="form-gp">
                            <label for="email">Email</label>
                            <asp:TextBox TextMode="Email" runat="server" ID="email"></asp:TextBox>
                            <i class="ti-email"></i>
                            <div class="text-danger" id="" ></div>
                             <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Email is required" ControlToValidate="email" Display="Dynamic" CssClass="error"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="email"  Display="Dynamic" ErrorMessage="Invalid Email" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" CssClass="error"></asp:RegularExpressionValidator>
                        </div>

                        <div class="form-gp">
                            <label for="phone_number">Phone Number</label>
                            <asp:TextBox  runat="server" ID="phone_number"></asp:TextBox>
                            <i class="ti-mobile"></i>
                            <div class="text-danger" id="" ></div>
                               <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Phone number is required" ControlToValidate="phone_number" Display="Dynamic" CssClass="error"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="phone_number"  Display="Dynamic" ErrorMessage="Invalid Phone No, should be 10-12 numbers" ValidationExpression="^[0-9]{10,12}$" CssClass="error"></asp:RegularExpressionValidator>
                        </div>
                       
                        
                        <div class="row mb-4 rmber-area">
                           <!-- <div class="collapse">
                                <div class="custom-control custom-checkbox mr-sm-2">
                                    <input type="checkbox" class="custom-control-input" id="customControlAutosizing">
                                    <label class="custom-control-label" for="customControlAutosizing">Remember Me</label>
                                </div>
                            </div>-->
                            <div class=" col-12 text-center">
                                <a href="Login.aspx">Remember Password?</a>
                            </div>
                        </div> 
                        <div class="row">
                            <div class="text-center col-12">
                                <asp:Button ID="submit" runat="server" CssClass="btn btn-primary" Text="Submit" />
                            </div>
                        </div>
                        <div class="submit-btn-area">

                        </div>
               
                    </div>
                </form>
            </div>
        </div>
    </div>
</asp:Content>
