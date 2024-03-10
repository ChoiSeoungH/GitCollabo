<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>상품추가하기</title>
	<!-- 부트스트랩 CSS 추가 -->
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
	<style>
		.img-btn {
			width: 30px;
			height: 30px;
			border-radius: 50%;
			border: none;
			background-color: #808080;
			cursor: pointer;
		}
		.preview-container {
			display: flex;
			flex-direction: column;
			align-items: center;
		}
		#previewImg > img {
			width: 250px;
			height: 300px;
			margin-bottom: 10px;
			display: none; /* 기본적으로 숨김 처리 */
		}
		#previewImg > img.active {
			display: block; /* 활성화 시 보여짐 */
		}
		.form-group label {
			font-weight: bold; /* 라벨을 더 강조 */
		}
		.highlighted-input {
			background-color: #f0f0f0; /* 입력 필드 배경색 */
			border: 1px solid #007bff; /* 테두리 색상 */
		}
		.form-control:focus {
			border-color: #007bff; /* 포커스 시 테두리 색상 변경 */
			box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.25); /* 포커스 시 그림자 효과 */
		}
		/* 추가적인 CSS 스타일링 및 애니메이션 효과 */
		.animated-input:hover {
			background-color: #e9ecef;
			transition: background-color 0.3s;
		}
	</style>
</head>
<body>
<div class="container mt-5">
	<div class="row">
		<div class="col-md-4 preview-container">
			<div id="previewImg">
				<img alt="" id="preview1" class="active">
				<img alt="" id="preview2">
				<img alt="" id="preview3">
			</div>
			<div>
				<button type="button" class="img-btn" onclick="changePreviewIds(['preview1'])"></button>
				<button type="button" class="img-btn" onclick="changePreviewIds(['preview2'])"></button>
				<button type="button" class="img-btn" onclick="changePreviewIds(['preview3'])"></button>
			</div>
		</div>
		<div class="col-md-8">
			<form action="${ctx}/productAdd.do" enctype="multipart/form-data" method="post" class="needs-validation" novalidate>
				<input type="hidden" name="no" value="${user.no}">
				<input type="hidden" name="sellLocation" value="${user.location}">
				<!-- 폼 필드들 -->
				<div class="form-group">
					<label for="productName">상품제목</label>
					<input type="text" class="form-control highlighted-input" id="productName" name="productName" required>
				</div>

				<div class="form-group">
					<label for="productPrice">상품가격</label>
					<input type="number" class="form-control highlighted-input" id="productPrice" name="productPrice" min="1000" required>
				</div>

				<div class="form-group">
					<label>거래방법</label>
					<div>
						<div class="form-check form-check-inline">
							<input class="form-check-input highlighted-input" type="radio" name="method" id="direct" value="0" required>
							<label class="form-check-label" for="direct">직거래</label>
						</div>
						<div class="form-check form-check-inline">
							<input class="form-check-input highlighted-input" type="radio" name="method" id="parcel" value="1">
							<label class="form-check-label" for="parcel">택배</label>
						</div>
						<div class="form-check form-check-inline">
							<input class="form-check-input highlighted-input" type="radio" name="method" id="quick" value="2">
							<label class="form-check-label" for="quick">퀵서비스</label>
						</div>
						<div class="form-check form-check-inline">
							<input class="form-check-input highlighted-input" type="radio" name="method" id="noMatter" value="3">
							<label class="form-check-label" for="noMatter">상관없음</label>
						</div>
					</div>
				</div>

				<div class="form-group">
					<label>경매여부</label>
					<div>
						<div class="form-check form-check-inline">
							<input class="form-check-input highlighted-input" type="radio" name="auction" id="normalSale" value="0" required>
							<label class="form-check-label" for="normalSale">일반판매</label>
						</div>
						<div class="form-check form-check-inline">
							<input class="form-check-input highlighted-input" type="radio" name="auction" id="auctionSale" value="1">
							<label class="form-check-label" for="auctionSale">경매판매</label>
						</div>
					</div>
				</div>

				<div class="form-group">
					<label>상품 카테고리</label>
					<div>
						<div class="form-check form-check-inline">
							<input class="form-check-input highlighted-input" type="radio" name="category" id="digital" value="1" required>
							<label class="form-check-label" for="digital">디지털</label>
						</div>
						<div class="form-check form-check-inline">
							<input class="form-check-input highlighted-input" type="radio" name="category" id="clothes" value="2">
							<label class="form-check-label" for="clothes">의류</label>
						</div>
						<div class="form-check form-check-inline">
							<input class="form-check-input highlighted-input" type="radio" name="category" id="furniture" value="3">
							<label class="form-check-label" for="furniture">가구</label>
						</div>
						<div class="form-check form-check-inline">
							<input class="form-check-input highlighted-input" type="radio" name="category" id="etc" value="4">
							<label class="form-check-label" for="etc">기타</label>
						</div>
					</div>
				</div>

				<div class="form-group">
					<label for="fileInput">다중 파일(최대3개) 선택:</label>
					<input type="file" class="form-control-file highlighted-input" id="fileInput" name="files[]" accept="image/*" onchange="loadFiles(this)" multiple>
				</div>

				<div class="form-group">
					<label for="productContent">상품정보</label>
					<textarea class="form-control highlighted-input" id="productContent" name="productContent" rows="5" required></textarea>
				</div>

				<div class="text-center">
					<button type="button" class="btn btn-primary" onclick="validCheck(form)">등록하기</button>
					<button type="button" class="btn btn-secondary" onclick="location.href='${ctx}/main.do'">메인으로</button>
				</div>
			</form>
		</div>
	</div>
</div>
<!-- 부트스트랩 JS 추가 -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.2/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script type="text/javascript">
	var previewIds = ['preview1', 'preview2', 'preview3'];
	var currentPreviewIndex = 0;

	function loadFiles(input) {
		var files = input.files;
		var maxFiles = parseInt(input.getAttribute('max'), 10);

		if (files.length > maxFiles) {
			alert('최대 ' + maxFiles + '개의 파일만 업로드할 수 있습니다.');
			input.value = ''; // 파일 선택 초기화
			return;
		}

		previewIds.forEach((id, index) => {
			if (index < files.length) {
				var reader = new FileReader();
				reader.onload = function (e) {
					document.getElementById(id).src = e.target.result;
					// document.getElementById(id).classList.add('active');
				};
				reader.readAsDataURL(files[index]);
			} else {
				document.getElementById(id).classList.remove('active');
			}
		});
	}

	function changePreviewIds(newIds) {
		previewIds.forEach(id => {
			document.getElementById(id).classList.remove('active');
		});

		previewIds = newIds;

		previewIds.forEach(id => {
			document.getElementById(id).classList.add('active');
		});
	}
</script>
</body>
</html>
<script>
	const userLocation = '${user.location}';
	function validCheck(form) {
		if (!form.productName.value.trim()) {
			alert("상품 이름을 입력하세요")
			form.productName.focus();
			return false;
		}
		if (!form.productPrice.value.trim()) {
			alert("상품 가격을 입력하세요")
			form.productPrice.focus();
			return false;
		}
		if (!form.method.value) {
			alert("거래방법을 선택하세요");
			form.method.focus();
			return false;

		}
		if (!form.auction.value) {
			alert("판매방법을 선택하세요");
			form.auction.focus();
			return false;
		}
		if (!form.category.value) {
			alert("카테고리를 선택하세요");
			form.category.focus();
			return false;
		}
		if (!form.productContent.value.trim()) {
			alert("상품 내용을 입력해주세요");
			form.productContent.focus();
			return false;
		}
		if (Number(form.productPrice.value.trim()) < 1000) {
			alert("상품 가격을 1000원 이상 입력해주세요");
			form.productPrice.focus();
			return false;
		}
		 	if(!userLocation.trim()){
        alert("먼저 위치설정을 해주세요");
        return false;
      }

		// 최대 3개의 파일만 허용
		form.submit();
	}
</script>