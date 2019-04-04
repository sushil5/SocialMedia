<%@page import="org.json.simple.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
    <link rel="stylesheet" href="bootstrap4/css/bootstrap.css">

</head>

<jsp:include page="header.jsp"></jsp:include>
<body >
<%
JSONObject userObj=(JSONObject)session.getAttribute("userObj");
 %>
<div class="container col-md-9" style="margin:10px 0 0 290px">
 <img src='propic?uid=<%=userObj.get("uid") %>' style="margin:20px 0 0 190px" width="250" height="250" class="avatar rounded-circle" alt="avatar">
<div class="alert alert-success col-lg-8 text-center" style="margin-top:30px" role="alert">
Your profile has been updated.
</div>
</div>
</body>
</html>