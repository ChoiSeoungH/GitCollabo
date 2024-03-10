<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../Main.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>사용자 관리</title>
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>
	<script src="https://kit.fontawesome.com/a076d05399.js"></script>
	<style>
		.userList {
			margin: 20px auto;
			width: 100%;
			font-size: 12px;
		}
		th {
			background-color: #007bff;
			color: #ffffff;
			border-radius: 3px;
			padding: 10px 0;
		}
		#penalty {
			width: 60px;
			border: 1px solid #ced4da;
			border-radius: .25rem;
			text-align: center;
			font-size: 1em;
			padding: .375rem .75rem;
		}
		td {
			vertical-align: middle;
			text-align: center;
			border-top: 1px solid #dee2e6;
			padding: .75rem;
		}
		.btn-update {
			color: #fff;
			background-color: #007bff;
			border-color: #007bff;
		}
		.btn-update:hover {
			color: #fff;
			background-color: #0056b3;
			border-color: #0056b3;
		}
		/*.animate-on-hover:hover {*/
		/*	animation: pulse 1s;*/
		/*	cursor: pointer;*/
		/*}*/

	</style>
</head>
<body>
<div class="container userList animate__animated animate__fadeInUp">
	<h2 class="text-center mb-4 ">사용자 관리</h2>
	<form action="" id="form">
		<table align="center" class="table table-hover table-striped table-responsive-md">
			<thead class="thead-dark">
			<tr>
				<th>회원 번호</th>
				<th>ID</th>
				<th>이름</th>
				<th>닉네임</th>
				<th>캐시</th>
				<th>전화번호</th>
				<th>가입 날짜</th>
				<th>주소</th>
				<th>패널티</th>
				<th>라이더 신청</th>
				<th>상태</th>
				<th>수정</th>
			</tr>
			</thead>
			<tbody>
			<c:forEach var="user" items="${ list }" varStatus="i">
				<tr class="animate-on-hover">
					<td>${ user.no }</td>
					<td>${ user.id eq 'SNSPw' ? 'SNS 로그인 사용자' : user.id }</td>
					<td>${ user.name }</td>
					<td>${ user.nickname }</td>
					<td>${ user.cash }</td>
					<td>${ user.phone }</td>
					<td>${ user.regDate }</td>
					<td>${ user.location }</td>
					<td>
						<input type="number" name="penalty" id="penalty" value="${ user.penalty }" min="0" class="form-control"/>
					</td>
					<td>${ user.deliver ? '신청함' : '신청안함' }</td>
					<td>${ user.status ne '4' ? '활동중' : '활동제한' }</td>
					<td>
						<button type="button" class="btn btn-update" onclick="penaltyUpdate(${user.no})"><i class="fas fa-edit"></i> 수정</button>
					</td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
	</form>
</div>
<%@ include file="../parts/footer.jsp" %>
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<script>
	function penaltyUpdate(no) {
		const penalty = document.querySelector('tr[data-no="' + no + '"] input[name="penalty"]').value;
		fetch("userPenalty.do", {
			method: "POST",
			headers: {
				"Content-Type": "application/x-www-form-urlencoded; charset=UTF-8",
			},
			body: "no=" + no + "&penalty=" + penalty,
		})
				.then(response => response.text())
				.then(text => console.log(text))
				.catch(error => console.error('Error:', error));
	}
</script>
</body>
</html>
