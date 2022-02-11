<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Registration.aspx.cs" Inherits="IT2163_Assignment.Registration" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Registration</title>
    <style type="text/css">
        .auto-style1 {
            width: 203px;
        }
        .auto-style2 {
            width: 344px;
        }
    </style>
    <link rel="stylesheet" href="~/Styling/registration.css" />
    <link rel="stylesheet" href="~/Styling/login.css" />

        <script type="text/javascript">

            function validate() {
                var str = document.getElementById('<%=tb_password.ClientID %>').value;

                if (str.length < 12) {
                    document.getElementById("lbl_pwdchecker").innerHTML = "Password Length Must be at Least 12 Characters";
                    document.getElementById("lbl_pwdchecker").style.color = "Red";
                }

                else if (str.search(/[0-9]/) == -1) {
                    document.getElementById("lbl_pwdchecker").innerHTML = "Password required at least 1 number";
                    document.getElementById("lbl_pwdchecker").style.color = "Red";
                }

                else if (str.search(/[a-z]/) == -1) {
                    document.getElementById("lbl_pwdchecker").innerHTML = "Password required at least 1 lower case";
                    document.getElementById("lbl_pwdchecker").style.color = "Red";
                }

                else if (str.search(/[A-Z]/) == -1) {
                    document.getElementById("lbl_pwdchecker").innerHTML = "Password required at least 1 upper case";
                    document.getElementById("lbl_pwdchecker").style.color = "Red";
                }

                else if (str.search(/[^A-Za-z0-9]/) == -1) {
                    document.getElementById("lbl_pwdchecker").innerHTML = "Password required at least 1 special character";
                    document.getElementById("lbl_pwdchecker").style.color = "Red";
                }

                document.getElementById("lbl_pwdchecker").innerHTML = "Excellent!"
                document.getElementById("lbl_pwdchecker").style.color = "Blue";
            }

            function readURL(input) {
                if (input.files && input.files[0]) {

                    var reader = new FileReader();

                    reader.onload = function (e) {
                        $('.image-upload-wrap').hide();

                        $('.file-upload-image').attr('src', e.target.result);
                        $('.file-upload-content').show();

                        $('.image-title').html(input.files[0].name);
                    };

                    reader.readAsDataURL(input.files[0]);

                } else {
                    removeUpload();
                }
            }

            function removeUpload() {
                $('.file-upload-input').replaceWith($('.file-upload-input').val('').clone(true));
                $('.file-upload-content').hide();
                $('.image-upload-wrap').show();
            }
            $('.image-upload-wrap').bind('dragover', function () {
                $('.image-upload-wrap').addClass('image-dropping');
            });
            $('.image-upload-wrap').bind('dragleave', function () {
                $('.image-upload-wrap').removeClass('image-dropping');
            });
        </script>
    <script src="https://www.google.com/recaptcha/api.js?render=6Lfsck4eAAAAACfkDR0CksyTJSBjS_Es_sTp3ajD"></script>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous" />
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>

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
                                <h3 class="login-heading mb-4">Registration</h3>

                                <!-- Register Form -->
                                <form id="form1" runat="server">
                                    <asp:Label ID="lbl_pwdchecker" runat="server" style="font-size:smaller;"></asp:Label>
                                    <div class="row mb-1">
                                        <div class="form-floating mb-1 col-md-6">
                                            <label>First name</label>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="required*" ControlToValidate="tb_firstname" ForeColor="Red" style="font-size:smaller;" ></asp:RequiredFieldValidator> 
                                            <asp:TextBox ID="tb_firstname" runat="server" class="form-control" placeholder="first name" >Tom</asp:TextBox> 
                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="tb_firstname" ErrorMessage="Please enter valid name" ForeColor="Red" style="font-size:smaller;" ValidationExpression="^[a-zA-Z]+$"></asp:RegularExpressionValidator>
                                        </div>
                                        <div class="form-floating mb-1 col-md-6">
                                            <label>Last name</label>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="required*" ControlToValidate="tb_lastname" ForeColor="Red" style="font-size:smaller;" ValidationExpression="^[a-zA-Z]+$"></asp:RequiredFieldValidator> 
                                            <asp:TextBox ID="tb_lastname" runat="server" class="form-control" placeholder="last name">Lee</asp:TextBox>
                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ControlToValidate="tb_lastname" ErrorMessage="Please enter valid name" ForeColor="Red" style="font-size:smaller;" ValidationExpression="^[a-zA-Z]+$"></asp:RegularExpressionValidator>
                                        </div>
                                    </div>
                                    <div class="form-floating mb-1">
                                        <label>Credit card</label>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="required*" ControlToValidate="tb_creditcard" ForeColor="Red" style="font-size:smaller;" ></asp:RequiredFieldValidator>
                                        <asp:TextBox ID="tb_creditcard" runat="server" class="form-control" placeholder="e.g. 5466160126455789">5466160126455789</asp:TextBox>
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="tb_creditcard" ErrorMessage="Please enter valid card number" ForeColor="Red" style="font-size:smaller;" ValidationExpression="^5[1-5][0-9]{14}|^(222[1-9]|22[3-9]\\d|2[3-6]\\d{2}|27[0-1]\\d|2720)[0-9]{12}$"></asp:RegularExpressionValidator>
                                    </div>
                                    <div class="form-floating mb-1">
                                        <label>Email</label>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ErrorMessage="required*" ControlToValidate="tb_email" ForeColor="Red" style="font-size:smaller;" ></asp:RequiredFieldValidator>
                                        <asp:TextBox ID="tb_email" runat="server" class="form-control" placeholder="Enter email">tomlee1@gmail.com</asp:TextBox>  
                                        <asp:Label ID="lbl_emailexist" runat="server" style="font-size:smaller;"></asp:Label>
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="tb_email" ErrorMessage="Please enter valid email" ForeColor="Red" style="font-size:smaller;" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                                    </div>
                                    <div class="form-floating mb-0">
                                        <label>Password</label>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="required*" ControlToValidate="tb_password" ForeColor="Red" style="font-size:smaller;"></asp:RequiredFieldValidator>
                                        <asp:TextBox ID="tb_password" runat="server" class="form-control" TextMode="Password" placeholder="Enter password"></asp:TextBox> 
                                        <asp:Label ID="lbl_pwdscore" runat="server" style="font-size:smaller;"></asp:Label>
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator5" runat="server" ControlToValidate="tb_password" ErrorMessage="12 characters with upper, lowercase, number and symbol" ForeColor="Red" style="font-size:smaller;" ValidationExpression="^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{12,}$"></asp:RegularExpressionValidator>
                                    </div>
                                    <div class="form-floating mb-1">
                                        <label>Date of birth</label>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="required*" ControlToValidate="tb_birthdate" ForeColor="Red" style="font-size:smaller;"></asp:RequiredFieldValidator> 
                                        <asp:TextBox ID="tb_birthdate" runat="server" class="form-control" TextMode="date" placeholder="Enter birth date" ></asp:TextBox>
                                    </div>

                                    <div class="file-upload">
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="Require image*" ControlToValidate="tb_photo" ForeColor="Red" style="font-size:smaller;"></asp:RequiredFieldValidator>
                                        <button class="file-upload-btn" type="button" onclick="$('.file-upload-input').trigger( 'click' )">Add Image</button>
                                        
                                        <div class="image-upload-wrap" style="border: 1px dashed #1FB264;">
                                            <asp:TextBox ID="tb_photo" runat="server" class="file-upload-input" type='file' onchange="readURL(this);" accept="image/*"></asp:TextBox>
                                            <div class="drag-text">
                                                <h3>Drag and drop Image</h3>
                                            </div>
                                        </div>
                                        
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator6" runat="server" ControlToValidate="tb_photo" ErrorMessage="Only (.jpg, .bmp, .png, .gif)" ForeColor="Red" style="font-size:smaller;" ValidationExpression="^(([a-zA-Z]:)|(\\{2}\w+)\$?)(\\(\w[\w].*))(.jpg|.JPG|.gif|.GIF|.jpeg|.JPEG|.bmp|.BMP|.png|.PNG)$"></asp:RegularExpressionValidator>
                                        <div class="file-upload-content">
                                            <asp:Image ID="image_photo" runat="server" class="file-upload-image" alt="your image"/>
                                            <div class="image-title-wrap">
                                                <button type="button" onclick="removeUpload()" class="remove-image">Remove <span class="image-title">Uploaded Image</span></button>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="d-grid">
                                        <asp:Button ID="btn_register" runat="server" Text="Register" OnClick="btn_Register_Click" class="btn btn-outline-primary btn-login btn-block text-uppercase fw-bold mb-2"/>
                                    </div>

                                    <input type="hidden" id="g-recaptcha-response" name="g-recaptcha-response"/>
                                    <asp:Label ID="lbl_gScore" runat="server"></asp:Label>

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
                grecaptcha.execute(' 6Lfsck4eAAAAACfkDR0CksyTJSBjS_Es_sTp3ajD ', { action: 'Submit' }).then(function (token) {
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
