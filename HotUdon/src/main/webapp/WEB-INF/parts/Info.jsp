<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	.info{
		width: 100%;
		visibility: visible;
    	opacity: 1;
	}
	.hidden{
		visibility: hidden;
    	opacity: 0;
	}
	.info_nickname{
		text-decoration: none;
      	color: black;
	}
	.info_cash{}
	.info_notify{
		width: 95%;
		border: 1px solid black;
		border-radius: 5px;
		margin: 5px auto;
	}
	.info_chat, .info_pay, .info_quick, .info_logout{
		width: 95%;
		margin: 5px auto;
		padding: 10px auto;
		justify-content: center;
		/* border: none; */
		border-radius: 5px;
	}
</style>
</head>
<body>
 <div class="info hidden">
 	<a class="info_nickname" href='${ctx}/userMyPage.do?no=${ user.no }'> ${ user.nickname } (${ user.name }) </a>
 	<div class="info_cash" onclick=""> ${ user.cash } </div>
 	<div class="info_notify" > 알림 </div>
 	<button class="info_chat" onclick="">채팅</button>
 	<button class="info_pay" onclick="">결제</button>
 	<button class="info_quick" onclick= "location.href=`${ctx}/quickMain.do?no=${user.no}`">퀵 서비스</button>
 	<input type="button" class="info_logout" onclick="location.href='${ctx}/userLogOut.do'"
 	<c:if test="${ user.pw eq 'SNSPw' }"> onclick="kakaoLogout()" </c:if> value="로그아웃"/>
 </div>
</body>
</html>
 <%@ include file="../user/kakaoLogin.jsp" %>
<script>
	const $info = document.querySelector(".info");
	let clicked = false;
	function openInfo(){
		if(!clicked) {
			$info.classList.remove("hidden");
			clicked = true;
		} else {
			$info.classList.add("hidden");
			clicked = false;
		}

	}
</script>