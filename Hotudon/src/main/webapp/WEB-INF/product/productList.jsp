<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<c:set var="ctx" value="${pageContext.request.contextPath}"/>  
<c:set var="user" value="${user}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
.list-container{

	display:flex;
	text-align:center;
	width:300px;
	height:250px;
}
h3{
text-align:center;
}
table{
 margin-right: 20px;
	width:300px;
	height:200px;
	background-color: white;
    border: 3px solid transparent;
    border-image: linear-gradient(to right, red 0%, orange 100%);
    border-image-slice: 1;
}
.list>tr{
 flex-direction: column;
width:200px;
height:200px;

}
.list td {
	
	border:1px;	
	background-color: white;
    border: 3px solid transparent;
    border-image: linear-gradient(to right, red 0%, orange 100%);
    border-image-slice: 1;
}
.tr>img{
 flex-direction: column;
	width:300px;
height:100px;
}
form{
	text-align:center;
}
.cate{
	 padding-top: 20px;
	text-align:center;

}
.cate>input{
 margin-right: 20px;
	text-align:center;
  background-color: white;
    border: 3px solid transparent;
    border-radius: 50%;
    border-image: linear-gradient(to right, red 0%, orange 100%);
    border-image-slice: 1;
}
.hr-styled {
    margin-right: 20px;
    text-align: center;
    background-color: white;
    border: 3px solid transparent;
    border-radius: 50%;
    border-image: linear-gradient(to right, red 0%, orange 100%);
    border-image-slice: 1;
}
.remainingTime{
 color:red;
}
</style>
<body>
<form action="${ctx}/productSearch.do" method="get" class="search">
<input class="query" placeholder="검색어 입력" type="text" name="query">

<input type=submit value="검색">
</form>

<div class="cate">
<input type="button" class="btn" value="일반" onclick="location.href='${ctx}/productList.do?auction=0'">
<input type="button" class="btn" value="경매" onclick="location.href='${ctx}/productList.do?auction=2'">
<input type="button" class="btn" value="전체" onclick="location.href='${ctx}/productList.do?auction='">
</div>
<c:if test="${au == null}">
<h3>최신상품리스트</h3> 
<div class="list-container">
 <c:forEach var="latest" items="${latest}">
        <c:forEach var="img" items="${imgList}">
            <c:if test="${latest.no == img.productNo && latest.buyerNo eq 0  && latest.endDate == null}">
            	<form action="${ctx}/productContent.do"  method="post" class="myForm">
            	<input type="hidden" value="${user.no}" name="no">
            	<input type="hidden" value="${latest.title}" name="query">
            	<input type="hidden" value="${latest.no}" name="productNo">
              <input type="hidden" value="${latest.auction}" name="auction">
                <table class="list">
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
                document.write('<tr><td><img src="' + parts[0] + '" alt="이미지" width="250" height="80" /></td></tr>');
            }
        </script>
    </c:when>
    <c:otherwise>
        <script>
            document.write('<tr><td><img src="img/unnamed.jpg" alt="이미지" width="250" height="80" /></td></tr>');
        </script>
    </c:otherwise>
</c:choose>
                    <tr><td>상품 : ${latest.title}</td></tr>
                    <tr><td>가격 : ${latest.price}</td></tr>
                    <!-- 나머지 열들도 필요에 따라 추가 -->
                </table>
                </form>
            </c:if>
        </c:forEach>
    </c:forEach>
</div>
<hr class="hr-styled">
<h3>디지털상품리스트</h3>
<div class="list-container">
 <c:forEach var="c" items="${list}">
        <c:forEach var="img" items="${imgList}">
            <c:if test="${c.category == 1 && c.no == img.productNo && c.buyerNo == 0 && c.endDate == null}">
            <form action="${ctx}/productContent.do"  method="post" class="myForm">
            	<input type="hidden" value="${user.no}" name="no">
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
<hr class="hr-styled">
<h3>의류상품리스트</h3>
<div class="list-container">
 <c:forEach var="c" items="${list}">
        <c:forEach var="img" items="${imgList}">
            <c:if test="${c.category == 2 && c.no == img.productNo && c.buyerNo == 0 && c.endDate == null }">
                            <form action="${ctx}/productContent.do"  method="post" class="myForm">
            	            	<input type="hidden" value="${user.no}" name="no">
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
                document.write('<tr><td><img src="' + parts[0] + '" alt="이미지" width="250" height="80" /></td></tr>');
            }
        </script>
    </c:when>
    <c:otherwise>
        <script>
            document.write('<tr><td><img src="img/unnamed.jpg" alt="이미지" width="250" height="80" /></td></tr>');
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
<hr class="hr-styled">
<h3>가구상품리스트</h3>
<div class="list-container">
    <c:forEach var="c" items="${list}">
    
        <c:forEach var="img" items="${imgList}">
            <c:if test="${c.category == 3 && c.no == img.productNo  && c.buyerNo == 0 && c.endDate == null}">
                        <form action="${ctx}/productContent.do"  method="post" class="myForm">
            	            	<input type="hidden" value="${user.no}" name="no">
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
                document.write('<tr><td><img src="' + parts[0] + '" alt="이미지" width="250" height="80" /></td></tr>');
            }
        </script>
    </c:when>
    <c:otherwise>
        <script>
            document.write('<tr><td><img src="img/unnamed.jpg" alt="이미지" width="250" height="80" /></td></tr>');
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
<hr class="hr-styled">
<h3>기타상품리스트</h3>
<div class="list-container">
 <c:forEach var="c" items="${list}">
        <c:forEach var="img" items="${imgList}">
            <c:if test="${c.category == 0 && c.no == img.productNo && c.buyerNo == 0 && c.endDate == null}">
                        <form action="${ctx}/productContent.do"  method="post" class="myForm">
                        	<input type="hidden" value="${user.no}" name="no">
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
                document.write('<tr><td><img src="' + parts[0] + '" alt="이미지" width="250" height="80" /></td></tr>');
            }
        </script>
    </c:when>
    <c:otherwise>
        <script>
            document.write('<tr><td><img src="img/unnamed.jpg" alt="이미지" width="250" height="80" /></td></tr>');
        </script>
    </c:otherwise>
</c:choose>
                    <tr><td>제목 : ${c.title}</td></tr>
                    <tr><td>가격 : ${c.price}</td></tr>

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
 <c:forEach var="c"  items="${list}">
<c:forEach var="img" items="${imgList}">
 <c:forEach var="latest" items="${latest}">
            <c:if test="${c.no == img.productNo && latest.productNo == c.no} ">
            	<form action="${ctx}/productContent.do"  method="post" class="myForm">
            	            	<input type="hidden" value="${user.no}" name="no">
            	<input type="hidden" value="${latest.productNo}" name="productNo">
            	    <input type="hidden" value="${c.title}" name="query">
              <input type="hidden" value="${c.category}" name="category">
              <input type="hidden" value="${c.auction}" name="auction">
                <table class="list">
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
                document.write('<tr><td><img src="' + parts[0] + '" alt="이미지" width="250" height="80" /></td></tr>');
            }
        </script>
    </c:when>
    <c:otherwise>
        <script>
            document.write('<tr><td><img src="img/unnamed.jpg" alt="이미지" width="250" height="80" /></td></tr>');
        </script>
    </c:otherwise>
</c:choose>
                    <tr><td>상품 :${ latest.title}</td></tr>
                    <tr><td>현재 입찰가 : ${au.lastPrice}</td></tr>
                        <tr><td><div class="remainingTime" data-auction-id="${latest.productNo}"></div></td></tr>	
                    <script>
                    var lastBidDate = new Date("${au.lastBidDate}");
                    var lastBidNo = Number('${au.lastBidderNo}');
                  
                    var endDate;
                    var remainingTimeElement = document.querySelector(`.remainingTime[data-auction-id="${au.productNo}"]`);
                    console.log(remainingTimeElement);
                    var updateCurrentDate = () => {
                        // 현재 시간
                        var currentDate = new Date();
                        if (lastBidNo == 0) {
                            endDate = new Date(lastBidDate.getTime() + 24 * 60 * 60 * 1000); // 초기
                        } else {
                            endDate = new Date(lastBidDate.getTime() + 3 * 60 * 60 * 1000); // 초기
                        }
                        timeDifference = endDate - currentDate;
                        var hoursDifference = Math.floor(timeDifference / (1000 * 60 * 60));
                        var minutesDifference = Math.floor((timeDifference % (1000 * 60 * 60)) / (1000 * 60));
                        var secondsDifference = Math.floor((timeDifference % (1000 * 60)) / 1000);
                        // 표시할 문자열 생성
                        var remainingTimeText = "경매남은시간 :" + hoursDifference + "시간 " + minutesDifference + "분 " + secondsDifference + "초";
                        // 결과를 HTML에 적용
                        remainingTimeElement.innerHTML = "";
                        remainingTimeElement.textContent = remainingTimeText;
                        // 버튼 업데이트
                    // 경매가 종료되었을 때 
                        if (timeDifference <= 0) {
                            if (lastBidNo == 0) {
                                remainingTimeElement.innerHTML = "유찰"; // 종료 메시지 표시
                            } else {
                                remainingTimeElement.innerHTML = "경매 종료"; // 종료 메시지 표시
                            }
                            clearInterval(intervalId); // 1초마다 실행되는 함수 중지
                        }
                    };


                    // 초기 호출
                    updateCurrentDate();

                    // 1초마다 updateCurrentDate 함수를 호출
                    var intervalId = setInterval(updateCurrentDate, 1000);


                    </script>	
                </table>
                </form>
            </c:if>
            </c:forEach>
        </c:forEach>
    </c:forEach>
 
</div>
<hr class="hr-styled">
<h3>경매 디지털상품리스트</h3>
<div class="list-container">
 <c:forEach var="c" items="${list}">
      <c:forEach var="au" items="${au}">
        <c:forEach var="img" items="${imgList}">
           <c:if test="${c.category == 1 && c.no == img.productNo && c.no == au.productNo && c.endDate eq null}">
            <form action="${ctx}/productContent.do"  method="post" class="myForm">
            	            	<input type="hidden" value="${user.no}" name="no">
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
                document.write('<tr><td><img src="' + parts[0] + '" alt="이미지" width="250" height="80" /></td></tr>');
            }
        </script>
    </c:when>
    <c:otherwise>
        <script>
            document.write('<tr><td><img src="img/unnamed.jpg" alt="이미지" width="250" height="80" /></td></tr>');
        </script>
    </c:otherwise>
</c:choose>
                    <tr><td>상품 : ${c.title}</td></tr>
                    <tr><td>현재 입찰가 ${au.lastPrice}</td></tr>
     	<tr><td><div class="remainingTime" data-auction-id="${au.productNo}"></div></td></tr>
     	             <script>
                    var lastBidDate = new Date("${au.lastBidDate}");
                    var lastBidNo = Number('${au.lastBidderNo}');
                  
                    var endDate;
                    var remainingTimeElement = document.querySelector(`.remainingTime[data-auction-id="${au.productNo}"]`);
                    console.log(remainingTimeElement);
                    var updateCurrentDate = () => {
                        // 현재 시간
                        var currentDate = new Date();
                        if (lastBidNo == 0) {
                            endDate = new Date(lastBidDate.getTime() + 24 * 60 * 60 * 1000); // 초기
                        } else {
                            endDate = new Date(lastBidDate.getTime() + 3 * 60 * 60 * 1000); // 초기
                        }
                        timeDifference = endDate - currentDate;
                        var hoursDifference = Math.floor(timeDifference / (1000 * 60 * 60));
                        var minutesDifference = Math.floor((timeDifference % (1000 * 60 * 60)) / (1000 * 60));
                        var secondsDifference = Math.floor((timeDifference % (1000 * 60)) / 1000);
                        // 표시할 문자열 생성
                        var remainingTimeText = "경매남은시간 :" + hoursDifference + "시간 " + minutesDifference + "분 " + secondsDifference + "초";
                        // 결과를 HTML에 적용
                        remainingTimeElement.innerHTML = "";
                        remainingTimeElement.textContent = remainingTimeText;
                        // 버튼 업데이트
                    // 경매가 종료되었을 때 
                        if (timeDifference <= 0) {
                            if (lastBidNo == 0) {
                                remainingTimeElement.innerHTML = "유찰"; // 종료 메시지 표시
                            } else {
                                remainingTimeElement.innerHTML = "경매 종료"; // 종료 메시지 표시
                            }
                            clearInterval(intervalId); // 1초마다 실행되는 함수 중지
                        }
                    };


                    // 초기 호출
                    updateCurrentDate();

                    // 1초마다 updateCurrentDate 함수를 호출
                    var intervalId = setInterval(updateCurrentDate, 1000);


                    </script>	
                    <!-- 나머지 열들도 필요에 따라 추가 -->
                </table>
                </form>
            </c:if>
        </c:forEach>
    </c:forEach>
    </c:forEach>
</div>
<hr class="hr-styled">
<h3>경매 의류상품리스트</h3>
<div class="list-container">
 <c:forEach var="c" items="${list}">
 <c:forEach var="au" items="${au}">
        <c:forEach var="img" items="${imgList}">
            <c:if test="${c.category == 2 && c.no == img.productNo && c.no == au.productNo && c.endDate eq null}">
                            <form action="${ctx}/productContent.do"  method="post" class="myForm">
            	            	<input type="hidden" value="${user.no}" name="no">
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
                document.write('<tr><td><img src="' + parts[0] + '" alt="이미지" width="250" height="80" /></td></tr>');
            }
        </script>
    </c:when>
    <c:otherwise>
        <script>
            document.write('<tr><td><img src="img/unnamed.jpg" alt="이미지" width="250" height="80" /></td></tr>');
        </script>
    </c:otherwise>
</c:choose>
                    <tr><td>상품 : ${c.title}</td></tr>
                    <tr><td>현재 입찰가 ${au.lastPrice}</td></tr>
  						        <tr><td><div class="remainingTime" data-auction-id="${au.productNo}"></div></td></tr>
  						                     <script>
                    var lastBidDate = new Date("${au.lastBidDate}");
                    var lastBidNo = Number('${au.lastBidderNo}');
                    var endDate;
                    var remainingTimeElement = document.querySelector(`.remainingTime[data-auction-id="${au.productNo}"]`);
                    console.log(remainingTimeElement);
                    var updateCurrentDate = () => {
                        // 현재 시간
                        var currentDate = new Date();
                        if (lastBidNo == 0) {
                            endDate = new Date(lastBidDate.getTime() + 24 * 60 * 60 * 1000); // 초기
                        } else {
                            endDate = new Date(lastBidDate.getTime() + 3 * 60 * 60 * 1000); // 초기
                        }
                        timeDifference = endDate - currentDate;
                        var hoursDifference = Math.floor(timeDifference / (1000 * 60 * 60));
                        var minutesDifference = Math.floor((timeDifference % (1000 * 60 * 60)) / (1000 * 60));
                        var secondsDifference = Math.floor((timeDifference % (1000 * 60)) / 1000);
                        // 표시할 문자열 생성
                        var remainingTimeText = "경매남은시간 :" + hoursDifference + "시간 " + minutesDifference + "분 " + secondsDifference + "초";
                        // 결과를 HTML에 적용
                        remainingTimeElement.innerHTML = "";
                        remainingTimeElement.textContent = remainingTimeText;
                        // 버튼 업데이트
                    // 경매가 종료되었을 때 
                        if (timeDifference <= 0) {
                            if (lastBidNo == 0) {
                                remainingTimeElement.innerHTML = "유찰"; // 종료 메시지 표시
                            } else {
                                remainingTimeElement.innerHTML = "경매 종료"; // 종료 메시지 표시
                            }
                            clearInterval(intervalId); // 1초마다 실행되는 함수 중지
                        }
                    };


                    // 초기 호출
                    updateCurrentDate();

                    // 1초마다 updateCurrentDate 함수를 호출
                    var intervalId = setInterval(updateCurrentDate, 1000);


                    </script>	
                </table>
                </form>
            </c:if>
            </c:forEach>
        </c:forEach>
    </c:forEach>
</div>
<hr class="hr-styled">
<h3>경매 가구상품리스트</h3>
<div class="list-container">
    <c:forEach var="c" items="${list}">
        <c:forEach var="au" items="${au}">
        <c:forEach var="img" items="${imgList}">
        <c:if test="${c.category == 3 && c.no == img.productNo && c.no == au.productNo && c.endDate eq null}">
                        <form action="${ctx}/productContent.do"  method="post" class="myForm">
            	            	<input type="hidden" value="${user.no}" name="no">
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
                document.write('<tr><td><img src="' + parts[0] + '" alt="이미지" width="250" height="80" /></td></tr>');
            }
        </script>
    </c:when>
    <c:otherwise>
        <script>
            document.write('<tr><td><img src="img/unnamed.jpg" alt="이미지" width="250" height="80" /></td></tr>');
        </script>
    </c:otherwise>
</c:choose>
                    <tr><td>${c.title}</td></tr>
                    <tr><td>현재 입찰가 ${au.lastPrice}</td></tr>
         <tr><td><div class="remainingTime" data-auction-id="${au.productNo}"></div></td></tr>	
                                <script>
                    var lastBidDate = new Date("${au.lastBidDate}");
                    var lastBidNo = Number('${au.lastBidderNo}');
                    var endDate;
                    var remainingTimeElement = document.querySelector(`.remainingTime[data-auction-id="${au.productNo}"]`);
                    console.log(remainingTimeElement);
                    var updateCurrentDate = () => {
                        // 현재 시간
                        var currentDate = new Date();
                        if (lastBidNo == 0) {
                            endDate = new Date(lastBidDate.getTime() + 24 * 60 * 60 * 1000); // 초기
                        } else {
                            endDate = new Date(lastBidDate.getTime() + 3 * 60 * 60 * 1000); // 초기
                        }
                        timeDifference = endDate - currentDate;
                        var hoursDifference = Math.floor(timeDifference / (1000 * 60 * 60));
                        var minutesDifference = Math.floor((timeDifference % (1000 * 60 * 60)) / (1000 * 60));
                        var secondsDifference = Math.floor((timeDifference % (1000 * 60)) / 1000);
                        // 표시할 문자열 생성
                        var remainingTimeText = "경매남은시간 :" + hoursDifference + "시간 " + minutesDifference + "분 " + secondsDifference + "초";
                        // 결과를 HTML에 적용
                        remainingTimeElement.innerHTML = "";
                        remainingTimeElement.textContent = remainingTimeText;
                        // 버튼 업데이트
                    // 경매가 종료되었을 때 
                        if (timeDifference <= 0) {
                            if (lastBidNo == 0) {
                                remainingTimeElement.innerHTML = "유찰"; // 종료 메시지 표시
                            } else {
                                remainingTimeElement.innerHTML = "경매 종료"; // 종료 메시지 표시
                            }
                            clearInterval(intervalId); // 1초마다 실행되는 함수 중지
                        }
                    };


                    // 초기 호출
                    updateCurrentDate();

                    // 1초마다 updateCurrentDate 함수를 호출
                    var intervalId = setInterval(updateCurrentDate, 1000);


                    </script>
                </table>
                </form>
            </c:if>
        </c:forEach>
    </c:forEach>
    </c:forEach>
</div>
<hr class="hr-styled">
<h3>경매 기타상품리스트</h3>
<div class="list-container">
 <c:forEach var="c" items="${list}">
 <c:forEach var="au" items="${au}">
        <c:forEach var="img" items="${imgList}">
        <c:if test="${c.category == 0 && c.no == img.productNo && c.no == au.productNo && c.endDate eq null}">
                        <form action="${ctx}/productContent.do"  method="post" class="myForm">
            	            	<input type="hidden" value="${user.no}" name="no">
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
                document.write('<tr><td><img src="' + parts[0] + '" alt="이미지" width="250" height="80" /></td></tr>');
            }
        </script>
    </c:when>
    <c:otherwise>
        <script>
            document.write('<tr><td><img src="img/unnamed.jpg" alt="이미지" width="250" height="80" /></td></tr>');
        </script>
    </c:otherwise>
</c:choose>
                    <tr><td>상품 ${c.title}</td></tr>
                     <tr><td>현재 입찰가 ${au.lastPrice}</td></tr>
                    <tr><td><div class="remainingTime" data-auction-id="${au.productNo}"></div></td></tr>	
                    <script>
                    var lastBidDate = new Date("${au.lastBidDate}");
                    var lastBidNo = Number('${au.lastBidderNo}');
                    var endDate;
                    var remainingTimeElement = document.querySelector(`.remainingTime[data-auction-id="${au.productNo}"]`);
                    console.log(remainingTimeElement);
                    var updateCurrentDate = () => {
                        // 현재 시간
                        var currentDate = new Date();
                        if (lastBidNo == 0) {
                            endDate = new Date(lastBidDate.getTime() + 24 * 60 * 60 * 1000); // 초기
                        } else {
                            endDate = new Date(lastBidDate.getTime() + 3 * 60 * 60 * 1000); // 초기
                        }
                        timeDifference = endDate - currentDate;
                        var hoursDifference = Math.floor(timeDifference / (1000 * 60 * 60));
                        var minutesDifference = Math.floor((timeDifference % (1000 * 60 * 60)) / (1000 * 60));
                        var secondsDifference = Math.floor((timeDifference % (1000 * 60)) / 1000);
                        // 표시할 문자열 생성
                        var remainingTimeText = "경매남은시간 :" + hoursDifference + "시간 " + minutesDifference + "분 " + secondsDifference + "초";
                        // 결과를 HTML에 적용
                        remainingTimeElement.innerHTML = "";
                        remainingTimeElement.textContent = remainingTimeText;
                        // 버튼 업데이트
                    // 경매가 종료되었을 때 
                        if (timeDifference <= 0) {
                            if (lastBidNo == 0) {
                                remainingTimeElement.innerHTML = "유찰"; // 종료 메시지 표시
                            } else {
                                remainingTimeElement.innerHTML = "경매 종료"; // 종료 메시지 표시
                            }
                            clearInterval(intervalId); // 1초마다 실행되는 함수 중지
                        }
                    };


                    // 초기 호출
                    updateCurrentDate();

                    // 1초마다 updateCurrentDate 함수를 호출
                    var intervalId = setInterval(updateCurrentDate, 1000);


                    </script>
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