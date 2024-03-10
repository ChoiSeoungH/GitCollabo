<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../Main.jsp" %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>마이페이지</title>
	<!-- 부트스트랩 CSS -->
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
	<!-- 부트스트랩 JS -->
	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.2/dist/umd/popper.min.js"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<body>
<div class="container mt-5">
	<div class="card">
		<div class="card-body">
			<div class="row">
				<div class="col-md-4 text-center">
					<img src="./img/${user.imgUrl}" class="img-fluid rounded-circle" alt="사용자 이미지">
					<h2 class="mt-3">${user.nickname}</h2>
				</div>
				<div class="col-md-8">
					<div class="row">
						<div class="col-sm-4 text-center">
							<h3>보유 캐시</h3>
							<p class="lead">${user.cash}원</p>
							<a href="#" class="btn btn-link" onclick="cashModal()">상세내역 ></a>
						</div>
						<div class="col-sm-4 text-center">
							<h3>회원 상태</h3>
							<p class="lead">
								<c:choose>
									<c:when test="${user.status ne '4'}">활동 중</c:when>
									<c:otherwise>활동 제한</c:otherwise>
								</c:choose>
							</p>
							<a href="#" class="btn btn-link">상세내역 ></a>
						</div>
						<div class="col-sm-4 text-center">
							<h3>가입 일자</h3>
							<p class="lead">${user.regDate}</p>
						</div>
					</div>
					<div class="mt-4">
						<a href="${ctx}/map.do" class="btn btn-primary">내 동네 설정</a>
						<a href="${ctx}/purHistory.do?no=${user.no}&myPage=1" class="btn btn-secondary">판매 내역</a>
						<a href="${ctx}/purHistory.do?no=${user.no}&myPage=2" class="btn btn-success">구매 내역</a>
						<a href="${ctx}/productAdd.do?no=${user.no}" class="btn btn-info">물건 등록</a>
						<a href="${ctx}/productList.do?no=${user.no}" class="btn btn-warning">물건 구매하기</a>
						<c:if test="${user.id ne 'admin'}">
							<a href="#" onclick="checkCash()" class="btn btn-danger">탈퇴하기</a>
						</c:if>
						<c:if test="${user.id eq 'admin'}">
							<a href="${ctx}/userList.do" class="btn btn-dark">전체 회원 보기</a>
						</c:if>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

</body>
</html>

<%@ include file="./cashModal.jsp" %>	
<%@ include file="../parts/footer.jsp" %>
<script>
	function checkCash() {
	    // user.cash 값을 가져와서 정수로 변환합니다.
	    let cash = parseInt("${user.cash}");
	    let SNSPw = "${user.pw}";
	    let userNo = parseInt("${user.no}");
	    
	    if (cash > 0) {
	        alert("캐시 잔액이 없을 경우에만 회원 탈퇴 가능합니다.");
	    } else {
			if(SNSPw === 'SNSPw'){
				if(window.confirm("탈퇴 하시겠습니까?")){
					kakaoLogout();
					location.href = "${ctx}/userDelete.do?no="+userNo;
				}
			} else{
		    	location.href = "${ctx}/userDelete.do";
			}
	    }
	}

	function cashModal() {
		// 모달 창을 표시합니다.
		$('#modalCash').modal('show');
	}
</script>
