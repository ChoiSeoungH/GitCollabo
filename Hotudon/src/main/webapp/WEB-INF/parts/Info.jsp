<%@ page language="java" contentType="text/html; charset=UTF-8"
				 pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>사용자 정보</title>
	<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
	<!-- 부트스트랩 JS -->
	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	<style>
		.info {
			height: 95vh; /* 페이지의 90% 높이 */
			width: 270px;
			overflow-y: auto; /* 필요시 스크롤 */
			position: fixed;
			top: 10px; /* 중앙 정렬을 위해 상단 여백 조정 */
			right: 8px !important;
			background-color: #f8f9fa;
			background-image: linear-gradient(to bottom right, #f8f9fa, #e2e6ea); /* 그라디언트 배경 */
			border: 1px solid #dee2e6;
			border-radius: 10px;
			padding: 20px;
			box-shadow: 0 10px 20px rgba(0,0,0,.1);
			transition: all 0.5s ease-in-out;
			z-index: 1050;
		}
		.hidden {
			right: -300px !important; /* 숨김 효과를 위해 오른쪽으로 이동 */
		}
		.info_nickname {
			font-size: 1.2em;
			color: #007bff;
			margin-bottom: 15px;
			display: block; /* 링크를 블록 요소로 만들어 여백 조정 가능 */
		}
		.info_cash, .info_notify {
			margin-bottom: 15px;
			background-color: #fff;
			border: 1px solid #dee2e6;
			border-radius: 5px;
			padding: 10px;
			box-shadow: 0 2px 4px rgba(0,0,0,.05);
		}
		.info_notify{
			height: 400px;
				 }
		.btns {
			background-image: linear-gradient(to right, #007bff, #0056b3);
			color: white;
			font-weight: bold;
			margin: 5px 0;
			padding: 10px;
			width: calc(100% - 10px); /* 패딩 고려한 너비 조정 */
			border: none;
			border-radius: 5px;
			cursor: pointer;
			transition: transform 0.3s ease-in-out, box-shadow 0.3s ease-in-out;
		}
		.info_logout {
			background-image: linear-gradient(to right, #ff4d4d, #cc0000);
		}
		.btns:hover {
			transform: translateY(-2px);
			box-shadow: 0 4px 8px rgba(0,0,0,0.2);
		}
		/* 커스텀 스크롤바 스타일 */
		::-webkit-scrollbar {
			width: 8px;
		}
		::-webkit-scrollbar-track {
			background: #f1f1f1;
		}
		::-webkit-scrollbar-thumb {
			background: #888;
		}
		::-webkit-scrollbar-thumb:hover {
			background: #555;
		}
	</style>
</head>
<body>
<div class="info hidden">
	<c:set var="user" value="${user}" />
	<c:choose>
		<c:when test="${not empty user}">
			<a class="info_nickname" href="${ctx}/userMyPage.do?no=${user.no}">
					${user.nickname} (${user.name})
			</a>
		</c:when>
		<c:otherwise>
			로그인이 필요합니다
		</c:otherwise>
	</c:choose>
	<div class="info_cash"> 보유 캐시 : ${ user.cash } </div>
	<div class="info_notify"> 알림 </div>
	<button class="btns info_chat">채팅</button>
	<button class="btns info_pay">결제</button>
<c:if test="${user.deliver}">
	<button class="btns info_quick" onclick="location.href='${ctx}/quickMain.do?no=${user.no}'">퀵 서비스</button>
	</c:if>
	<c:choose>
		<c:when test="${not empty user}">
			<button class="btns info_logout" onclick="location.href='${ctx}/userLogOut.do'">로그아웃</button>
		</c:when>
		<c:otherwise>
			<button class="btns info_login" onclick="clickLogin()">로그인</button>
		</c:otherwise>
	</c:choose>
</div>
<div class="overlay hidden" onclick="unclickLogin()"></div>
<%@ include file="../user/kakaoLogin.jsp" %>
<%@ include file="./LoginModal.jsp" %>
<script>
	const $info = document.querySelector(".info");
	let clicked = false;
	function openInfo() {
		if(!clicked) {
			$info.classList.remove("hidden");
			clicked = true;
		} else {
			$info.classList.add("hidden");
			clicked = false;
		}
	}


</script>
</body>
</html>

