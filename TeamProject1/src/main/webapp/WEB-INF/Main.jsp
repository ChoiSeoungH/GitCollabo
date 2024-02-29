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
    .container {
        height: 100vh;
        width: 100vw;
        margin: 0;
        padding: 0;
    	position: relative;
			display: flex;
			justify-content: space-between;
    }
    .main{
        height: 100%;
        width: 100%;
    }
    td, th {
        border: 1px solid black;
    }
		.nav, .info {
			flex: 1; /* nav와 info가 동일한 비율로 나눠 가짐 */
		}

		.header {
			flex: 0 0 1200px; /* 헤더의 너비를 1200px로 고정 */
			max-width: 1200px;
		}

</style>
</head>
<body>
<div class="container">
	<table class="main">

	<!-- Nav -->
	<tr>
	<td rowspan ="2">
	<%@ include file="./parts/Nav.jsp" %>
	<%-- <jsp:include page="./parts/Nav.jsp"/> --%>
	 </td>

	<!-- header -->
	<td width="1200px" height="100px">
	<%@ include file="./parts/header.jsp" %>
	<%-- <jsp:include page="./parts/header.jsp"/> --%>
	</td>

	<!-- Info -->
	<td rowspan ="2">
	<%@ include file="./parts/Info.jsp" %>
	<%-- <jsp:include page="./parts/Info.jsp"/> --%>
	</td>

	</tr>

	<!-- center -->
	<tr><td>