<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../Main.jsp" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	#table_login{
		width: 500px;
		height: 400px;
	}
	#table_login #id{
		width: 100%;
		height: 100%;
		box-sizing: border-box;
		font-size: 1.3em;
	}
	#table_login #pw{
		width: 100%;
		height: 100%;
		box-sizing: border-box;
		font-size: 1.3em;
	}
	#table_login #submit{
		width: 100%;
		height: 100%;
		box-sizing: border-box;
		font-size: 1.3em;
		border: none;	
	}
	#table_login #submit:hover{
		background-color: #ccc;
	}
</style>
</head>
<body>
	<div align="center">
	<form action="${ ctx }/selfLogin.do" method="post"> 
		<table id="table_login">
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
			<tr height="30">
				<td align="center" colspan="2">
					<input type="submit" id="submit" value="Sign In" />
				</td>
			</tr>
		</table>
		
	</form>
</div>
<%@ include file="../parts/footer.jsp" %>
</body>
</html>