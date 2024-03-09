<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<c:set var="ctx" value="${pageContext.request.contextPath}"/>    
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div align="center">
<form action="${ ctx }/selfJoin.do" method="post">
<table class="table table-bordered" border="1">
	<tr>	
		<td align="center" colspan="2"> 
			<font size="6" color="gray"> 회원가입 </font> 
		</td>
	</tr>
  <tr>
    <td>이메일</td>
    <td><input class="col-12 id" type="text" name="id"/>
	<input type="button" value="ID중복체크" id="checkId"/>    
    </td>
  </tr>
  <tr>
    <td>비밀번호</td>
    <td><input class="col-12 pw" type="password" name="pw"/></td>
  </tr>
  <tr>
    <td>비밀번호 확인</td>
    <td><input class="col-12 pw" type="password" name="pw1"/></td>
  </tr>
  <tr>
    <td>이름</td>
    <td><input class="col-12" type="text" name="name"/></td>
  </tr>
  <tr>
    <td>전화번호</td>
    <td><input class="col-12" type="text" name="phone"/></td>
  </tr>
  <tr>
    <td>닉네임</td>
    <td><input class="col-12" type="text" name="nickname"/></td>
  </tr>
  <tr>
  	
    <td colspan="2"> 
    <input type="checkbox" name="checkbox" value="check">
    뜨끈한 우동의 전체 <a onclick="#">이용약관</a>에 동의합니다.(필수)</td>
  </tr>
  
  <tr>
    <td colspan="2" align="center">
      <input type="submit" value="회원 가입" class="col-3 btn btn-primary" />
      <input type="reset" value="취소" class="col-3 btn btn-warning"/>
    </td>
  </tr>
</table>
</form>
</div>
</body>
</html>
