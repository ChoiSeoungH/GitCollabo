<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Insert title here</title>
</head>
<body>
<table>
  <form action="${ctx}/productSearch.do" method="get">
    <input placeholder="검색어 입력" type="text" name="query">

    <input type=submit value="검색">
  </form>
</table>
<table>
  <h2>click</h2>
  <a href="${ctx}/productList.do">리스트보기</a>
  <br>

  <a href="${ctx}/productAdd.do">상품추가하기</a>
</table>
</body>
</html>