<%@page import="org.json.simple.JSONObject"%>
<%@page import="com.socialmedia.bu.JSONConvertor"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.socialmedia.dao.DBConnection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

    <title>Profile</title>
       <script src="scripts/angular.js"></script>
     

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css"></link>

    <style>
        .side{
            width:400px;
            height:800px;
            background-color: white;
            border: 1px solid lightgrey;
            border-radius: 5px;
            box-shadow: 2px 2px 2px 2px rgba(0.1, 0.1, 0.1, 0.1), 2px 2px 2px 2px rgba(0.1, 0.1, 0.1,0.1);
            margin: 20px 0 20px 0;
        }
        .side #name{
            margin: 0 ;
            padding: 0;
            width: auto;
            height:60px;
            background: transparent;

        }
        .side #propic{
            width: 350px;
            height: 300px;

        }
        .side #info{
            margin-top:10px ;

        }
        .main{
            width:800px;
            height:800px;
            background-color: white;
            border: 1px solid lightgrey;
            border-radius: 5px;
            box-shadow: 2px 2px 2px 2px rgba(0.1, 0.1, 0.1, 0.1), 2px 2px 2px 2px rgba(0.1, 0.1, 0.1,0.1) ;
            margin: 20px 0 20px ;
        }

    </style>
    <link rel="stylesheet" href="bootstrap/css/bootstrap.css">

</head>
<%! 
HttpSession session=null;
%>
<% 		
session=request.getSession();
JSONObject userObj=(JSONObject)session.getAttribute("userObj");


 %>
 <jsp:include page="/header.jsp" />
<body style="background-color: lightgrey" ng-app="profile" ng-controller="main" >
<div class="container">
    <div class="row" >
<div class="side col-sm-4">
<div id="name">
    <h3  style="margin: 0;padding: 15px 0px 0px 25px;font-family: Segoe UI, Arial, sans-serif;font-weight: 300"><%=userObj.get("name")%></h3>
</div>
    <hr style="width: 350px">

<div id="propic" ><img src="propic?uid=<%=userObj.get("uid")%>" class="img-thumbnail" alt="propic" style="width:350px;height:300px"/></div>
    <hr style="width: 350px">

    <div id="info">
    <table class="table">
        <tr>
            <td>Username</td>&nbsp;&nbsp;&nbsp;&nbsp;<td><%=userObj.get("username")%></td>
        </tr>
        <tr>
            <td>Email</td>&nbsp;&nbsp;&nbsp;&nbsp;<td><%=userObj.get("email") %></td>
        </tr>
        <tr>
            <td>Contact</td>&nbsp;&nbsp;&nbsp;&nbsp;<td><%=userObj.get("mobile_no")%></td>
        </tr>
        <tr>
            <td>Address</td>&nbsp;&nbsp;&nbsp;&nbsp;<td><%=userObj.get("address")%></td>
        </tr>
        <tr>
            <td>Date of Birth</td>&nbsp;&nbsp;&nbsp;&nbsp;<td><%=userObj.get("dob")%></td>
        </tr>
    </table>

</div>
</div>

    <div class="main col-sm-8">
        <div class="btn-group-lg">
<button class="btn  btn-info btn-lg" style="border-radius: 0;">Friends(<%=userObj.get("friends")%>)</button>
<button class="btn  btn-info btn-lg" style="border-radius: 0">Followers(<%=userObj.get("follower")%>)</button>
<button class="btn  btn-info btn-lg" style="border-radius: 0">Following(<%=userObj.get("following")%>)</button>
        </div>
        <hr style="width: 730px;margin-top:27px">
        <div style="width:auto;height: 60px;background-color:rgba(132,132,174,0.1)">
        <button class="btn btn-sm btn-info " style="background-color: white;color: #00b3ee;margin: 15px 0 0 10px">People</button>&nbsp;&nbsp;
        <button class="btn btn-sm btn-info" style="background-color: white;color: #00b3ee;margin-top: 15px"><span class="fa fa-user-plus"></span>&nbsp;Follow</button>
        </div>
        <div>
            <table class="table table-striped">
                <tr><th>Title</th>
                    <th>Friends</th>
                    <th>Followers</th>
                    <th>Following</th>
                </tr>
                <tr  ng-repeat="user in people.user">
                    <td><input type="checkbox" > {{user.title}}</td>
                    <td>{{user.Friends}}</td>
                    <td>{{user.Followers}}</td>
                    <td>{{user.Following}}</td>
                </tr>
            </table>
        </div>
    </div >


    </div>
</div>
  <script >
           var app=angular.module('profile',[]);
           app.controller('main',function ($scope,$http) {
             
                $http.get("json/people.json")
                   .then(function (response) {$scope.people = response.data;});
              
       
           });
       </script>
</body>
</html>


