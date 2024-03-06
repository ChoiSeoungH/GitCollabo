<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<c:set var="ctx" value="${pageContext.request.contextPath}"/> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>

.search{
	text-align:center;
}
.search>query{
	width:300px;
	height:100px;
}
  .list-container {
    display: flex;
  }
.list {
margin-right: 10px;
	width:100px;
	height:300px;
	border:1px;

}
 img{
 width:100px;
 height:100px;
 }

</style>
</head>
<body>
<form action="${ctx}/productSearch.do" method="get" class="search">
<input class="query" placeholder="검색어 입력" type="text" name="query">

<input type=submit value="검색">
</form>
<c:if test="${vo.size()== 0 }">
<h1 style="text-align:center">${query} 검색한 제품이 현재 존재하지 않습니다</h1>
</c:if>
<c:if test="${vo.size()!= 0}">
<c:forEach var="c" items="${vo}">
<table class="list">
<tr>
<td>옥션값 반환 ${c.auction}</td>
</tr>

<tr>
<td>${c.title}</td>
</tr>
<tr>
<td>${c.price}</td>
</tr>
</table>

</c:forEach>
</c:if>
<hr>
<h3>네이버 최저가 ${query}</h3>
<div class="list-container">
<c:forEach var="na" items="${naver.items}">
<a href="${na.link}" target="_blank">
<table class="list">
<tr>
   <td><img src="${na.image}"></td>
</tr>
<tr>
 <td>${na.lprice}원</td>
</tr>
</table>
</a>
</c:forEach>
</div>
</body>
</html>