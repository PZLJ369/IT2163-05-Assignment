<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="IT2163_Assignment.Home" ValidateRequest="false" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Home Page</title>
    <link rel="stylesheet" href="~/Styling/store.css" />
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous" />
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>

</head>
<body style="background-color:#f8f9fa;">

    <form id="form2" runat="server">
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
                        <li class="nav-item ml-2">
                            <asp:Button ID="btnLogout" runat="server" Text="Logout" OnClick="LogoutMe" Visible="false" class="btn btn-outline-danger"/>
                        </li>
                    </ul>
                </div> 
            </div> 
        </nav>
    </header>
       
        <div class="page-banner overlay-dark bg-image" style="background-image: url(https://media.istockphoto.com/photos/various-stationery-arranged-in-order-picture-id1298288294?b=1&k=20&m=1298288294&s=170667a&w=0&h=fi2p4Jenf5w65Yb-vN28zGqCrGiUw-SN79x2XZQ5Dm4=);">
    <div class="banner-section">
        <div class="container text-center wow fadeInUp">
            <nav aria-label="Breadcrumb">
                <ol class="breadcrumb breadcrumb-dark bg-transparent justify-content-center py-0 mb-2">
                    <li class="breadcrumb-item"><a asp-area="" asp-page="/Index">Home</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Store</li>
                </ol>
            </nav>
            <h1 class="font-weight-normal">Stationary Store</h1>
        </div> 
    </div> 
</div> 


<div class="page-section">
    <div class="container">
        <a href="#" id='countdown' class="tag-cloud-link" style="margin:0 auto;"></a>
        <div class="row">
            
            <div class="col-lg-8">
                <div class="row">

                    <div class="col-sm-6 py-3">
                        <div class="card-blog">
                            <div class="header">
                                <div class="post-category">
                                    <a href="#">Stationary</a>
                                </div>
                                <a href="#" class="post-thumb">
                                    <asp:Image ID="Image11" runat="server" ImageUrl="~/Image/s1.png" />
                                </a>
                            </div>
                            <div class="body">
                                <h5 class="post-title"></h5>
                                <div class="site-info">
                                    <div class="avatar mr-2">
                                        <span>
                                            Harry Potter Premium Stationery Set Spells by 4FootyFans
                                        </span>
                                    </div>
                                    <span class="mai-time"></span>$22.99
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-sm-6 py-3">
                        <div class="card-blog">
                            <div class="header">
                                <div class="post-category">
                                    <a href="#">Stationary</a>
                                </div>
                                <a href="#" class="post-thumb">
                                    <asp:Image ID="Image2" runat="server" ImageUrl="~/Image/s2.png" />
                                </a>
                            </div>
                            <div class="body">
                                <h5 class="post-title"></h5>
                                <div class="site-info">
                                    <div class="avatar mr-2">
                                        <span>

                                            Students Cute Cartoon Notebook Set with Scrapbook Tapes Ballpoint
                                        </span>
                                    </div>
                                    <span class="mai-time"></span>$11.50
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-sm-6 py-3">
                        <div class="card-blog">
                            <div class="header">
                                <div class="post-category">
                                    <a href="#">Stationary</a>
                                </div>
                                <a href="#" class="post-thumb">
                                    <asp:Image ID="Image3" runat="server" ImageUrl="~/Image/s3.png" />
                                </a>
                            </div>
                            <div class="body">
                                <h5 class="post-title"></h5>
                                <div class="site-info">
                                    <div class="avatar mr-2">
                                        <span>
                                            Tab Marker Flower Painting Starry Sky Scenery Sunset
                                        </span>
                                    </div>
                                    <span class="mai-time"></span>$1.30
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-sm-6 py-3">
                        <div class="card-blog">
                            <div class="header">
                                <div class="post-category">
                                    <a href="#">Stationary</a>
                                </div>
                                <a href="#" class="post-thumb">
                                    <asp:Image ID="Image4" runat="server" ImageUrl="~/Image/s4.png" />
                                </a>
                            </div>
                            <div class="body">
                                <h5 class="post-title"></h5>
                                <div class="site-info">
                                    <div class="avatar mr-2">
                                        <span>

                                            LOCAL STOCK Colourful Memo Sticky Note Planner Flags Tabs
                                        </span>
                                    </div>
                                    <span class="mai-time"></span>$6.90
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-sm-6 py-3">
                        <div class="card-blog">
                            <div class="header">
                                <div class="post-category">
                                    <a href="#">Stationary</a>
                                </div>
                                <a href="#" class="post-thumb">
                                    <asp:Image ID="Image5" runat="server" ImageUrl="~/Image/s5.png" />
                                </a>
                            </div>
                            <div class="body">
                                <h5 class="post-title"></h5>
                                <div class="site-info">
                                    <div class="avatar mr-2">
                                        <span>
                                            Diary Notebook A5 PU Wire O Journal Executive
                                        </span>
                                    </div>
                                    <span class="mai-time"></span>$14.50
                                </div>
                            </div>
                        </div>
                    </div>


                    <div class="col-12 my-5">
                        <nav aria-label="Page Navigation">
                            <ul class="pagination justify-content-center">
                                <li class="page-item disabled">
                                    <a class="page-link" href="#" tabindex="-1" aria-disabled="true">Previous</a>
                                </li>
                                <li class="page-item active" aria-current="page">
                                    <a class="page-link" href="#">1 <span class="sr-only">(current)</span></a>
                                </li>
                                <li class="page-item">
                                    <a class="page-link" href="#">2</a>
                                </li>
                                <li class="page-item">
                                    <a class="page-link" href="#">Next</a>
                                </li>
                            </ul>
                        </nav>
                    </div>
                </div>
            </div>
            <div class="col-lg-4">
                <div class="sidebar">

                    <div class="sidebar-block">
                        <h3 class="sidebar-title">Types</h3>
                        <div class="tagcloud">
                            <a href="#" class="tag-cloud-link">Pen</a>
                            <a href="#" class="tag-cloud-link">Book</a>
                            <a href="#" class="tag-cloud-link">Marker</a>
                            <a href="#" class="tag-cloud-link">bag</a>
                            <a href="#" class="tag-cloud-link">bottle</a>
                            <a href="#" class="tag-cloud-link">shoe</a>
                            
                        </div>
                    </div>
                    <script>
                        var countDown = 60;

                        function countdown() {
                            setInterval(function () {
                                if (countDown == 0) {
                                    return;
                                }
                                countDown--;
                                document.getElementById('countdown').innerHTML = "Timeout: "+countDown;
                                return countDown;
                            }, 1000);
                        }

                        countdown();
                    </script>
                </div>
            </div>
        </div> 
    </div> 
</div> 
</form>
<br />
<footer class="border-top footer text-muted">
    <div class="container">
        &copy; IT2163ASAssignment - By 202016N
    </div>
</footer>

</body>
</html>
