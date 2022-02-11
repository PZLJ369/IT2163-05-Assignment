<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="IT2163_Assignment.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login Page</title>
   
    <link rel="stylesheet" href="~/Styling/login.css" />
    <script src="https://www.google.com/recaptcha/api.js?render=6Lfsck4eAAAAACfkDR0CksyTJSBjS_Es_sTp3ajD"></script>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous" />
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
    <script type = "text/javascript" >
        function preventBack() { window.history.forward(); }
        setTimeout("preventBack()", 0);
        window.onunload = function () { null };
    </script>
</head>

<body>

       <header style="background-color:white;">
        <nav class="navbar navbar-expand-lg navbar-light shadow-sm">
            <div class="container">
                <a class="navbar-brand" href="Home.aspx"><span class="text-primary">Stationary</span>-Store</a>

                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupport" aria-controls="navbarSupport" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>

                <div class="collapse navbar-collapse" id="navbarSupport">
                    <ul class="navbar-nav ml-auto">
                        <li class="nav-item active">
                            <a class="nav-link" href="Home.aspx">Home</a>
                        </li>

                        <li class="nav-item">
                            <a class="btn btn-outline-success" href="Registration.aspx">Register</a>
                        </li>
                        <li class="nav-item ml-2">
                            <a class="btn btn-primary" href="Login.aspx">Login</a>
                        </li>
                    </ul>
                </div> 
            </div> 
        </nav>
    </header>

    <br />
    <div class="loginbody">
    <div class="container-fluid ps-md-0">
        <div class="row g-0">
            <div class="d-none d-md-flex col-md-4 col-lg-6 bg-image"></div>
            <div class="col-md-8 col-lg-6">
                <div class="login d-flex align-items-center py-5">
                    <div class="container">
                        <div class="row">
                            <div class="col-md-9 col-lg-8 mx-auto">
                                <h3 class="login-heading mb-4">Log in</h3>

                                <!-- Sign In Form -->
                                <form id="Login" runat="server">
                                    <div class="form-floating mb-3">
                                        <label>Email</label>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ErrorMessage="required*" ControlToValidate="tb_email" ForeColor="Red" style="font-size:smaller;" ></asp:RequiredFieldValidator>
                                        <asp:TextBox ID="tb_email" runat="server" class="form-control" placeholder="Enter email">lilywong2@gmail.com</asp:TextBox>
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="tb_email" ErrorMessage="Please enter valid email" ForeColor="Red" style="font-size:smaller;" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                                    </div>
                                    <div class="form-floating mb-1">
                                        <label>Password</label>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="required*" ControlToValidate="tb_password" ForeColor="Red" style="font-size:smaller;"></asp:RequiredFieldValidator>
                                        <asp:TextBox ID="tb_password" runat="server" TextMode="Password" class="form-control" placeholder="Enter password"></asp:TextBox>
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator5" runat="server" ControlToValidate="tb_password" ErrorMessage="12 characters with upper, lowercase, number and symbol" ForeColor="Red" style="font-size:smaller;" ValidationExpression="^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{12,}$"></asp:RegularExpressionValidator>
                                    </div>
                                    <div class="text-center">
                                        <asp:Label ID="lblMessage" runat="server"></asp:Label>
                                        <asp:Label ID="lbl_gScore" runat="server"></asp:Label>
                                    </div>
                                    <br />
                                    <div class="d-grid">
                                        <asp:Button ID="btn_login" runat="server" OnClick="btn_login_Click" Text="Log in" class="btn btn-primary btn-login btn-block text-uppercase fw-bold mb-2"/>
                                        <div class="text-center">
                                            <a class="small" id="forgot-password" asp-page="./ForgotPassword">Forgot password?</a>
                                        </div>
                                        <div class="text-center">
                                            <a href="Registration.aspx">Register as a new user</a>
                                        </div>

                                    </div>

                                    <input type="hidden" id="g-recaptcha-response" name="g-recaptcha-response"/>

                                </form>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

    <script>
        grecaptcha.ready(function () {
            grecaptcha.execute(' 6Lfsck4eAAAAACfkDR0CksyTJSBjS_Es_sTp3ajD ', { action: 'Login' }).then(function (token) {
                document.getElementById("g-recaptcha-response").value = token;
            });
        });
    </script>
    <br />


    <footer class="border-top footer text-muted">
        <div class="container">
            &copy; IT2163ASAssignment - By 202016N
        </div>
    </footer>
</body>
</html>
