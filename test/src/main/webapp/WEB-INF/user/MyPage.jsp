<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../Main.jsp" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
	.mypage{
		border: 2px solid black;
		border-radius: 10px;
		margin: 0px auto 30px; 
		width: 1000px;
		height: 300px;
		display: flex;
		flex-direction: column;
	}
	.container{
		display: flex;
	}
	.box{
		display: flex;
		
	}
	.cash,.status,.regDate{
		flax: 1;
	}
	
	.mypage img{
		height: 100px;
		width: 100px;
		border-radius: 50%;
	}
	a{
		margin-left: 100px;
		margin-bottom: 20px;
	}
</style>

<body>
	<div class="mypage">
		<div class="container"> 
			<div class="userImg"> <img src="./img/seolak.png"> </div>
			<div class="nickname"> 닉네임 </div>
			<div class="btn">
			<button onclick="location.href='/${ctx}/userContent.do'">개인정보 수정</button>
			</div>
		</div>
		<hr width="900px">
		<div class="box">
			<div class="cash">
				<h3>캐시</h3> 
				<div > 10000원 </div>
				<p> <a>상세내역 ></a> </p>
			</div>
			<div class="status">
				<h3>회원 상태</h3> 
				<div > 활동 중 </div>
				<p> <a>상세내역 ></a> </p>
			</div>
			<div class="regDate">
				<h3>가입 일자</h3> 
				<div > 2024-01-20 </div>
			</div>
		</div>
		<!-- <table border="1">
		<tr>
		<td colspan="2"> <img src="./img/seolak.png"> 닉네임 </td>
		<td>
		</td>
		</tr>
		<tr>
		<td> 캐시 </td>
		<td> 회원 상태 </td>
		<td> 가입 일자 </td>
		</tr>
		</table> -->
	</div>
	<a href="${ctx}/userInfo.do"> - 내 동네 설정 </a><br>
	<a href="${ctx}/userInfo.do"> - 키워드 설정 </a><br>
	<a href="${ctx}/userInfo.do"> - 판매 내역 </a><br>
	<a href="${ctx}/userInfo.do"> - 구매 내역 </a><br>
	<a href="${ctx}/userInfo.do"> - 탈퇴 하기 </a><br>
	
<%@ include file="../parts/footer.jsp" %>	
</body>
</html>