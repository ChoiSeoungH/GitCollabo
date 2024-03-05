<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<c:set var="ctx" value="${pageContext.request.contextPath}"/>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
.list-container{
	border:1px;
	display:flex;
	text-align:center;
	width:300px;
	height:300px;
}
h3{
text-align:center;
}
table{
	width:300px;
	height:200px;
	margin-right:20px;

}
.list>tr{
 flex-direction: column;
width:200px;
height:200px;
}
.tr>img{
 flex-direction: column;
width:200px;
height:100px;
}
form{
	text-align:center;
}
.cate{
	text-align:center;
	border:1px solid ;
}
.cate>input{
	text-align:center;
  background-color: white;
}

</style>
<body>
<form action="${ctx}/productSearch.do" method="get" class="search">
<input class="query" placeholder="검색어 입력" type="text" name="query">

<input type=submit value="검색">
</form>

<div class="cate">
<input type="button" value="일반" onclick="location.href='${ctx}/productList.do?auction=0'">
<input type="button" value="경매" onclick="location.href='${ctx}/productList.do?auction=2'">
<input type="button" value="전체" onclick="location.href='${ctx}/productList.do?auction='">
</div>
<c:if test="${au == null}">
<h3>최신상품리스트</h3> 
<div class="list-container">
 <c:forEach var="latest" items="${latest}">
        <c:forEach var="img" items="${imgList}">
            <c:if test="${latest.no == img.productNo && latest.buyerNo eq 0  && latest.endDate == null}">
            	<form action="${ctx}/productContent.do"  method="post" class="myForm">
            	<input type="hidden" value="${latest.title}" name="query">
            	<input type="hidden" value="${latest.no}" name="productNo">
              <input type="hidden" value="${latest.auction}" name="auction">
                <table class="list" align="center" border="1">
<c:choose>
    <c:when test="${not empty img.imageUrl}">
        <script>
            // 이미지 URL
            var imageUrl = "img/${img.imageUrl}";

            // URL에서 파일 이름 추출
            var parts = imageUrl.split(",");
            var fileName = parts[parts.length - 1];

            if (parts && parts.length > 0) {
                var fileName = parts[parts.length - 1];
                document.write('<tr><td><img src="' + parts[0] + '" alt="이미지" width="110" height="80" /></td></tr>');
            }
        </script>
    </c:when>
    <c:otherwise>
        <script>
            document.write('<tr><td><img src="img/unnamed.jpg" alt="이미지" width="110" height="80" /></td></tr>');
        </script>
    </c:otherwise>
</c:choose>
                    <tr><td>${latest.title}</td></tr>
                    <tr><td>${latest.price}</td></tr>
                    <!-- 나머지 열들도 필요에 따라 추가 -->
                </table>
                </form>
            </c:if>
        </c:forEach>
    </c:forEach>
</div>
<hr>
<h3>디지털상품리스트</h3>
<div class="list-container">
 <c:forEach var="c" items="${list}">
        <c:forEach var="img" items="${imgList}">
            <c:if test="${c.category == 1 && c.no == img.productNo && c.buyerNo == 0 && c.endDate == null}">
            <form action="${ctx}/productContent.do"  method="post" class="myForm">
            	<input type="hidden" value="${c.no}" name="productNo">
            	<input type="hidden" value="${c.title}" name="query">
              <input type="hidden" value="${c.auction}" name="auction">
                <table class="list" align="center">
<c:choose>
    <c:when test="${not empty img.imageUrl}">
        <script>
            // 이미지 URL
            var imageUrl = "img/${img.imageUrl}";

            // URL에서 파일 이름 추출
            var parts = imageUrl.split(",");
            var fileName = parts[parts.length - 1];
            console.log(imageUrl); // 콘솔 로그 출력

            if (parts && parts.length > 0) {
                var fileName = parts[parts.length - 1];
                document.write('<tr><td><img src="' + parts[0] + '" alt="이미지" width="110" height="80" /></td></tr>');
            }
        </script>
    </c:when>
    <c:otherwise>
        <script>
            document.write('<tr><td><img src="img/unnamed.jpg" alt="이미지" width="110" height="80" /></td></tr>');
        </script>
    </c:otherwise>
</c:choose>
                    <tr><td>${c.title}</td></tr>
                    <tr><td>${c.price}</td></tr>

                    <!-- 나머지 열들도 필요에 따라 추가 -->
                </table>
                </form>
            </c:if>
        </c:forEach>
    </c:forEach>
</div>
<hr>
<h3>의류상품리스트</h3>
<div class="list-container">
 <c:forEach var="c" items="${list}">
        <c:forEach var="img" items="${imgList}">
            <c:if test="${c.category == 2 && c.no == img.productNo && c.buyerNo == 0 && c.endDate == null }">
                            <form action="${ctx}/productContent.do"  method="post" class="myForm">
            	<input type="hidden" value="${c.title}" name="query">
            	<input type="hidden" value="${c.no}" name="productNo">
            	 <input type="hidden" value="${c.auction}" name="auction">
             
                <table class="list" align="center">
                
<c:choose>
    <c:when test="${not empty img.imageUrl}">
        <script>
            // 이미지 URL
            var imageUrl = "img/${img.imageUrl}";

            // URL에서 파일 이름 추출
            var parts = imageUrl.split(",");
            var fileName = parts[parts.length - 1];
            console.log(imageUrl); // 콘솔 로그 출력

            if (parts && parts.length > 0) {
                var fileName = parts[parts.length - 1];
                document.write('<tr><td><img src="' + parts[0] + '" alt="이미지" width="110" height="80" /></td></tr>');
            }
        </script>
    </c:when>
    <c:otherwise>
        <script>
            document.write('<tr><td><img src="img/unnamed.jpg" alt="이미지" width="110" height="80" /></td></tr>');
        </script>
    </c:otherwise>
</c:choose>
                    <tr><td>${c.title}</td></tr>
                    <tr><td>${c.price}</td></tr>
                        <tr><td>${c.auction}</td></tr>

                    <!-- 나머지 열들도 필요에 따라 추가 -->
                </table>
                </form>
            </c:if>
        </c:forEach>
    </c:forEach>
</div>
<hr>
<h3>가구상품리스트</h3>
<div class="list-container">
    <c:forEach var="c" items="${list}">
    
        <c:forEach var="img" items="${imgList}">
            <c:if test="${c.category == 3 && c.no == img.productNo  && c.buyerNo == 0 && c.endDate == null}">
                        <form action="${ctx}/productContent.do"  method="post" class="myForm">
            	<input type="hidden" value="${c.title}" name="query">
            	<input type="hidden" value="${c.no}" name="productNo">
            	  <input type="hidden" value="${c.auction}" name="auction">
              
                <table class="list" align="center">
<c:choose>
    <c:when test="${not empty img.imageUrl}">
        <script>
            // 이미지 URL
            var imageUrl = "img/${img.imageUrl}";

            // URL에서 파일 이름 추출
            var parts = imageUrl.split(",");
            var fileName = parts[parts.length - 1];
            console.log(imageUrl); // 콘솔 로그 출력

            if (parts && parts.length > 0) {
                var fileName = parts[parts.length - 1];
                document.write('<tr><td><img src="' + parts[0] + '" alt="이미지" width="110" height="80" /></td></tr>');
            }
        </script>
    </c:when>
    <c:otherwise>
        <script>
            document.write('<tr><td><img src="img/unnamed.jpg" alt="이미지" width="110" height="80" /></td></tr>');
        </script>
    </c:otherwise>
</c:choose>
                    <tr><td>${c.title}</td></tr>
                    <tr><td>${c.price}</td></tr>

                    <!-- 나머지 열들도 필요에 따라 추가 -->
                </table>
                </form>
            </c:if>
        </c:forEach>
    </c:forEach>
</div>
<hr>
<h3>기타상품리스트</h3>
<div class="list-container">
 <c:forEach var="c" items="${list}">
        <c:forEach var="img" items="${imgList}">
            <c:if test="${c.category == 0 && c.no == img.productNo && c.buyerNo == 0 && c.endDate == null}">
                        <form action="${ctx}/productContent.do"  method="post" class="myForm">
            	<input type="hidden" value="${c.no}" name="productNo">
             <input type="hidden" value="${c.auction}" name="auction">
             <input type="hidden" value="${c.title}" name="query">
                <table class="list" align="center">
<c:choose>
    <c:when test="${not empty img.imageUrl}">
        <script>
            // 이미지 URL
            var imageUrl = "img/${img.imageUrl}";

            // URL에서 파일 이름 추출
            var parts = imageUrl.split(",");
            var fileName = parts[parts.length - 1];
            console.log(imageUrl); // 콘솔 로그 출력

            if (parts && parts.length > 0) {
                var fileName = parts[parts.length - 1];
                document.write('<tr><td><img src="' + parts[0] + '" alt="이미지" width="110" height="80" /></td></tr>');
            }
        </script>
    </c:when>
    <c:otherwise>
        <script>
            document.write('<tr><td><img src="img/unnamed.jpg" alt="이미지" width="110" height="80" /></td></tr>');
        </script>
    </c:otherwise>
</c:choose>
                    <tr><td>${c.title}</td></tr>
                    <tr><td>${c.price}</td></tr>

                    <!-- 나머지 열들도 필요에 따라 추가 -->
                </table>
                </form>
            </c:if>
        </c:forEach>
    </c:forEach>
</div>
</c:if>


       <!-- 경매상품리스트 -->



<c:if test="${au != null}">
<h3>경매최신상품리스트</h3>
<div class="list-container">
 <c:forEach var="latest" items="${latest}">
 <c:forEach var="c"  items="${list}">
<c:forEach var="img" items="${imgList}">
            <c:if test="${latest.productNo == img.productNo && latest.productNo == c.no && c.endDate eq null} ">
            	<form action="${ctx}/productContent.do"  method="post" class="myForm">
            	<input type="hidden" value="${latest.prductNo}" name="productNo">
            	    	<input type="hidden" value="${c.title}" name="query">
              <input type="hidden" value="${c.category}" name="category">
              <input type="hidden" value="${c.auction}" name="auction">
                <table class="list" align="center" border="1">
<c:choose>
    <c:when test="${not empty img.imageUrl}">
        <script>
            // 이미지 URL
            var imageUrl = "img/${img.imageUrl}";

            // URL에서 파일 이름 추출
            var parts = imageUrl.split(",");
            var fileName = parts[parts.length - 1];

            if (parts && parts.length > 0) {
                var fileName = parts[parts.length - 1];
                document.write('<tr><td><img src="' + parts[0] + '" alt="이미지" width="110" height="80" /></td></tr>');
            }
        </script>
    </c:when>
    <c:otherwise>
        <script>
            document.write('<tr><td><img src="img/unnamed.jpg" alt="이미지" width="110" height="80" /></td></tr>');
        </script>
    </c:otherwise>
</c:choose>
                    <tr><td>상품 :${latest.title}</td></tr>
                    <tr><td>현재 입찰가 ${au.lastPrice}</td></tr>
                    <!-- 나머지 열들도 필요에 따라 추가 -->
                </table>
                </form>
            </c:if>
            </c:forEach>
        </c:forEach>
    </c:forEach>
 
</div>
<hr>
<h3>경매 디지털상품리스트</h3>
<div class="list-container">
 <c:forEach var="c" items="${list}">
      <c:forEach var="au" items="${au}">
        <c:forEach var="img" items="${imgList}">
           <c:if test="${c.category == 1 && c.no == img.productNo && c.no == au.productNo && c.endDate eq null}">
            <form action="${ctx}/productContent.do"  method="post" class="myForm">
            	<input type="hidden" value="${c.no}" name="productNo">
            	    	<input type="hidden" value="${c.title}" name="query">
            	<input type="hidden" value="${c.category}" name="category">
              <input type="hidden" value="${c.auction}" name="auction">
                <table class="list" align="center">
<c:choose>
    <c:when test="${not empty img.imageUrl}">
        <script>
            // 이미지 URL
            var imageUrl = "img/${img.imageUrl}";

            // URL에서 파일 이름 추출
            var parts = imageUrl.split(",");
            var fileName = parts[parts.length - 1];
            console.log(imageUrl); // 콘솔 로그 출력

            if (parts && parts.length > 0) {
                var fileName = parts[parts.length - 1];
                document.write('<tr><td><img src="' + parts[0] + '" alt="이미지" width="110" height="80" /></td></tr>');
            }
        </script>
    </c:when>
    <c:otherwise>
        <script>
            document.write('<tr><td><img src="img/unnamed.jpg" alt="이미지" width="110" height="80" /></td></tr>');
        </script>
    </c:otherwise>
</c:choose>
                    <tr><td>상품 : ${c.title}</td></tr>
                    <tr><td>현재 입찰가 ${au.lastPrice}</td></tr>

                    <!-- 나머지 열들도 필요에 따라 추가 -->
                </table>
                </form>
            </c:if>
        </c:forEach>
    </c:forEach>
    </c:forEach>
</div>
<hr>
<h3>경매 의류상품리스트</h3>
<div class="list-container">
 <c:forEach var="c" items="${list}">
 <c:forEach var="au" items="${au}">
        <c:forEach var="img" items="${imgList}">
            <c:if test="${c.category == 2 && c.no == img.productNo && c.no == au.productNo && c.endDate eq null}">
                            <form action="${ctx}/productContent.do"  method="post" class="myForm">
            	<input type="hidden" value="${c.no}" name="productNo">
            	    	<input type="hidden" value="${c.title}" name="query">
            	<input type="hidden" value="${c.category}" name="category">
            	 <input type="hidden" value="${c.auction}" name="auction">
             
                <table class="list" align="center">
                
<c:choose>
    <c:when test="${not empty img.imageUrl}">
        <script>
            // 이미지 URL
            var imageUrl = "img/${img.imageUrl}";

            // URL에서 파일 이름 추출
            var parts = imageUrl.split(",");
            var fileName = parts[parts.length - 1];
            console.log(imageUrl); // 콘솔 로그 출력

            if (parts && parts.length > 0) {
                var fileName = parts[parts.length - 1];
                document.write('<tr><td><img src="' + parts[0] + '" alt="이미지" width="110" height="80" /></td></tr>');
            }
        </script>
    </c:when>
    <c:otherwise>
        <script>
            document.write('<tr><td><img src="img/unnamed.jpg" alt="이미지" width="110" height="80" /></td></tr>');
        </script>
    </c:otherwise>
</c:choose>
                    <tr><td>상품 : ${c.title}</td></tr>
                    <tr><td>현재 입찰가 ${au.lastPrice}</td></tr>

                </table>
                </form>
            </c:if>
            </c:forEach>
        </c:forEach>
    </c:forEach>
</div>
<hr>
<h3>경매 가구상품리스트</h3>
<div class="list-container">
    <c:forEach var="c" items="${list}">
        <c:forEach var="au" items="${au}">
        <c:forEach var="img" items="${imgList}">
        <c:if test="${c.category == 3 && c.no == img.productNo && c.no == au.productNo && c.endDate eq null}">
                        <form action="${ctx}/productContent.do"  method="post" class="myForm">
            	<input type="hidden" value="${c.no}" name="productNo">
            	    	<input type="hidden" value="${c.title}" name="query">
            	<input type="hidden" value="${c.category}" name="category">
            	  <input type="hidden" value="${c.auction}" name="auction">
              
                <table class="list" align="center">
<c:choose>
    <c:when test="${not empty img.imageUrl}">
        <script>
            // 이미지 URL
            var imageUrl = "img/${img.imageUrl}";

            // URL에서 파일 이름 추출
            var parts = imageUrl.split(",");
            var fileName = parts[parts.length - 1];
            console.log(imageUrl); // 콘솔 로그 출력

            if (parts && parts.length > 0) {
                var fileName = parts[parts.length - 1];
                document.write('<tr><td><img src="' + parts[0] + '" alt="이미지" width="110" height="80" /></td></tr>');
            }
        </script>
    </c:when>
    <c:otherwise>
        <script>
            document.write('<tr><td><img src="img/unnamed.jpg" alt="이미지" width="110" height="80" /></td></tr>');
        </script>
    </c:otherwise>
</c:choose>
                    <tr><td>${c.title}</td></tr>
                    <tr><td>현재 입찰가 ${au.lastPrice}</td></tr>

                    <!-- 나머지 열들도 필요에 따라 추가 -->
                </table>
                </form>
            </c:if>
        </c:forEach>
    </c:forEach>
    </c:forEach>
</div>
<hr>
<h3>경매 기타상품리스트</h3>
<div class="list-container">
 <c:forEach var="c" items="${list}">
 <c:forEach var="au" items="${au}">
        <c:forEach var="img" items="${imgList}">
        <c:if test="${c.category == 0 && c.no == img.productNo && c.no == au.productNo && c.endDate eq null}">
                        <form action="${ctx}/productContent.do"  method="post" class="myForm">
            	<input type="hidden" value="${c.no}" name="productNo">
            	<input type="hidden" value="${c.title}" name="query">
            	<input type="hidden" value="${c.category}" name="category">
             <input type="hidden" value="${c.auction}" name="auction">
                <table class="list" align="center">
<c:choose>
    <c:when test="${not empty img.imageUrl}">
        <script>
            // 이미지 URL
            var imageUrl = "img/${img.imageUrl}";

            // URL에서 파일 이름 추출
            var parts = imageUrl.split(",");
            var fileName = parts[parts.length - 1];
            console.log(imageUrl); // 콘솔 로그 출력

            if (parts && parts.length > 0) {
                var fileName = parts[parts.length - 1];
                document.write('<tr><td><img src="' + parts[0] + '" alt="이미지" width="110" height="80" /></td></tr>');
            }
        </script>
    </c:when>
    <c:otherwise>
        <script>
            document.write('<tr><td><img src="img/unnamed.jpg" alt="이미지" width="110" height="80" /></td></tr>');
        </script>
    </c:otherwise>
</c:choose>
                    <tr><td>상품 ${c.title}</td></tr>
                    <tr><td>현재 입찰가 ${au.lastPrice}</td></tr>

                    <!-- 나머지 열들도 필요에 따라 추가 -->
                </table>
                </form>
            </c:if>
        </c:forEach>
    </c:forEach>
    </c:forEach>
</div>
</c:if>

</body>
</html>
<script>
var formElementsArray = document.querySelectorAll('.myForm');

// 클릭 이벤트에 대한 핸들러 등록
formElementsArray.forEach(function(myform) {
    myform.addEventListener("click", function(event) {
        // 기본 동작 막기
        event.preventDefault();

        // 서브밋
        myform.submit();
    });
});

</script>