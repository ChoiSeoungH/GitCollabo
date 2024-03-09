<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
 	.info{
		width: 250px;
		visibility: visible;
		opacity: 1;
		position: fixed;
		top: 10px;
		right: 10px;
	}
	.hidden{
		visibility: hidden;
    	opacity: 0;
	}
	.info #myPage{
		position: absolute;
		top: 0px;
		left: 150px;
		border: none;
		width: 100px;
		height: 40px;
		border-radius: 5px;
	}
	.info #myPage:hover{
		background-color: #bbb;
	}
	.info_nickname{
		text-decoration: none;
      	color: black;
	}
	.info_cash{}
	.info_notify{
		width: 95%;
		height: 500px;
		border: 1px solid black;
		border-radius: 5px;
		margin: 10px 0;
	}
	.btns{
		width: 95%;
		padding: 10px;
		margin: 10px 0;
		padding: 10px auto;
		border: none;
		border-radius: 5px;
		font-size: 1.5em;
	}
	.btns:hover {
		background-color: #bbb;
	}
</style>
</head>
<body>
 <div class="info hidden">
 	<a class="info_nickname" href='${ctx}/userMyPage.do?no=${ user.no }'> ${ user.nickname } (${ user.name }) </a>
 	<div class="info_cash" onclick=""> 보유 캐시 : ${ user.cash } </div>
 	<input type="button" id="myPage" onclick="location.href='${ctx}/userMyPage.do?no=${ user.no }'" value="마이페이지"/>
 	<div class="info_notify" > 알림 </div>
 	<button class="btns info_chat" onclick="">채팅</button>
 	<button class="btns info_pay" onclick="">결제</button>
 	<button class="btns info_quick" onclick="location.href=`${ctx}/quickMain.do?no=${user.no}`">퀵 서비스</button>
 	<input type="button" class="btns info_logout" onclick="location.href='${ctx}/userLogOut.do'" value="로그아웃"/>
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