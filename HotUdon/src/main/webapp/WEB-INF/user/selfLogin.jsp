<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<c:set var="ctx" value="${pageContext.request.contextPath}"/>    
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	#table_login{
		width: 600px;
		height: 400px;
	}
	#table_login #id{
		width: 100%;
		height: 100%;
		box-sizing: border-box;
	}
	#table_login #pw{
		width: 100%;
		box-sizing: border-box;
	}
</style>
</head>
<body>
	<div align="center">
	<form action="${ ctx }/selfLogin.do" method="post"> 
		<table id="table_login" border="1">
			<tr height="100">
				<td align="center" colspan="2"> 
					<font size="6" color="gray"> 로그인 </font> 
				</td>
			</tr>
			<tr height="30">
				<!-- <td width="120" align="center"> 이메일 </td> -->
				<td> <input type="text" id="id" name="id" placeholder="Username" required /> </td>
			</tr>
			<tr height="30">
				<!-- <td width="120" align="center"> 패스워드 </td> -->
				<td> <input type="password" id="pw" name="pw" placeholder="Password" required /> </td>
			</tr>
			<tr height="40">
				<td align="center" colspan="2">
					<input type="submit" value="Sign In" />
				</td>
			</tr>
		</table>
		
	</form>
</div>
</body>
</html>