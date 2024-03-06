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
	th{
		height: 50px;
		background-color: #efefef;
		border-radius: 3px;
	}
	#penalty{
		width: 40px;
		border: none;
		text-align: center;
		font-size: 1.0em;
	}
	#userList > td{
		height: 40px;
		border-bottom: 1px solid black;
		background-color: #fafafa;
	}
	/* th{
		max-width: 150px;
		overflow-x: scroll;
	} */
</style>
</head>
<body>
	<div class="userList">
	<form action="" id="form">
		<table align="center" >
		<tr><td colspan="12" align="center" ><h1> 유저 관리 </h1></tr>
			<tr>
				<th>회원번호</th>
				<th width="150">아이디</th>
				<th width="70">이름</th>
				<th width="70">닉네임</th>
				<th width="70">보유 캐시</th>
				<th width="130">전화번호</th>
				<th width="130">가입 일자</th>
				<th width="250">주소</th>
				<th>패널티</th>
				<th width="50">라이더 신청</th>
				<th>회원 상태</th>
				<th>수정</th>
			</tr>
			<c:forEach var="user" items="${ list }" varStatus="i">
			<input type="hidden" name="no" id="no" value="${ user.no }"/>
			<tr id="userList" data-no="${user.no}" >
				<td align="center">${ user.no }</td>
				<td align="center">
				<c:if test="${ user.pw ne 'SNSPw' }">${ user.id }</c:if>
				<c:if test="${ user.pw eq 'SNSPw' }">SNS 로그인 회원</c:if>
				</td>
				<td align="center">${ user.name }</td>
				<td align="center">${ user.nickname }</td>
				<td align="center">${ user.cash }</td>
				<td align="center">${ user.phone }</td>
				<td align="center">${ user.regDate }</td>
				<td align="center">${ user.location }</td>
				<td align="center">
				<input type="number" name="penalty" id="penalty" value="${ user.penalty }" min="0"/></td>
				<td align="center">
				<c:if test="${ user.deliver eq true }"> 신청 </c:if>
				<c:if test="${ user.deliver eq false }"> 미신청 </c:if>
				</td>
				<td align="center">
				<c:if test="${ user.status ne '4' }">활동중</c:if>
				<c:if test="${ user.status eq '4' }">활동제한</c:if></td>
				<td align="center"><input type="button" data-no="${ user.no }" onclick="penaltyUpdate(${user.no})" value="수정" /></td>
			</tr>
			</c:forEach>
		</table>
	</form>
	</div>
<%@ include file="../parts/footer.jsp" %>	

<script type="text/javascript">
function penaltyUpdate(no){
	const penalty = document.querySelector('tr[data-no="' + no + '"] input[name="penalty"]').value;
	console.log(no);
	console.log(penalty);
	fetch("userPenalty.do", {
		method : "POST",
		headers : {"Content-Type": "application/x-www-form-urlencoded; charset=UTF-8",},
		body : "no="+no+"&penalty="+penalty,
	})
	
	.then(response => response.text())
	.catch(error => console.log(error));
	
}
</script>
