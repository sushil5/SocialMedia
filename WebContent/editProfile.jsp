<%@page import="org.json.simple.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

    <title>Edit profile</title>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    
    <script src="scripts/angular.min.js"></script>
    <script>
        var app = angular.module("MyApp", []).controller("HomeController", function ($scope,$http) {

            $scope.img="images/nophoto.png";
           

            $scope.imageUpload = function(event){
                var files = event.target.files; //FileList object

                var file = files[0];
                var reader = new FileReader();
                reader.onload = $scope.imageIsLoaded;
                reader.readAsDataURL(file);
            }

            $scope.imageIsLoaded = function(e){
                $scope.$apply(function() {
                    $scope.img=e.target.result;
                });
            }

        });
        

    </script>
    <link rel="stylesheet" href="bootstrap/css/bootstrap.css">
    <script src="bootstrap/js/bootstrap.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css"></link>

</head>
<jsp:include page="header.jsp"></jsp:include>
<body ng-app="MyApp" ng-controller="HomeController">
<%
JSONObject userObj=(JSONObject)session.getAttribute("userObj");
 %>
<div class="container " style="margin:40px">
    <h1>Edit Profile</h1>
    <hr>
    <div class="row">
        <!-- left column -->
        <div class="col-md-3">
            <div class="text-center">
                <img src='{{img}}' width="250" height="250" class="avatar rounded-circle" alt="avatar">
                <h6>Upload a photo...</h6>

                <input form='form1' type='file' name="propic" class="form-control" ng-model-instant onchange="angular.element(this).scope().imageUpload(event)"/>
            </div>
        </div>

        <!-- edit form column -->
        <div class="col-md-9 personal-info">
           <!-- <div class="alert alert-info alert-dismissable">
                <a class="panel-close close fa fa-close" data-dismiss="alert"></a>
                <i class="fa fa-coffee"></i>
                This is an <strong>.alert</strong>. Use this to show important messages to the user.
            </div>-->
            <h3>Personal info</h3>

            <form class="form-horizontal" id="form1" enctype="multipart/form-data" action="editProfileServlet" role="form" method="post">
                <div class="form-group">
                    <label class="col-lg-3 control-label">First name:</label>
                    <div class="col-lg-8">
                        <input class="form-control" name="firstName" type="text" required value= '<%=userObj.get("first_name") %>' >

                    </div>
                </div>
                <div class="form-group">
                    <label class="col-lg-3 control-label">Last name:</label>
                    <div class="col-lg-8">
                        <input class="form-control" name="lastName" type="text" required value= '<%=userObj.get("last_name") %>'>
                    </div>
                </div>
                
            
       <div class="form-group col-lg-8" ng-class="{'text-danger':form1.email.$touched &&form1.email.$invalid}">
                    <label for="email" class="control-label" >Email Address</label>

                    <input type="email" id="email" required  value="<%=userObj.get("email") %>"    name="email"  class="form-control"
                           ng-class="{'is-invalid':form1.email.$error.email||(form1.email.$touched && form1.email.$invalid)}"  pattern="^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,4}$">

                    <span class="text-danger " ng-show="form1.email.$error.pattern">email is invalid</span>

                </div>


                <div class="form-group col-lg-8"  ng-class="{'text-danger':form1.mobile.$touched && form1.mobile.$invalid}">
                    <label  for="mobile" class=" control-label" >Mobile</label>

                    <input type="text" id="mobile" required value="<%=userObj.get("mobile_no") %>"  name="mobile"   class="form-control" pattern="[0-9]{10}"
                           ng-class="{'is-invalid':form1.mobile.$error.pattern||(form1.mobile.$touched && form1.mobile.$invalid)}"  >

                    <span class="text-danger " ng-show="form1.mobile.$error.pattern">mobile no. is invalid</span>

                </div>
                <div class="form-group">
                    <label class="col-lg-3 control-label">Address:</label>
                    <div class="col-lg-8">
                        <input class="form-control" type="text" name="address" value= '<%=userObj.get("address") %>' required>
                    </div>
                </div>

                <div class="form-group">
                    <label class="col-lg-3 control-label">Date of Birth:</label>
                    <div class="col-lg-8">
                        <input class="form-control" type="date" name="date" value="<%=userObj.get("dob") %>"  required>
                    </div>
                </div>


                <div class="form-group">
                    <label class="col-md-3 control-label"></label>
                    <div class="col-md-8">
                        <input type="submit" class="btn btn-danger" value="Save Changes">
                        <span></span>
                        <input type="reset" class="btn btn-default" value="Cancel">
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
<hr>

</body>
</html>


