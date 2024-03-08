<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../Main.jsp" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	#user_container{
	}
	.table h1{
		text-align: center;
	}
	.table #preview {
		width: 200px;
		height: auto;
		margin: auto;
		border-radius: 50%;
		display: block;
	}
	.table{
		width: 700px;
		height: 350px;
		margin: auto;
	}
	.table th{
		background-color: #eee;
		border-radius: 5px;
	}
	.table tr td{
		/* height: 100%; */
	}
	.col-12{
		width: 70%;
		border: none;
		border-bottom: 2px solid skyblue;
	}
	.btn-success, .btn-warning{
		margin-left: 0px;
	}
</style>
</head>
<body>
<c:if test="${user eq null}">
	<h1 class="py-3"> 일치하는 회원이 없습니다 </h1>
</c:if>
<c:if test="${user ne null}">
<div id="user_container">
	<form action="${ctx}/userUpdate.do" method="post" enctype="multipart/form-data">
	<input type="hidden" id="no" name="no" value="${user.no}"/>
	<table class='table'>
	<tr><td colspan="4"><h1> ${user.name}  회원의 상세보기 </h1></td></tr>
	<tr>
		<th width="250">프로필 이미지</th>
		<th>이메일</th>
		<td class="left"> <c:if test="${ user.pw ne 'SNSPw' }">${user.id}</c:if>
		<c:if test="${ user.pw eq 'SNSPw' }">SNS 회원 </c:if></td>
	</tr>
	<tr>
		<td rowspan="7" height="300">
        <img src="./img/${user.imgUrl}" id="preview"/>
		<br>
		<input type="file" class='col-3 btn-success'  name="files[]" accept="image/*" onchange="uploadFile(this)"/> <br>
		<input type="button" value="파일 삭제" class='col-3 btn-warning' id="deleteBtn" <c:if test="${ user.imgUrl eq 'default.jpg' }">disabled="disabled"</c:if> />
		<input type="hidden" name="img" value="default.jpg" />
    </td>
	</tr> 
 	<tr>
		<th>비밀번호 수정</th>
		<td class="left"><c:if test="${ user.pw ne 'SNSPw' }">
		<input class="col-12"  type="password" name="pw" required /></c:if>
		<c:if test="${ user.pw eq 'SNSPw' }">SNS 회원은 비밀번호를 수정할 수 없습니다.
		<input type="hidden" name="pw" value="SNSPw"></c:if></td>
 	</tr>  
	<tr>
		<th>비밀번호 확인</th>
		<td class="left"><c:if test="${ user.pw ne 'SNSPw' }">
		<input class="col-12"  type="password" name="pw1" required /></c:if>
		<c:if test="${ user.pw eq 'SNSPw' }">SNS 회원은 비밀번호를 수정할 수 없습니다.
		<input type="hidden" name="pw" value="SNSPw"></c:if></td>
	</tr>  
    <tr>
		<th>이름</th>
		<td class="left"><input class="col-12"  type="text" name="name" value="${user.name}"/></td>
	</tr> 
 	<tr>
    	<th>전화번호</th>
    	<td><input class="col-12" type="text" name="phone" value="${user.phone}"/></td>
	</tr> 
  	<tr>
    	<th>닉네임</th>
    	<td><input class="col-12"  type="text" name="nickname" value="${user.nickname}"/></td>
	</tr>
	<tr>
    	<th>라이더 신청</th>
    	<td>
    	    <input type="radio" name="delivery" value=false ${user.deliver eq false ? 'checked' : ''} /> 미신청
    		<input type="radio" name="delivery" value=true ${user.deliver eq true ? 'checked' : ''} /> 신청
    	</td>
	</tr>
	<tr>
		<td colspan="3" align="center"><input type="submit" value="개인정보 수정"/></td>
	</tr>
	</table>
	</form>
</div>
</c:if>
<%@ include file="../parts/footer.jsp" %>
<script type="text/javascript">

let pre_img = "${ user.imgUrl }"
let $deletebtn = document.querySelector('#deleteBtn');

function uploadFile(file) {
	if(file.files && file.files[0]){
		var fr = new FileReader();
		fr.onload = function(event) {
			document.getElementById("preview").src=event.target.result;
		};
		fr.readAsDataURL(file.files[0]);
	} else {
		document.getElementById("preview").src="";
	}
}
$deletebtn.addEventListener("click", function() {
    // 이미지 변경
    document.getElementById("preview").src = 'https://xe1.xpressengine.com/files/attach/images/122/186/812/022/148a2737f4121869610c1d93cc0f6061.jpg';
});
</script>
</body>
</html>