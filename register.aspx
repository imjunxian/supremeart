<%@ Page Title="" Language="C#" MasterPageFile="~/Layout/LoginLayout.Master" AutoEventWireup="true" CodeBehind="register.aspx.cs" Inherits="SupremeArt.register" %>
<asp:Content ID="Content1" ContentPlaceHolderID="content" runat="server">
     <div id="preloader">
        <div class="loader"></div>
    </div>
    <!-- preloader area end -->
    <!-- login area start -->
    <div class="login-area">
        
        <div class="container">
            
            <div class="login-box ptb--100">

                <form id="registerForm" runat="server">
                    
                    <div class="login-form-head">
                        <h4>Sign Up</h4>
                      
                    </div>
                    <div class="login-form-body">
             <asp:Literal ID="litResult" runat="server"></asp:Literal>
                        <br />
                        
                        <div class="form-gp">
                            <label for="Name">Name</label>
                            <asp:TextBox  runat="server" ID="name"></asp:TextBox>
                            <i class="ti-user"></i>
                            <div class="text-danger" id="empty_name" runat="server"></div>
                        
                              <asp:RequiredFieldValidator ID="rv_name" runat="server" ErrorMessage="*Name is required" ControlToValidate="name" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="name_validation" runat="server" ErrorMessage="Invalid Format [Only Alphabets Allow]" ControlToValidate="name" Font-Bold="False" Font-Italic="False" ForeColor="Red" ValidationExpression="^(?![\s.]+$)[a-zA-Z\s.]*$" Display="Dynamic"></asp:RegularExpressionValidator>
                        </div>

                          <div class="form-gp">
                            <label for="email">Email</label>
                            <asp:TextBox TextMode="Email" runat="server" ID="email"></asp:TextBox>
                            <i class="ti-email"></i>
                            <div class="text-danger" id="" ></div>
                               <asp:RequiredFieldValidator ID="rv_email" runat="server" ErrorMessage="*Email is required" ControlToValidate="email" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                             
                              <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="email"  Display="Dynamic" ErrorMessage="Invalid Email" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" CssClass="error" ForeColor="Red"></asp:RegularExpressionValidator>
                        </div>


                         <div class="form-gp">
                            <label for="uname">Username</label>
                            <asp:TextBox  runat="server" ID="username"></asp:TextBox>
                            <i class="ti-user"></i>
                            <div class="text-danger" id="empty_username" runat="server"></div>
                               <asp:RequiredFieldValidator ID="rv_username" runat="server" ErrorMessage="*Username is required" ControlToValidate="username" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                             <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Invalid Format [Only Alphabets Allow]" ControlToValidate="username" Font-Bold="False" Font-Italic="False" ForeColor="Red" ValidationExpression="^(?![\s.]+$)[a-zA-Z\s.]*$" Display="Dynamic"></asp:RegularExpressionValidator>

                        </div>




                        <div class="form-gp">
                            <label for="password">Password</label>
                             <asp:TextBox ID="password" TextMode="Password" runat="server"></asp:TextBox>

                            <i class="ti-lock"></i>
                            <div class="text-danger" id="empty_pass" runat="server"></div>
                            <asp:RequiredFieldValidator ID="rv_password" runat="server" ErrorMessage="*Password is required" ControlToValidate="password" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                     
                            <asp:RegularExpressionValidator ID="password_validation" runat="server" Display="Dynamic" ErrorMessage="Password should be at least 8 characters include 1 uppercase, 1 lowercase and 1 number (No special characters)" ValidationExpression="^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$" ControlToValidate="password" Font-Bold="False" Font-Italic="False" ForeColor="Red"></asp:RegularExpressionValidator>

                        </div> 

                        <div class="form-gp">
                            <label for="con_pass">Confirm Password</label>
                             <asp:TextBox ID="confirm_password" TextMode="Password" runat="server"></asp:TextBox>

                            <i class="ti-lock"></i>
                            <div class="text-danger" id="empty_conpass" runat="server"></div>
                             <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="*Confirm Password is required" ControlToValidate="confirm_password" Display="Dynamic" CssClass="error" ForeColor="Red"></asp:RequiredFieldValidator>
                     
                          
                       <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToCompare="password" ControlToValidate="confirm_password" ErrorMessage="Confirm Password must be same with Password" CssClass="error" Display="Dynamic" ForeColor="Red"></asp:CompareValidator>
                        </div>

                         <div class="form-gp">
                            <label for="phone_number">Phone Number</label>
                            <asp:TextBox  runat="server" ID="phone_number"></asp:TextBox>
                            <i class="ti-mobile"></i>
                            <div class="text-danger" id="" ></div>
                             <asp:RequiredFieldValidator ID="rv_phoneno" runat="server" ErrorMessage="*Phone Number is required" ControlToValidate="phone_number" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>  
                            <asp:RegularExpressionValidator ID="phoneNo_validation" runat="server" ControlToValidate="phone_number" ErrorMessage="Invalid Format [Format must start with (601)or(01) and not longer than 11 digits and NO Alphabets]" Font-Bold="False" Font-Italic="False" ForeColor="Red" ValidationExpression="^6?01\d{8}$"></asp:RegularExpressionValidator>

                        </div>

                        <div class="row">
                            <label for="role">Register as :</label>
                            <br />

                            <asp:DropDownList ID="role" runat="server" onchange="change() " CssClass="form-control">
                                 <asp:ListItem Selected="True" Value="Please Select">Please Select</asp:ListItem>
                                 <asp:ListItem Value="B">Buyer</asp:ListItem>
                                 <asp:ListItem Value="S">Seller</asp:ListItem>

                             </asp:DropDownList>
                            <div class="text-danger" id="empty_role" ></div>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" InitialValue="Please Select" ErrorMessage="*Role is required" Display="Dynamic" ForeColor="Red" ControlToValidate="role"></asp:RequiredFieldValidator>
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
 
                                <!--<asp:Button ID="registerBtn" CssClass="btn btn-primary" runat="server" Text="Register" CausesValidation="true" OnClientClick="checkRole()"/>-->
                                <button type="button" id="registerbtn" class="btn btn-primary" onclick="checkRole()" >Register</button>

                            </div>
                        </div>
                        <div class="submit-btn-area">

                        
                           
                            <br />
                            <br />
                            <div class="text-center">
                                  
                            </div>
                        </div>
                        <div class="form-footer text-center mt-5">
                            <a href="Login.aspx">Already have an account ? Click here to Sign In</a>
                        </div>
                        <!--label of role-->
                        

                        
                    </div>
                    <!--modal-->
                    <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                          <div class="modal-dialog">
                            <div class="modal-content">
                              <div class="modal-header">
                                <h5 class="modal-title" id="exampleModalLabel">Confirmation</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                  <span aria-hidden="true">&times;</span>
                                </button>
                              </div>
                              <div class="modal-body">
                                  
                                     <p>Confirm register as [ <span id="roleResult"></span> ] ?</p> <p class="text-danger">Caution: Changes cannot be made after register successful.</p> 
                                  
                              </div>
                              <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                   <asp:Button ID="register_button" runat="server" CssClass="btn btn-success" Text="Confirm" OnClick="register_Click" />
                              </div>
                            </div>
                          </div>
                    </div>
                    <!--end modal-->
                </form>
            </div>
        </div>
    </div>
    <script>
    


        var show = 0;

        var setRoles = "";
        function change() {
            show = 0;
                var thisrole = document.getElementById("<%=role.ClientID%>");
                var roleValue = thisrole.options[thisrole.selectedIndex].value;
                
                
               
               switch (roleValue) {
                    case "B":
                        setRoles = "Buyer";
                        show = 1;
                        break;
                    case "S":
                        setRoles = "Seller";
                        show = 1;
                        break;
                    case "":
                        setRoles = "No";
                        show = 0;
                        break;
                }

        } 

        function checkRole() {
            if (show < 1) {
                $('#exampleModal').modal("hide");
                $('#empty_role').html("Please select the role of register ! ");
            }
            else {
                $('#empty_role').html("");
                $('#roleResult').html(setRoles);
                $('#exampleModal').modal("show");


            }
        }

        if (window.history.replaceState) {
            window.history.replaceState(null, null, window.location.href);
        }

       
    </script>
</asp:Content>
