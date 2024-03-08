<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../Main.jsp" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
  <style>
    #wrap{
      width: 800px;
      height: 200px;
      margin: auto;
    }
    #container{
      width: 800px;
      height: 170px;
      border: 1px solid black;
      margin: auto;
    }
    
    #container h2{
      margin: 10px;
      text-align: left;
    }
    #check_id{
      display: flex;
      width: 50%;
      margin: 20px;
    }
    #check_id .id{
      width: 30%;
      text-align: left;
    }
    #check_id .show_id{
      width: 70%;
      text-align: left;
    }
    #check_pw{
      align-items: center;
      display: flex;
      width: 50%;
      margin: 20px;
    }
    #check_pw .pw{
      width: 30%;
      text-align: left;
    }
    #check_pw #input_pw{
      width: 20%;
      text-align: left;
      margin-right: 10px;
      border: none;
      border-bottom: 1px solid skyblue;
    }
    #submit{
      width: 70px;
      height: 30px;
      border: none;
      border-radius: 5px;
      text-align: center;
    }
    .sub_script{
      margin-left: 20px;
      font-size: 0.8em;
      margin-top: 0;
    }
  </style>
</head>
<body>
  <form id="deleteForm" action="${ctx}/userDelete.do" method="post">
    <div id="wrap">
      <h2 id="header_h2"> 비밀번호 입력 </h2><br>
      <div id="container">
        <div id="check_id">
          <div class="id">아이디</div>
          <div class="show_id">${ user.id }</div>
        </div>
        <div id="check_pw">
          <div class="pw">패스워드</div>
          <input id="input_pw" type="password" name="pw" required />
          <input type="button" id="submit" value="확인" onclick="submitForm()"/>
        </div><br>
        <p class="sub_script"> 개인정보 변경을 원하실 경우, 본인확인을 위해 비밀번호를 한 번 더 입력해 주세요</ㅔ>
        </div>
      </div>
  </form>
  <%@ include file="../parts/footer.jsp" %>
</body>
</html>
<script>
function submitForm() {
    
	let inputPw = document.getElementById("input_pw").value;
    let userPw = "${user.pw}";
    let userNo = "${user.no}";

    if (inputPw === userPw) {
    	location.href = "${ctx}/userDelete.do?no="+userNo;
        //document.getElementById("deleteForm").submit();
    } else {
        alert("비밀번호가 일치하지 않습니다.");
    }
}
</script>