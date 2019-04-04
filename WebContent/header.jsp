<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
  <link rel="stylesheet" href="bootstrap/css/bootstrap.css">
      <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.js"></script>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
   <!--  
    <script src="scripts/angular.js"></script>
    <script>
        var app = angular.module("MyApp", []).controller("HomeController", function () {


        }); -->
<script type="text/javascript">

/* $("#pro").click(function(){
	  $("drop").toggle();
	}); */
	$(document).ready(function(){
		  $("#pro").click(function(){
		    $("#drop").toggle();
		  });
		});
</script>
    
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css"></link>
    <style>
        .navs a{
            color:white;
        }
        .navs input[type=text] {
            padding: 6px 0 6px 10px;

            border:none ;
            border-bottom-left-radius: 4px;
            border-top-left-radius: 4px;
            font-size: 15px;
            font-weight: 400;
        }
       
</style>
</head>
<body>
<%! HttpSession session=null;
  String homeUrl=null;
  String profileUrl=null;
%>
<%  session=request.getSession();
int uid=(int)session.getAttribute("uid");
String user=(String)session.getAttribute("user");
homeUrl="home?uid="+uid+"&user="+user;
profileUrl="profile?uid="+uid+"&user="+user;

%>

<div  class=" navs container-fluid" style="width: auto;height: 60px;background-color: #ec4c4c;">

    <ul class="nav" style="padding:10px 0 0 100px">
        <li class="nav-item"><img src="images/logo1.png" class="rounded" height="40" width="40" style="background-color: white;margin-right: 10px"/></li>

        <li class="nav-item"><h4 style="color: whitesmoke;margin-top: 5px">SocialMedia</h4></li>
        <li class="nav-item" style="margin-left:20px;padding-top:3px">
            <input type="text" placeholder="search..."><span><button class="btn fa fa-search" style="background-color: white;padding:8px;margin-bottom: 4px;border-bottom-left-radius: 0;border-top-left-radius: 0;"></button></span>
        </li>
        <li class="nav-item" style="margin-left:120px">
            <a class="nav-link" href="<%= homeUrl%>"><span class="fa fa-home"></span> Home</a>
        </li>

        <li class="nav-item">
            <a class="nav-link"  href="#"><span class="fa fa-bell"></span> Notification</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="#"><span class="fa fa-envelope"> </span> Messages</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="#"><span class="fa fa-cog"> </span> Setting</a>
        </li>
        <li class="nav-item dropdown" style="margin-left:45px;border-left: 1px whitesmoke solid;border-right: 1px whitesmoke solid">
            <a class="nav-link dropdown-toggle" data-toggle="dropdown" id="pro" href="#"><span class="fa fa-user"> </span> <%=  user %></a>
            <div class="dropdown-menu"  id="drop">
                <a class="dropdown-item" href="<%= profileUrl %>" style="color:black">view profile</a>
                <a class="dropdown-item" href="editProfile.jsp" style="color:black">edit profile</a>
            </div>
        </li>
    </ul>
</div>
</body>
</html>