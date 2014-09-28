<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="cvmt.index" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8"/> 
    <title>Home</title>
    <link rel="stylesheet" href="css/bootstrap.css"  type="text/css"/>
</head>
<body>
    <script src="http://code.jquery.com/jquery-1.10.1.min.js"></script>
    <script src="js/bootstrap.js"></script>
    
    
    <form id="form" runat="server">
    <div class="container">
    <!-- SIGN UP Modal -->
        <div class="modal fade" id="signup_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title" id="myModalLabel">Sign up</h4>
                    </div>
                    <div class="modal-body" style="height:200px;">
                        <div id ="left" class="container col-sm-3 pull-left">
                            <p>Email</p>
                            <p>Password</p>
                            <p>First name</p>
                            <p>Last name</p>

                        </div>
                        <div id ="right" class="container col-sm-8 pull-right">
                            <asp:TextBox ID="email" CssClass ="form-control" TextMode="Email" runat="server"></asp:TextBox>
                            <asp:TextBox ID="pass" CssClass ="form-control" TextMode="password" runat="server"></asp:TextBox>
                            <asp:TextBox ID="fname" CssClass ="form-control" runat="server"></asp:TextBox>
                            <asp:TextBox ID="lname" CssClass ="form-control" runat="server"></asp:TextBox>
                        
                        </div>
                    </div>
                    <div class="modal-footer">
                        <asp:Button ID="submit" CssClass="btn btn-primary btn-lg btn-block" runat="server" OnClick="submit_click" Text="Submit information" />
                    </div>
                </div>
            </div>
        </div>
        <h1><a href="”#”">Collaborative Visual Modeling Tool - Home</a></h1>
        <div class="navbar">
          <div class="navbar-inner">
            <div class="container">
              <ul class="nav">
                <li style="float:left" class="active"><a href="#">Home</a></li>
                <li style="float:left"><a href="#">Tutorial</a></li>
                <li style="float:left"><a href="#">Development Team</a></li>
              </ul>
            </div>
          </div>
        </div>

        <div class="hero-unit" style="margin-top:40px;">
            <h1>Getting started</h1>
            <p>Visual modeling is a graphic representation of objects and systems of interest using graphical languages. These modeling languages may be general purpose or domain specific. This tool provides functions to create various types of diagrams, such as, flowcharts, ER diagrams, activity diagrams, sequence diagrams, use case diagrams, class diagrams, etc. The interface focuses on real-time collaboration over the internet. This diagram tool allows multiple users to work simultaneously on a single file.</p>
            <p>To start experiencing sign up now.</p>
          <div class="container" style="margin-top:40px;">
            <div class="col-sm-offset-0 col-sm-3" style="padding:30px;">
                 <p style="text-align:center">Not a member yet ?</p>
                <a href="#" style="height:60px; width:100% ; font-size:large; text-align:center; padding-top:16px;" data-toggle="modal" data-target="#signup_modal" class="btn btn-large btn-success">Signup</a>
                <p style="text-align:center; margin-top:5px;">It's free !!!</p>
            </div>

            <div class="colsm-offset-0 col-sm-7" style="margin-left:100px;">
                <div class="form-group"  style="height:50px; margin-bottom:0px">
                    <label for="inputEmail3" style="padding-top:5px" class="col-sm-2 control-label">Email</label>
                    <div class="col-sm-10">
                        <asp:TextBox ID="u_name" CssClass ="form-control" TextMode="Email" runat="server"></asp:TextBox>
                    </div>
                </div>
                <div class="form-group" style="height:50px; margin-bottom:0px">
                    <label for="inputPassword3" style="padding-top:5px" class="col-sm-2 control-label">Password</label>
                    <div class="col-sm-10" style="padding-top:5px">
                        <asp:TextBox ID="password" CssClass="form-control" runat="server" TextMode="Password"></asp:TextBox>
                    </div>
                </div>
                <div class="form-group"  style="height:50px; margin-bottom:0px">
                    <div class="col-sm-offset-1 col-sm-10" style="padding-top:5px;">
                        <asp:Button ID="Button1" CssClass="btn btn-primary btn-lg btn-block" runat="server" OnClick="Button1_Click" Text="Sign in" />
                    </div>
                </div>
                <div  style="margin-top:10px">
                    <asp:Label ID="warning" CssClass="alert alert-danger" Visible="false" Font-Bold="true" runat="server" Text="" Width="100%"></asp:Label>    
                </div>
            </div>
          </div>
        
        </div>
       </div>
    </form>
</body>
</html>
