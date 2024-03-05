<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../Main.jsp" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	#imgUrl {
		width: 200px;
		height: auto;
	}
</style>
</head>
<body>
<c:if test="${user eq null}">
	<h1 class="py-3"> 일치하는 회원이 없습니다 </h1>
</c:if>

<c:if test="${user ne null}">
	<h1 class="py-3" > ${user.name}  회원의 상세보기 </h1>
	<form action="${ctx}/userUpdate.do" method="post">
	<input type="hidden" id="no" name="no" value="${user.no}"/>
	<table class='table table-bordered' border="1">
	<tr>
		<td>프로필 이미지</td>
		<td>이메일</td>
		<td class="left"> <c:if test="${ user.pw ne 'SNSPw' }">${user.id}</c:if>
		<c:if test="${ user.pw eq 'SNSPw' }">SNS 회원 </c:if></td>
		
	</tr>
	<tr>
		<td rowspan="7">
       	<c:if test="${user.imgUrl ne 'default.jpg'}">
   	         <img src="/member/img/${user.imgUrl}" id="imgUrl"/>
		</c:if>
		<c:if test="${user.imgUrl eq 'default.jpg'}">
   	         <img src="https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg" id="imgUrl" class="defalut">
		</c:if>
		<br>
		<input type="button" value="사진 업로드" class='col-3  btn-success' id="uploadBtn"/> 
		<input type="submit" value="수정하기" class='col-3 btn-primary'/>
		<input type="button" value="사진 삭제" class='col-3 btn-warning' id="deleteBtn"/> 
    </td>
	</tr> 
 	<tr>
		<td>비밀번호</td>
		<td class="left"><c:if test="${ user.pw ne 'SNSPw' }"><input class="col-12"  type="password" name="pw"/></c:if>
		<c:if test="${ user.pw eq 'SNSPw' }">SNS 회원은 비밀번호를 수정할 수 없습니다.
		<input type="hidden" name="pw" value="SNSPw"></c:if></td>
 	</tr>  
	<tr>
		<td>비밀번호 확인</td>
		<td class="left"><c:if test="${ user.pw ne 'SNSPw' }"><input class="col-12"  type="password" name="pw1"/></c:if>
		<c:if test="${ user.pw eq 'SNSPw' }">SNS 회원은 비밀번호를 수정할 수 없습니다.
		<input type="hidden" name="pw" value="SNSPw"></c:if></td>
	</tr>  
    <tr>
		<td>이름</td>
		<td class="left"><input class="col-12"  type="text" name="name" value="${user.name}"/></td>
	</tr> 
 	<tr>
    	<td>전화번호</td>
    	<td><input class="col-12" type="text" name="phone" value="${user.phone}"/></td>
	</tr> 
  	<tr>
    	<td>닉네임</td>
    	<td><input class="col-12"  type="text" name="nickname" value="${user.nickname}"/></td>
	</tr>
	<tr>
    	<td>라이더 신청</td>
    	<td>
    	    <input class="col-12" type="radio" name="delivery" value=false ${user.deliver eq false ? 'checked' : ''} /> 미신청
    		<input class="col-12" type="radio" name="delivery" value=true ${user.deliver eq true ? 'checked' : ''} /> 신청
    	</td>
	</tr>
	<tr>
		<td colspan="3" align="center"><input type="submit" value="개인정보 수정"/></td>
	</tr>
	</table>
	</form>
</c:if>
<%@ include file="../parts/footer.jsp" %>
</body>
</html>