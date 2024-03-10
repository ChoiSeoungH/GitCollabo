<%@ page language="java" contentType="text/html; charset=UTF-8"
				 pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="user" value="${user}"/>
<!DOCTYPE html>
<html>
<style>
	table {
		width: 600px;
	}

	textarea {
		text-align: center;
		width: 600px;
		height: 200px;
	}

	.Content {
		text-align: center;
		border: 0;
	}

	.input {
		width: 300px;
		text-align: center;
	}

	input.img {
		width: 10px;
		height: 10px;
		border-radius: 50%; /* 동그라미를 만들기 위한 속성 */
		border: none;
		background-color: #808080;
		cursor: pointer;
	}
</style>
<script type="text/javascript">
	var previewIds = ['preview1', 'preview2', 'preview3'];
	var currentPreviewIndex = 0;

	function loadFiles(input) {
		var files = input.files;
		var maxFiles = parseInt(input.getAttribute('max'));

		if (files.length > 3) {
			alert('최대 ' + maxFiles + '개의 파일만 업로드할 수 있습니다.');
			// 파일 업로드 막기 (선택한 파일 초기화)
			input.value = '';
		}

		for (var i = 0; i < input.files.length && i < previewIds.length; i++) {
			var fr = new FileReader();
			var currentPreviewId = previewIds[i];

			fr.onload = (function (previewId) {
				return function (event) {
					document.getElementById(previewId).src = event.target.result;
					document.getElementById(previewId).style.display = 'none';
				};
			})(currentPreviewId);

			fr.readAsDataURL(input.files[i]);
		}

		document.getElementById(previewIds[currentPreviewIndex]).style.display = 'inline-block';
	}
	function changePreviewIds(newIds) {
		for (var i = 0; i < previewIds.length; i++) {
			document.getElementById(previewIds[i]).style.display = 'none';
		}

		previewIds = newIds;
		currentPreviewIndex = 0;

		for (var j = 0; j < previewIds.length; j++) {
			document.getElementById(previewIds[j]).style.display = 'none';
		}

		document.getElementById(previewIds[currentPreviewIndex]).style.display = 'inline-block';
	}
</script>

<head>
	<meta charset="UTF-8">
	<title>상품추가하기</title>
</head>
<body>
<img alt="" id="preview1" style="width: 250px; height: 300px; position: absolute; left: 195px; top: 100px;" />
<img alt="" id="preview2" style="width: 250px; height: 300px; position: absolute; left: 195px; top: 100px; display: none;"/>
<img alt="" id="preview3" style="width: 250px; height: 300px; position: absolute; left: 195px; top: 100px; display: none;"/>
<input type="button" class="img" onclick="changePreviewIds(['preview1'])" style="position: absolute; left: 295px; top: 380px;"/>
<input type="button" class="img" onclick="changePreviewIds(['preview2'])" style="position: absolute; left: 310px; top: 380px;"/>
<input type="button" class="img" onclick="changePreviewIds(['preview3'])" style="position: absolute; left: 325px; top: 380px;"/>
<h1 align="center">상품추가하기</h1>
<form action="${ctx}/productAdd.do" enctype="multipart/form-data"	method="post">
	<table align="center" border=1>
		<input type="hidden" name="no" value="${user.no}" >
		<%--	<input type="hidden" name="sellLocation" value="${user.location}">  --%>
		<input type="hidden" name="sellLocation" value="${user.location}">
		<!-- 위에 나중에 sellLocation 바꿔야함 -->
		<tr>
			<td>상품제목 : &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <input
					class="input" type="text" name="productName"></td>
		</tr>
		<tr>
			<td>상품가격 : &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
				&nbsp; &nbsp; &nbsp; <input class="inputPrice" type="number"
																		name="productPrice" min="1000" max="">원
			</td>
		</tr>
		<tr>
			<td>거래방법 : &nbsp; &nbsp; &nbsp; <input type="radio"
																						 name="method" value="0">직거래 <input type="radio"
																																								name="method" value="1">택배 <input type="radio"
																																																									name="method" value="2">퀵서비스 <input type="radio"
																																																																											name="method" value="3">상관없음
			</td>
		</tr>
		<tr>
			<td>경매여부 : &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <input
					type="radio" name="auction" value="0">일반판매 <input
					type="radio" name="auction" value="1">경매판매
			</td>
		</tr>
		<tr>
			<td>상품 카테고리 : &nbsp; &nbsp; &nbsp; <input type="radio"
																								name="category" value="1">디지털 <input type="radio"
																																										 name="category" value="2">의류 <input type="radio"
																																																												 name="category" value="3">가구 <input type="radio"
																																																																														 name="category" value="4">기타
			</td>
		</tr>
		<tr>
			<td><label for="fileInput">다중 파일(최대3개) 선택:</label> <input
					type="file" name="files[]" id="fileInput" accept="image/*" max="3"
					onchange="loadFiles(this)" multiple>
				<br>
			</td>
		</tr>

		<tr>
			<td class="Content">상품정보
				<hr>
			</td>
		</tr>
		<tr>
			<td><textarea name="productContent" width="400"></textarea></td>
		</tr>
		<tr>
			<td style="text-align: center; padding: 10px;"><input
					type="button" value="등록하기" onclick="validCheck(form)"> <input
					type="button" value="메인으로" onclick="location.href='${ctx}/main.do'"></td>
		</tr>
	</table>
</form>
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
		/* 	if(!userLocation.trim()){
        alert("먼저 위치설정을 해주세요");
        return false;
      } */

		// 최대 3개의 파일만 허용
		form.submit();
	}
</script>