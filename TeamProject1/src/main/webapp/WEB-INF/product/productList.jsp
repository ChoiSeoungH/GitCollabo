<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<c:set var="ctx" value="${pageContext.request.contextPath}"/>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%-- <table border=1>
    <c:forEach var="c" items="${list}">
  <c:forEach var="c" items="${list}"  varStatus="i">
        <tr>
            <td>${c.someProperty1}</td>
            <td>${c.someProperty2}</td>
            <!-- 나머지 열들도 필요에 따라 추가 -->
        </tr>
    </c:forEach>
</table> --%>
<c:forEach var="c" items="${list}"> 
<table border=1>
        <tr>
        <td>이미지 비고</td>
            <td>${c.title}</td>
            <td>${c.price}</td>
           
            <!-- 나머지 열들도 필요에 따라 추가 -->
        </tr>
    
</table>
</c:forEach>
</body>
</html>