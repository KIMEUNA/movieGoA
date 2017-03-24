<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%
   String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>movieGo_Admin</title>
  
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
  <link rel="stylesheet" href="<%=cp%>/res/css/bootstrap.min.css">
  <link rel="stylesheet" href="<%=cp%>/res/css/jquery-jvectormap-1.2.2.css">
  <link rel="stylesheet" href="<%=cp%>/res/css/AdminLTE.min.css">
  <link rel="stylesheet" href="<%=cp%>/res/css/_all-skins.min.css">
	  
    <script type="text/javascript" src="<%=cp%>/res/js/jquery-1.10.2.min.js"></script>
	<script src="<%=cp%>/res/js/app.min.js"></script>
	<script src="<%=cp%>/res/js/bootstrap.min.js"></script>

</head>
<body class="hold-transition skin-blue sidebar-mini">
<div class="wrapper">
    
    <tiles:insertAttribute name="header"/>
    
    <tiles:insertAttribute name="left"/>
    
    <tiles:insertAttribute name="body"/>

    <tiles:insertAttribute name="footer"/>


  <div class="control-sidebar-bg"></div>

</div>
<!-- ./wrapper -->

</body>
</html>