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
		width: 900px;
		height: 300px;
		display: flex;
		flex-direction: column;
	}
	.container{
		display: flex;
		width: 100%
	}
	.userImg_{
		align-items: center;	
		display: flex;	
		flex-direction: row;
		flex: 6;
		margin-left: 20px;
	}
	.nickname{
		font-size: 2em;
	}
	.btn_update{
		flex: 1;
		margin: auto;
		align-items: center;	
	}
	.btn_update button{
		padding: 10px;
	}
	
	.box{
		display: flex;
	}
	.cash,.status,.regDate{
		width: 33%;
		flax: 1;
		display: flex;
		flex-direction: column;
	}
	h3{
		flex: 1;
		font-size: 1.5em;
		margin: auto 10px;
     	align-items: center;
	}
	.mid{
		flex: 2;
		text-align: center;
		font-size: 1.7em;
		padding-top: 5px;
	}
	.mid:last-child{
		flex: 3;
	}
	.foot{
		flex: 1;
		text-align: right;
		margin: auto 10px;
	}
	.mypage img{
		height: 100px;
		width: 100px;
		border-radius: 50%;
	}
	.cash,.status{
		border-right: 1px solid black;
		height : 130px;
	}
	.mypage_menu{
		margin-left: 110px;
		list-style-type: none;
	}
	.mypage_menu a{
		font-size: 1.3em;
		display: block;
		margin-bottom: 3px;
	}
	
</style>

<body>
	<div class="mypage">
		<div class="container"> 
			<div class="userImg_"> <img src="./img/${ user.imgUrl }"> <p class="nickname">${ user.nickname }</p> </div>
			
			<div class="btn_update">
			<button onclick="location.href='${ctx}/userContent.do?no=${ user.no }'">개인정보 수정</button>
			</div>
		</div>
		<hr width="850px">
		<div class="box">
			<div class="cash">
				<h3>보유 캐시</h3> 
				<div class="mid"> ${ user.cash }원 </div>
				<a class="foot" href="#">상세내역 ></a>
			</div>
			<div class="status">
				<h3>회원 상태</h3> 
				<div class="mid"> 활동 중 </div>
				<a class="foot" href="#">상세내역 ></a>
			</div>
			<div class="regDate">
				<h3>가입 일자</h3> 
				<div class="mid"> ${ user.regDate } </div>
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
	<ul class="mypage_menu">
	<li> <a href="${ctx}/map.do"> - 내 동네 설정 </a></li>
	<li> <a href="${ctx}/userInfo.do"> - 판매 내역 </a></li>
	<li> <a href="${ctx}/userInfo.do"> - 구매 내역 </a></li>
	<li> <a href="${ctx}/userInfo.do"> - 라이더 신청 </a></li>
	<c:if test="${ user.id ne 'admin' }"> <li> <a href="${ctx}/userInfo.do"> - 탈퇴 하기 </a></li> </c:if>
	<c:if test="${ user.id eq 'admin' }"> <li> <a href="${ctx}/userList.do"> - 전체 회원 보기 </a></li> </c:if>
	</ul>
	
<%@ include file="../parts/footer.jsp" %>	
