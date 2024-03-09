<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
    #header{
    	display: flex;
    	justify-content: space-between;
    }
	#header #logo{
		width: 10%;
		cursor: pointer;
	}
	#header #search{
		width: 80%;
    	display: flex;
		justify-content: center;
		align-items: center;
	}
	#header #search .search{
		width: 500px;
		height: 50px;
    	text-align: center;
		border-radius: 25px;
		line-height: 100px;
	}
	#header #userImg{
		width: 10%;
		heigth: 100px;
		cursor: pointer;
	}
    #logo img{
    	height: 100px;
    }
    #userImg img{
    	height: 100px;
    	width: 100px;
    	border-radius: 50%;
    	
    }
</style>
</head>
<body>

 	<header id="header">
		<div id="logo" onclick="location.href='${ctx}/main.do'"><img src="./img/ulogo.png"> </div>
		<div id="search">
			<input type="text" class="search" name="search" placeholder="검색어를 입력하세요">
		</div>
		<div id="userImg"> 
			<c:if test="${ user eq null }"> <a onclick="clickLogin()"> <img class="userImg" src="https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg" ></a></c:if>
			<c:if test="${ user ne null }"> <a onclick="openInfo()"> <img class="userImg" src="./img/${ user.imgUrl }" ></a></c:if>
		</div>
 	</header>


<div class="overlay hidden" onclick="unclickLogin()"></div>
<%@ include file="./LoginModal.jsp" %>
<%@ include file="../user/kakaoLogin.jsp" %>
