<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../Main.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>로그인 페이지</title>
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
	<style>

		.login-container {
			padding: 20px;
			background: #ffffff;
			border: 1px solid #dee2e6;
			border-radius: .25rem;
			box-shadow: 0 4px 6px rgba(0,0,0,.1);
			align-self: center;
			margin: auto;
			width: 600px;
		}
		.login-container h2 {
			color: #495057;
		}
		.form-control {
			font-size: 1.3em;
			margin-bottom: 20px;
		}
		.btn-login {
			font-size: 1.3em;
			padding: 10px;
			width: 100%;
			background-color: #007bff;
			color: white;
			border: none;
			cursor: pointer;
		}
		.btn-login:hover {
			background-color: #0056b3;
		}
	</style>
</head>
<body>
<div class="login-container">
	<form action="${ ctx }/selfLogin.do" method="post">
		<h2 class="text-center">로그인</h2>
		<input type="text" id="id" name="id" class="form-control" placeholder="Username" required autofocus>
		<input type="password" id="pw" name="pw" class="form-control" placeholder="Password" required>
		<button type="submit" class="btn btn-primary btn-login">로그인</button>
	</form>
</div>
<%@ include file="../parts/footer.jsp" %>
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
