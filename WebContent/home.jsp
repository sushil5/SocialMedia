<%@page import="com.socialmedia.dao.ProfileDAO"%>
<%@page import="com.socialmedia.dao.PostDAO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.socialmedia.helper.StringOperation"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="java.util.HashMap"%>
<%@page import="org.json.simple.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>SocialMedia</title>
      <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    
    
        <script src="scripts/angular.min.js"></script>
        <link rel="stylesheet" href="styles/swiper.min.css">
        <link rel="stylesheet" href="styles/swiperNew.css">
    <script src="scripts/swiper.min.js"></script>
    <script src="scripts/swiperNew.js"></script>
    
     <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
    
    <script>
        var app = angular.module("MyApp", []).controller("HomeController", function ($scope) {
        	$scope.img="";
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
<script type="text/javascript">
$(document).ready(function () {
    $("span.add").hover(function () {

            $(this).css("color","#ec4c4c");

    },function () {
        $(this).css("color","lightgrey");

    });
})

</script>
    
    
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css"></link>
    <style>
       
       .add  {
            font-size:40px;        
              }
        .add:hover{
            color:#ec4c4c;
        }
        .title{
            margin: 0px 0 0 6px;font-weight: 500;
        }
        .hf{
            padding-top: 0;
            height:60px;
        }
        .main {
            display:flex;
        }
       .main #left{

           width: 250px;height: 500px;background-color: white;

       }
        .main #centerup{

        height: 100px;width: 600px;background-color:white;margin-left:20px;
            box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
            border-top: 3px  #ec4c4c solid ;
        }
        .post{
            margin: 20px;
            height: 650px;width: 600px;background-color:white;
        }
        .main #right{

            width: 250px;height: 500px;background-color: white;
        }
      
         ::-webkit-file-upload-button {
            background: #ec4c4c;
            color: white;
            border: 1px  red solid ;
            padding: 5px;
            border-radius: 3px;

        }
    </style>
</head>
 <jsp:include page="/header.jsp" />

<body style="background-color:whitesmoke" ng-app="MyApp" ng-controller="HomeController">
<%! HttpSession session=null;
  String profileUrl=null;
  JSONObject obj=null;
  int uid1=0;
  String name1=null;
  String aboutMsg=null;
  ResultSet rs=null;
  JSONObject objTemp=null;
%>
<%  session=request.getSession();
int uid=(int)session.getAttribute("uid");
String user=(String)session.getAttribute("user");
profileUrl="profile?uid="+uid+"&user="+user;
JSONObject userObj=(JSONObject)session.getAttribute("userObj");
JSONArray topProfiles=(JSONArray)session.getAttribute("topProfiles");
%>


<div class="main container" style=" margin-top:20px;width: 100%;height:100%;">

    <div id="left" >
 <div style="height:100px;background-color:#ec4c4c; "><img src="propic?uid=<%=uid %>" style="border:5px white solid;margin:28px 0 0 43px; width:150px;height:150px " class="avatar rounded-circle" alt=""> </div>
        <div style="margin-top: 80px;"><h4 class="text-center"><%=StringOperation.getCapitalize(userObj.get("name").toString())%></h4></div>
        <hr/>
        <div style="height: 80px">
            <h6 class="text-center">Followers</h6>
            <h1 style="color: lightgrey" class="text-center"><%=userObj.get("follower")%></h1>
        </div>
        <hr>
        <div style="height: 80px">
            <h6 class="text-center">Following</h6>
            <h1 style="color: lightgrey"  class="text-center"><%=userObj.get("following")%></h1>
        </div>
        <hr>
        <a class= "font-weight-bold" style="margin-left: 70px;color: red" href="profile.jsp">
            view profile
        </a>
    </div>
    <div id="center1">
      <div id="centerup">
      <img src="propic?uid=<%=userObj.get("uid") %>" class="rounded-circle" style="margin-top:15px;padding:3px;border: 3px #ec4c4c solid;margin-left: 10px" height="65" width="65"/>
      <button class="btn btn-danger " style="margin-top:20px;margin-left: 250px" data-toggle="modal" id="profileUpdate" data-target="#myModal">Update Profile</button>
      <button class="btn btn-danger " style="margin-top:20px;margin-left: 10px" data-toggle="modal" id="statusUpdate" data-target="#myModal">Post Status</button>
       <!-- The Modal -->
   <div class="modal fade" id="myModal" >
              <div class="modal-dialog modal-dialog-centered">
                  <div class="modal-content">

                      <!-- Modal Header -->
                      <div class="modal-header">
                          <h4 class="modal-title">Write a Post</h4>
                          <button type="button" class="close" data-dismiss="modal">&times;</button>
                      </div>

                      <!-- Modal body -->
                      <form id="pos" action="postServlet" enctype="multipart/form-data" method="post">
                      <input id="about" name="aboutMsg" type="text" style="display:none" value=""></input>
                      
                      <div class="modal-body">
                          <textarea name="status" class="text" cols="63" rows="3" placeholder="Say Something....." ></textarea>
                      </div>
                      <input type="submit" class="btn btn-danger " value="Post"/>
                  </form>
                      
    <div style="padding-left: 13px;">
    <img src="{{img}}" style="width: 465px;height: 340px" class="img-thumbnail" alt="">
       </div>
                      <!-- Modal footer -->
                      <div class="modal-footer">
                          <input form="pos" type="file" name="media" style="margin-right: 110px" ng-model-instant onchange="angular.element(this).scope().imageUpload(event)">

                      </div>

                  </div>
              </div>
          </div>
      </div>
       
        
          <% 
           rs=PostDAO.getPost();
          if(rs.isBeforeFirst()){
          while(rs.next()){
            objTemp = ProfileDAO.getInfo(rs.getInt("profID"));
          %>
          <div id="centerdown" class="post">
          <div id="head1" class="hf">
              <img src="propic?uid=<%=objTemp.get("uid") %>" class="rounded-circle" style="border: 3px #ec4c4c solid;padding:3px;margin-top:5px;margin-left: 10px" height="65" width="65"/>
<span class=" font-weight-bold" style="margin-left: 10px; font-family:  sans-serif"><%=StringOperation.getCapitalize(objTemp.get("name").toString())%></span><span style="margin-left:10px" ><%=rs.getString("about") %></span>

              <div id="text1" style="width:100%;height: auto;margin-top:0;  padding: 10px;color:grey; font-family: inherit;background-color: white" ><%=rs.getString("status") %></div>
              <div id="media1">
                  <img src="feed?postID=<%=rs.getInt("postid") %>" class="img-thumbnail"  style="height:400px;width:100%">

              </div>
             <div id="like" class="hf" style="padding: 10px;background:white;">
                 <button class="fa fa-heart-o" style="color: #ec4c4c; font-size:30px;background-color: transparent;border:none;"></button>
                 <strong style="font-weight: 500;margin-left:0px;">Like <%=rs.getInt("likes") %></strong>
                 <button class="fa fa-comment-o" style="color: #ec4c4c;  font-size:30px;background-color:transparent; border: none;"></button>
                 <span style="font-weight: 500">Comment 25</span>

             </div>

              <hr width="550" style="margin-top:0px;margin-bottom: 0 ">

              <div id="foot1" class="hf" style="margin-top:0px;background-color: beige">
                  <input type="text" id="commentbox" class="commentbox" style="width:100%;height: 100%;border: none;padding:10px" placeholder="Add a comment...">
              </div>
          </div>


    </div>
       <%  }}
          else{
       %>
       
        <div id="centerdown" class="post">
                   <div id="head1" class="hf">
                   No feeds available.
                   
         </div>
    </div>
       <%} %>
       
       <!-- Swiper -->
<div class="swiper-container" style="background-color:white;">
<div style="padding: 16px 0 0 20px">
    <h5 >More Profiles</h5>

</div>
    <hr>
        <div class="swiper-wrapper" >
    
    <%for(int i=0;i<5;i++){
    	 obj=(JSONObject)topProfiles.get(i);
         uid1=(Integer)obj.get("uid");
         name1=(String)obj.get("name");
         name1=StringOperation.getCapitalize(name1);
    if(uid!=uid1){
    	%>
        <div class="swiper-slide" style="background-image:url('propic?uid=<%=uid1%>')">
            <div class="nameTitle text-center" ><%=name1 %></div>


    <div class="bottomHead"><button class="bottom">view profile</button></div>
</div>
<%}}%>


      
    </div>
    
</div>
   
       
       
<!--      center div
 -->    
</div>

    <div id="right">
      <div>
        <h6 style="margin: 10px 0 0 20px;">Suggestions</h6>
        </div>
        <hr>
        
               
       <% for(int i=0;i<5;i++){
    	   obj=(JSONObject)topProfiles.get(i);
           uid1=(Integer)obj.get("uid");
           name1=(String)obj.get("name");
           name1=StringOperation.getCapitalize(name1);
      if(uid!=uid1){
    	   %>
    	   
    	   
        <div style="margin: 30px 0 0 20px;">
           <img src="propic?uid=<%=uid1 %>" style="height: 40px;width: 40px;" class="avatar rounded-circle" alt="">
           <span class="title"  ><%=name1 %></span>
           <span class="fa fa-plus-square-o add"   style="font-size:35px; float: right;color:lightgrey; margin-top: 3px; margin-right: 5px;" ></span>
       </div>
       <%} }%>
       
      
      
        </div>

</div>
<script>
$(document).ready(function(){
	
	$("#profileUpdate").click(function(){
	
		$("#about").val("updated profile");
		alert($("#about").val());

	});
	$("#statusUpdate").click(function(){
		$("#about").val("shared a story");
		alert($("#about").val());
	});

	
});
</script>
</body>
</html>


