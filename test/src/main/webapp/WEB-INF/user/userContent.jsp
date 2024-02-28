<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../Main.jsp" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<body>
<c:if test="${user eq null}">
  <h1 class="py-3"> 일치하는 회원이 없습니다 </h1>
</c:if>
<c:if test="${user ne null}">
<h1 class="py-3" > ${user.name}  회원의 상세보기 </h1>
<form action="${ctx}/userUpdate.do" method="post">
<input type="hidden" id="no" name="no" value="${user.no}"/>
<table class='table table-bordered'>
  <tr>
    <td>이메일</td>
    <td class="left"> ${user.id}</td>
  </tr>
   <tr>
    <td>비밀번호</td>
    <td class="left"><input class="col-12"  type="password" name="pw"/></td>
  </tr>  
   <tr>
    <td>비밀번호 확인</td>
    <td class="left"><input class="col-12"  type="password" name="pw"/></td>
  </tr>  
    <tr>
    <td>이름</td>
    <td class="left">${user.name}</td>
  </tr> 
  <tr>
    <td>전화번호</td>
    <td><input class="col-12"  type="text" name="phone" value="${user.phone}"/></td>
  </tr> 
  <tr>
    <td>닉네임</td>
    <td><input class="col-12"  type="text" name="nickname" value="${user.nickname}"/></td>
  </tr> 
  <tr>
    <td>프로필 이미지</td>
        <td>
        	<c:if test="${user.imgUrl ne 'default.jpg'}">
    	         <img src="/member/img/${vo.imgUrl}" id="imgUrl"/>
			</c:if>
			<c:if test="${user.imgUrl eq 'default.jpg'}">
    	         <img src="https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg" id="imgUrl" class="defalut">
			</c:if>
		</td>
  </tr> 
  <tr>
    <td colspan="2" align="center">
       <input type="button" value="사진 업로드" class='col-3 btn btn-success' id="uploadBtn"  <c:if test="${loginId!=user.id and loginId!='admin'}"> 
    	              disabled="disabled"
          	      </c:if>/> 
       <input type="submit" value="수정하기" class='col-3 btn btn-primary' <c:if test="${loginId!=user.id and loginId!='admin'}"> 
    	              disabled="disabled"
          	      </c:if>/>
       <input type="button" value="사진 삭제" class='col-3 btn btn-warning' id="deleteBtn"   <c:if test="${loginId!=user.id and loginId!='admin'}"> 
    	              disabled="disabled"
          	      </c:if>/> 
    </td>
  </tr>
</table>
</form>
</c:if>
<%@ include file="../parts/footer.jsp" %>
</body>
</html>