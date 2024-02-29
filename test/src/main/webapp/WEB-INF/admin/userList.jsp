<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../Main.jsp" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	.userList{
		margin: auto;
	}
</style>
</head>
<body>
	<div class="userList">
		<table align="center" border="1">
		<tr><td colspan="12" align="center" ><h1> 유저 관리 페이지 </h1></tr>
			<tr>
				<th>회원번호</th>
				<th>아이디</th>
				<th>이름</th>
				<th>닉네임</th>
				<th>보유 캐시</th>
				<th>전화번호</th>
				<th>가입 일자</th>
				<th width="250">주소</th>
				<th>패널티</th>
				<th>라이더 승인</th>
				<th>회원 상태</th>
				<th>수정</th>
			</tr>
			<c:forEach var="user" items="${ list }">
			<tr>
				<td align="center">${ user.no }</td>
				<td align="center">${ user.id }</td>
				<td align="center">${ user.name }</td>
				<td align="center">${ user.nickname }</td>
				<td align="center">${ user.cash }</td>
				<td align="center">${ user.phone }</td>
				<td align="center">${ user.regDate }</td>
				<td align="center">${ user.location }</td>
				<td align="center">${ user.penalty }</td>
				<td align="center">
				<c:if test="${ user.deliver eq true }"> 신청 </c:if>
				<c:if test="${ user.deliver eq false }"> 미신청 </c:if>
				</td>
				<td align="center">${ user.status }</td>
				<td align="center"><button onclick="location.href">회원 수정</button></td>
			</tr>
			</c:forEach>
		</table>
	</div>
<%@ include file="../parts/footer.jsp" %>	
