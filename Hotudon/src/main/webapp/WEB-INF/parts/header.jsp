<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>웹 페이지 제목</title>
	<!-- 부트스트랩 CSS -->
	<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
	<!-- 부트스트랩 JS -->
	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	<style>
		#header {
			display: flex;
			justify-content: space-between;
			align-items: center;
			padding: 0 10px;
			margin-bottom: 20px; /* 헤더 아래 여백 추가 */
		}
		#logo img {
			width: 120px; /* 로고의 폭을 고정 크기로 설정 */
			height: auto; /* 높이는 자동으로 설정하여 비율 유지 */
			cursor: pointer;
			transition: transform 0.3s ease;
		}
		#logo img:hover {
			transform: scale(1.1);
		}
		#search .search input {
			width: 100%;
			border: none;
			border-radius: 25px;
			padding: 10px;
			font-size: 16px; /* 검색창 폰트 크기 조정 */
		}
		#search .search input:focus {
			outline: none;
			box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
			transform: scale(1.05);
		}
		#userImg img {
			width: 80px; /* 사용자 이미지의 폭 설정 */
			height: 80px; /* 사용자 이미지의 높이 설정 */
			border-radius: 50%; /* 원형으로 표시 */
			cursor: pointer;
			transition: transform 0.3s ease;
		}
		#userImg img:hover {
			transform: scale(1.1);
		}
	</style>
</head>
<body>

<header id="header">
	<div id="logo" onclick="location.href='${ctx}/main.do'">
		<img src="./img/ulogo.png" alt="Logo">
	</div>
	<div id="search" class="flex-grow-1"> <!-- 검색창 너비를 최대로 확장 -->
		<div class="search">
			<input type="text" placeholder="검색어 입력" name="query">
		</div>
	</div>
	<div id="userImg" onclick="openInfo()">
		<c:choose>
			<c:when test="${ user eq null }">
				<img src="https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg" alt="No Image Available">
			</c:when>
			<c:otherwise>
				<img src="./img/${ user.imgUrl }" alt="${ user.nickname }">
			</c:otherwise>
		</c:choose>
	</div>
</header>

