<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<c:set var="ctx" value="${ pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Insert title here</title>
  <style>
      body {
          background-color: #f0f0f0;
          color: #333;
      }
      #container {
          height: 100vh;
          width: 100vw;
          margin: 0;
          padding: 0;
          position: relative;
          background-color: #ffffff;
          box-shadow: 0 2px 4px rgba(0,0,0,0.1);
      }

      #main {
          height: 100%;
          width: 100%;
      }

      th, td {
          /* border: 1px solid black; */
      }

      td {
          vertical-align: middle !important; /* 중요도를 높여 다른 스타일을 오버라이드 */
          text-align: center !important; /* 중요도를 높여 다른 스타일을 오버라이드 */
      }

      #main > td, #main > td > th {
          border: 1px solid black;
      }

      #main_nav, #main_info {
          width: 300px;
          background-color: #e9ecef;
          border: 1px solid #dee2e6;
          padding: 20px;
      }
      #main_nav {
          border-right: none;
      }

      #main_info {
          border-left: none;
      }

      #main_header {
          width: 1200px;
          height: 100px;
          font-size: 24px;
          font-weight: bold;
          text-align: center;
          padding: 20px;
          background-color: #007bff;
          color: white;
      }
      #main_center {
          padding: 20px;
      }
      #main_nav a, #main_info a {
          transition: color 0.3s ease-in-out;
      }

      #main_nav a:hover, #main_info a:hover {
          color: #0056b3;
      }
  </style>
</head>
<body>
<div id="container">
  <table id="main">
    <!-- Nav -->
    <tr id="main_tr">
      <td id="main_nav" rowspan="2">
        <%@ include file="parts/Nav.jsp" %>
        <%-- <jsp:include page="./parts/Nav.jsp"/> --%>
      </td>

      <!-- header -->
      <td id="main_header">
        <%@ include file="parts/header.jsp" %>
        <%-- <jsp:include page="./parts/header.jsp"/> --%>
      </td>

      <!-- Info -->
      <td id="main_info" rowspan="2">
        <%@ include file="parts/Info.jsp" %>
        <%-- <jsp:include page="./parts/Info.jsp"/> --%>
      </td>
    </tr>

    <!-- center -->
    <tr>
      <td id="main_center">
					<jsp:include page="${center}"/>