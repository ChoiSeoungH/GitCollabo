<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../Main.jsp" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	#table_join{
		width: 370px;
	}
	#table_join td{
		height: 40px;
	}
	#table_join .input{
		width: 100%;
		height: 100%;
		box-sizing: border-box;
	}
	#table_join #tr_id{
		
	}
	#table_join .input_id{
		width: 73%;
		height: 100%;
		box-sizing: border-box;
		font-size: 1.2em;
	}
	#table_join #checkId{
		width: 25%;
		height: 100%;
		box-sizing: border-box;
		border: none;
	}
	#table_join .join_btn{
		width: 100%;
		height: 100%;
		box-sizing: border-box;
	}
</style>
</head>
<body>
<div align="center">
<form action="${ ctx }/selfJoin.do" method="post">
<table id="table_join">
	<tr id="tr_id">	
		<td align="center" colspan="2"> 
			<font size="6" color="gray"> 회원가입 </font> 
		</td>
	</tr>
  <tr><td>이메일</td></tr>
  <tr><td><input class="input_id id" type="text" name="id" placeholder="test@test.com"/>
	<input type="button" value="ID중복체크" id="checkId"/>    
    </td>
  </tr>
  <tr><td>비밀번호</td></tr>
  <tr><td><input class="input pw" type="password" name="pw"/></td></tr>
  <tr><td>비밀번호 확인</td></tr>
  <tr><td><input class="input pw" type="password" name="pw1"/></td></tr>
  <tr><td>이름</td></tr>
  <tr><td><input class="input" type="text" name="name"/></td></tr>
  <tr><td>전화번호</td></tr>
  <tr><td><input class="input" type="text" name="phone"/></td></tr>
  <tr><td>닉네임</td></tr>
  <tr><td><input class="input" type="text" name="nickname"/></td></tr>
  <tr>
    <td> 
    <input id="checkbox" type="checkbox" name="checkbox" value="check">
    <label for="checkbox">뜨끈한 우동의 전체 <a onclick="#">이용약관</a>에 동의합니다.(필수)</label></td>
  </tr>
  
  <tr>
    <td align="center">
      <input type="button" value="회원 가입" class="join_btn" onclick="validCheck(form)"/>
      <!-- <input type="reset" value="취소" class="col-3 btn btn-warning"/> -->
    </td>
  </tr>
</table>
</form>
</div>
<%@ include file="../parts/footer.jsp" %>	
</body>
</html>

<script type="text/javascript">
let check =0;
let checkbox = document.getElementById("myCheckbox");

function validCheck(form) {
	if(!form.id.value.trim()){
		alert("아이디를 입력해주세요");
		form.id.focus();
		return false;
	}
	if(!form.pw.value.trim()){
		alert("비밀번호를 입력해주세요");
		form.pw1.focus();
		return false;
	}
	if(!form.pw1.value.trim()){
		alert("비밀번호를 입력해주세요");
		form.pw2.focus();
		return false;
	}
	
	if(form.pw.value != form.pw1.value){
		alert("입력하신 두 비밀번호가 일치하지 않습니다.");
		form.pw2.focus();
		return false;
	}
	
	if(!form.name.value.trim()){
		alert("이름을 입력해주세요");
		form.name.focus();
		return false;
	}
	if(!form.phone.value.match(/01+\d{1}-\d{3,4}-\d{4}/)){
		alert("전화번호 형식에 맞게 입력하세요");
		form.phone.value = "010-0000-0000";
		form.phone.focus();
		return false;
	}
	
	if(!form.checkbox.checked){
		alert("이용약관에 동의하여 주십시오.");
		return false;
	} 
	
	if(check == 0){
		alert("아이디 중복체크 필요");
		return false;
	} else if(check == -1){
		alert("아이디 중복체크 필요");
		return false;
	}
	form.submit();
}

	document.querySelector('.join_btn').addEventListener('click',()=>{
		let id = document.querySelector('.id');
		//id.style.borber = "";
		id.removeAttribute("readonly");
		id.removeAttribute("style");
		check=0;
	})
	
	document.querySelector('#checkId').addEventListener('click',()=>{
		let id = document.querySelector('.id');
		
		if(!id.value.trim()){
			alert("아이디를 입력해주세요");
			id.value = "";
			id.focus();
			return false;
		}
		
		if(!id.value.match(/([\w\.]+)@([\w\.]+)\.(\w+)/g)){
			alert("이메일 형식에 맞게 입력하세요");
			id.value = "test@test.com";
			id.focus();
			return false;
		}
	
		fetch("vaildIdAjax.do", {
			method : "POST",
			headers : {"Content-Type": "application/x-www-form-urlencoded; charset=UTF-8",},
			body : "id="+id.value.trim(),
		})
		
		.then(response => response.text())
		.then(getResult)
		.catch(error => console.log(error));
	});
	
	function getResult(data) {
		console.log(data);
		if(data == "valid"){
			check = 1;
			alert("사용 가능한 아이디입니다.");
			document.querySelector('.pw').focus();
			document.querySelector('.id').style.border = "3px blue solid";
			document.querySelector('.id').setAttribute("readonly","readonly");
		}
		else if(data == "notValid"){
			check = -1;
			alert("중복된 아이디입니다.");
			document.querySelector('.id').value = "";
			document.querySelector('.id').focus();
			document.querySelector('.id').style.border = "3px red solid";
		}
	}
	
	
</script>