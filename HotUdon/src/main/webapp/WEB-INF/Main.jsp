<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %> 

<c:set var="ctx" value="${ pageContext.request.contextPath }"/> 
<!DOCTYPE html>
<html>
<head> 
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
    #container {
        height: 100vh;
        width: 100vw;
        margin: 0;
        padding: 0;
    	position: relative;
    }
    #main{
        height: 100%;
        width: 100%;
    }
    th, td{
        border: 1px solid black;
    }
    #main > td, #main > td > th {
        border: 1px solid black;
    }
	#main_nav,#main_info{
		width: calc(50% - 600px);
	}
	#main_header{
		width: 1200px;
		height: 100px;
	}
</style>
</head>
<body>
<div id="container">
	<table id="main">
	<!-- Nav -->
	<tr>
	<td id="main_nav" rowspan ="2"> 
	<%@ include file="./parts/Nav.jsp" %>
	<%-- <jsp:include page="./parts/Nav.jsp"/> --%>
	 </td>
	
	<!-- header -->
	<td id="main_header" >
	<%@ include file="./parts/header.jsp" %>
	<%-- <jsp:include page="./parts/header.jsp"/> --%>
	</td>
	
	<!-- Info -->
	<td id="main_info" rowspan ="2">
	<%@ include file="./parts/Info.jsp" %>
	<%-- <jsp:include page="./parts/Info.jsp"/> --%>
	</td>
	</tr>
	
	<!-- center -->
		<jsp:include page="${center}"/>
	<tr><td>
