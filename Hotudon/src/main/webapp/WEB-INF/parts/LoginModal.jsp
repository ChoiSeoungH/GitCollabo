<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- //네이버 로그인  -->    
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.security.SecureRandom" %>
<%@ page import="java.math.BigInteger" %>
<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	#modal_log{
		margin-left: 30px;
	}
	.modal_td{
		border: none;
	}
	#login,#join{
		border: none;
		background-color: #fff;
		style: none;
	}
	.underBar{
		border-bottom: 2px solid skyblue;
		/* background-color: skyblue; */
	}
	#modal_join{
		display: block;
	}
	#modal_login{
		display: none;
	}
</style>
</head>
<body>
<div class="modal hidden">
	<br>
	
	<h3>뜨끈한 우동에서 중고거래 시작하기</h3>
	<H4>간편하게 가입하고 상품을 거래하세요</H4>
	<br>
	<table id="modal_log">
	<tr>
	<td class="modal_td login "> <button id="login" onclick="clickLoginBtn()"> 로그인</button> </td>
	<td class="modal_td join underBar"> <button id="join" onclick="clickJoinBtn()">회원가입</button> </td>
	</tr>
	</table>
	<br>
		<button class="btn kakao" onclick="kakaoLogin()"<%-- "location.href='${ctx}/kakaoLogin.do'" --%>>
			<svg xmlns="http://www.w3.org/2000/svg" width="21" height="21" fill="#3C1E1E" viewBox="0 0 21 21">
			<path fill="current" d="M10.5 3.217c4.514 0 8 2.708 8 6.004 0 3.758-4.045 6.184-8 5.892-1.321-.093-1.707-.17-2.101-.23-1.425.814-2.728 2.344-3.232 2.334-.325-.19.811-2.896.533-3.114-.347-.244-3.157-1.329-3.2-4.958 0-3.199 3.486-5.928 8-5.928Z"></path>
			</svg> 카카오로 시작하기 </button>
		<button class="btn naver" id="naverIdLogin_loginButton" onclick="naverLogin()<!-- javascript:void(0) -->"<%-- "location.href='${ctx}/naverLogin.do'" --%>> 
			<svg xmlns="http://www.w3.org/2000/svg" width="21" height="21" fill="none" viewBox="0 0 21 21">
			<path fill="#00C73C" d="M4 16.717h4.377V9.98l4.203 6.737H17v-13h-4.377v6.737l-4.16-6.737H4v13Z"></path>
	     	</svg> 네이버로 시작하기 </button>
		<button class="btn google" onclick="location.href='${ctx}/googleLogin.do'"> 
			<svg xmlns="http://www.w3.org/2000/svg" width="21" height="21" fill="none" viewBox="0 0 21 21">
			<path fill="#4285F4" d="M18.18 10.398c0-.567-.05-1.113-.145-1.636H10.5v3.094h4.306a3.68 3.68 0 0 1-1.597 2.415v2.007h2.586c1.512-1.393 2.385-3.443 2.385-5.88Z"></path>
	  		<path fill="#34A853" d="M10.5 18.216c2.16 0 3.97-.716 5.294-1.938l-2.585-2.007c-.717.48-1.633.763-2.71.763-2.083 0-3.847-1.407-4.476-3.298H3.351v2.073a7.997 7.997 0 0 0 7.149 4.407Z"></path>
			<path fill="#FBBC05" d="M6.024 11.738c-.16-.48-.251-.993-.251-1.52 0-.528.09-1.04.25-1.52V6.625H3.352a7.997 7.997 0 0 0-.851 3.593c0 1.29.31 2.512.85 3.592l2.674-2.072Z"></path>
			<path fill="#EA4335" d="M10.5 5.399c1.174 0 2.229.403 3.058 1.196L15.852 4.3c-1.385-1.29-3.196-2.083-5.352-2.083a7.997 7.997 0 0 0-7.15 4.407l2.673 2.073c.63-1.891 2.393-3.298 4.477-3.298Z"></path>
			</svg> 구글로 시작하기 </button>
		<br>	
	   
	<div id="modal_join">
	    <button class="btn email" onclick="location.href='${ctx}/selfJoin.do'" >
    	<svg stroke="currentColor" fill="currentColor" stroke-width="0" viewBox="0 0 16 16" class="text-sm sm:text-base me-1.5" height="1em" width="1em" xmlns="http://www.w3.org/2000/svg">
		<path fill-rule="evenodd" d="M3 14s-1 0-1-1 1-4 6-4 6 3 6 4-1 1-1 1H3zm5-6a3 3 0 100-6 3 3 0 000 6z" clip-rule="evenodd"></path>
		</svg> 이메일로 시작하기 </button>
	</div>
	<div id="modal_login">
	    <button class="btn email" onclick="location.href='${ctx}/selfLogin.do'" >
    	<svg stroke="currentColor" fill="currentColor" stroke-width="0" viewBox="0 0 16 16" class="text-sm sm:text-base me-1.5" height="1em" width="1em" xmlns="http://www.w3.org/2000/svg">
		<path fill-rule="evenodd" d="M3 14s-1 0-1-1 1-4 6-4 6 3 6 4-1 1-1 1H3zm5-6a3 3 0 100-6 3 3 0 000 6z" clip-rule="evenodd"></path>
		</svg> 이메일로 로그인하기 </button>
	</div>
	<br><hr width="350px"><br>	
	<p> 도움이 필요하시면 고객센터 또는 02-000-0000으로 문의 주시기 바랍니다.</p>	                                                                              
</div>

</body>
</html>

<script>
  const $btn = document.querySelector(".userImg");
  const $modal = document.querySelector(".modal");
  const $overlay = document.querySelector(".overlay");
		
	function clickLogin(){
		$modal.classList.remove("hidden");
		$overlay.classList.remove("hidden");
	}
	 function unclickLogin(){
	    $modal.classList.add("hidden");
	    $overlay.classList.add("hidden");
	    $cash.classList.add("hidden");
	 }
	let $kakao = document.querySelector(".kakao");			  
	let $naver = document.querySelector(".naver");			  
	let $google = document.querySelector(".google");			  
	let $email = document.querySelector(".email");	
	let $join = document.querySelector(".join"); 	
	let $login = document.querySelector(".login"); 	
	
	function clickLoginBtn(){
 		$kakao.innerHTML = '<svg xmlns="http://www.w3.org/2000/svg" width="21" height="21" fill="#3C1E1E" viewBox="0 0 21 21"><path fill="current" d="M10.5 3.217c4.514 0 8 2.708 8 6.004 0 3.758-4.045 6.184-8 5.892-1.321-.093-1.707-.17-2.101-.23-1.425.814-2.728 2.344-3.232 2.334-.325-.19.811-2.896.533-3.114-.347-.244-3.157-1.329-3.2-4.958 0-3.199 3.486-5.928 8-5.928Z"></path></svg>카카오로 로그인하기';
		$naver.innerHTML = '<svg xmlns="http://www.w3.org/2000/svg" width="21" height="21" fill="none" viewBox="0 0 21 21"><path fill="#00C73C" d="M4 16.717h4.377V9.98l4.203 6.737H17v-13h-4.377v6.737l-4.16-6.737H4v13Z"></path></svg> 네이버로 로그인하기';
		$google.innerHTML = '<svg xmlns="http://www.w3.org/2000/svg" width="21" height="21" fill="none" viewBox="0 0 21 21"><path fill="#4285F4" d="M18.18 10.398c0-.567-.05-1.113-.145-1.636H10.5v3.094h4.306a3.68 3.68 0 0 1-1.597 2.415v2.007h2.586c1.512-1.393 2.385-3.443 2.385-5.88Z"></path><path fill="#34A853" d="M10.5 18.216c2.16 0 3.97-.716 5.294-1.938l-2.585-2.007c-.717.48-1.633.763-2.71.763-2.083 0-3.847-1.407-4.476-3.298H3.351v2.073a7.997 7.997 0 0 0 7.149 4.407Z"></path><path fill="#FBBC05" d="M6.024 11.738c-.16-.48-.251-.993-.251-1.52 0-.528.09-1.04.25-1.52V6.625H3.352a7.997 7.997 0 0 0-.851 3.593c0 1.29.31 2.512.85 3.592l2.674-2.072Z"></path><path fill="#EA4335" d="M10.5 5.399c1.174 0 2.229.403 3.058 1.196L15.852 4.3c-1.385-1.29-3.196-2.083-5.352-2.083a7.997 7.997 0 0 0-7.15 4.407l2.673 2.073c.63-1.891 2.393-3.298 4.477-3.298Z"></path></svg> 구글로 로그인하기';
		$email.innerHTML = '<svg stroke="currentColor" fill="currentColor" stroke-width="0" viewBox="0 0 16 16" class="text-sm sm:text-base me-1.5" height="1em" width="1em" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" d="M3 14s-1 0-1-1 1-4 6-4 6 3 6 4-1 1-1 1H3zm5-6a3 3 0 100-6 3 3 0 000 6z" clip-rule="evenodd"></path></svg> 이메일로 로그인하기';
  		$join.classList.remove("underBar");
  		$login.classList.add("underBar");
  		document.getElementById("modal_join").style.display = "none";
  		document.getElementById("modal_login").style.display = "block";
	}
	
	function clickJoinBtn(){
 		$kakao.innerHTML = '<svg xmlns="http://www.w3.org/2000/svg" width="21" height="21" fill="#3C1E1E" viewBox="0 0 21 21"><path fill="current" d="M10.5 3.217c4.514 0 8 2.708 8 6.004 0 3.758-4.045 6.184-8 5.892-1.321-.093-1.707-.17-2.101-.23-1.425.814-2.728 2.344-3.232 2.334-.325-.19.811-2.896.533-3.114-.347-.244-3.157-1.329-3.2-4.958 0-3.199 3.486-5.928 8-5.928Z"></path></svg> 카카오로 시작하기';
		$naver.innerHTML = '<svg xmlns="http://www.w3.org/2000/svg" width="21" height="21" fill="none" viewBox="0 0 21 21"><path fill="#00C73C" d="M4 16.717h4.377V9.98l4.203 6.737H17v-13h-4.377v6.737l-4.16-6.737H4v13Z"></path></svg> 네이버로 시작하기';
		$google.innerHTML = '<svg xmlns="http://www.w3.org/2000/svg" width="21" height="21" fill="none" viewBox="0 0 21 21"><path fill="#4285F4" d="M18.18 10.398c0-.567-.05-1.113-.145-1.636H10.5v3.094h4.306a3.68 3.68 0 0 1-1.597 2.415v2.007h2.586c1.512-1.393 2.385-3.443 2.385-5.88Z"></path><path fill="#34A853" d="M10.5 18.216c2.16 0 3.97-.716 5.294-1.938l-2.585-2.007c-.717.48-1.633.763-2.71.763-2.083 0-3.847-1.407-4.476-3.298H3.351v2.073a7.997 7.997 0 0 0 7.149 4.407Z"></path><path fill="#FBBC05" d="M6.024 11.738c-.16-.48-.251-.993-.251-1.52 0-.528.09-1.04.25-1.52V6.625H3.352a7.997 7.997 0 0 0-.851 3.593c0 1.29.31 2.512.85 3.592l2.674-2.072Z"></path><path fill="#EA4335" d="M10.5 5.399c1.174 0 2.229.403 3.058 1.196L15.852 4.3c-1.385-1.29-3.196-2.083-5.352-2.083a7.997 7.997 0 0 0-7.15 4.407l2.673 2.073c.63-1.891 2.393-3.298 4.477-3.298Z"></path></svg> 구글로 시작하기';
		$email.innerHTML = '<svg stroke="currentColor" fill="currentColor" stroke-width="0" viewBox="0 0 16 16" class="text-sm sm:text-base me-1.5" height="1em" width="1em" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" d="M3 14s-1 0-1-1 1-4 6-4 6 3 6 4-1 1-1 1H3zm5-6a3 3 0 100-6 3 3 0 000 6z" clip-rule="evenodd"></path></svg> 이메일로 시작하기';
  		$join.classList.add("underBar");
  		$login.classList.remove("underBar");
  		document.getElementById("modal_join").style.display = "block";
  		document.getElementById("modal_login").style.display = "none";
	}
	function naverLogin(){
		fetch("naverLogin.do", {
			method : "POST",
			headers : {"Content-Type": "application/x-www-form-urlencoded; charset=UTF-8",},
			/* body : "id="+id.value.trim(), */
		})
		
		.then(response => response.text())
		.then(getResult)
		.catch(error => console.log(error));
		
		function getResult(apiURL) {
			location.href=apiURL;
		}
	}
</script>
