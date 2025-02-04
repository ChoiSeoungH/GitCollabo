<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<style>

.search{
	text-align:center;
}
.search>query{
	width:300px;
	height:100px;
}

.list {
	width:100px;
	height:300px;
	border:1px;
    margin: auto;

}
 img{
 width:100px;
 height:100px;
 }

product_listitem li {
    display: flex;
    align-items: center;
}

.prdImg {
    margin-right: 10px; /* Adjust the margin as needed */
}

.text-details {
    flex: 1;
}

.prdName {
    display: inline-block;
    margin-right: 10px; /* Adjust the margin as needed */
}

.remainingTime{
	color:red;
}
.productList{
	diplay: flex;
	align-items: center;
	border: 1px solid #000;
    margin: auto;

}
.fixed {
        position: fixed;
        bottom: 0;
        left: 25%; /* 가운데 정렬을 위한 조정 값 */
        width: 50%;
        height:200px;
        background-color: #fff; /* 배경색을 필요에 따라 지정하세요. */
        border: 1px solid #ccc; /* 테두리를 필요에 따라 지정하세요. */
        padding: 0px; /* 내용과의 여백을 필요에 따라 지정하세요. */
    }

    .list-container {
    	display:flex;
        text-align: center; /* 내용 가운데 정렬을 위한 스타일 */

    align-items: center; /* 내용을 가운데 정렬하기 위한 스타일 추가 */
    }

</style>
<html>
<body>

<c:if test="${vo.size()==0}">
<h1 style="text-align:center">${query} 검색한 제품히 현재 존재하지 않습니다</h1>
</c:if>

<c:if test="${vo.size()!=0 }">

<c:forEach var="img" items="${img}">
<c:forEach var="c" items="${vo}">
     <c:if test="${c.no == img.productNo && c.endDate eq null && c.buyerNo == 0}">
    	<form action="${ctx}/productContent.do" method="post" class="myForm">
    	<input type="hidden" value="${c.no}" name="productNo">
        <input type="hidden" value="${c.title}" name="query">
       <input type="hidden" value="${c.auction}" name="auction">
<div module="product_recentlist" class="productList" style="display: flex; align-items: center;  border: 1px solid #000; margin-bottom: 10px; width:600px; height:200px">
    <div class="prdImg">
    <a>
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
                document.write('<tr><td><img src="' + parts[0] + '" alt="이미지" width="200" height="200" /></td></tr>');
            }
        </script>
    </c:when>
    <c:otherwise>
        <script>
            document.write('<tr><td><img src="img/unnamed.jpg" alt="이미지" width="200" height="200" /></td></tr>');
        </script>
    </c:otherwise>
</c:choose> 	
       
        </a>
    </div>
    <div class="text-details" style="margin-left: 10px;"> <!-- 이미지와의 간격을 조절할 수 있도록 margin-left를 추가 -->
 
        <ul module="product_setproduct" class="item">
            	<c:if test="${c.auction == true}">
    	<h3><strong>경매상품</strong></h3>
    	</c:if>
    	<c:if test="${c.auction == false}">
    	<h3><strong>일반상품</strong></h3>
    	</c:if>
            <li>상품 제목 : ${c.title}</li>
            <li>판매자 위치: ${c.sellLocation}</li>
        	<c:if test="${c.auction == false}">
        <li class="price">상품 가격 ${c.price}</li>
        </c:if>
        
        <c:if test="${c.auction == true}">
        <c:forEach var="au" items="${au}">
        	<c:if test="${c.no == au.productNo}">
        <li class="price">현재 입찰가: ${au.lastPrice}</li>
        <li class="remainingTime" data-auction-id="${au.productNo}"></li>
 <script>
    var lastBidDate = new Date("${au.lastBidDate}");
    var lastBidNo = Number('${au.lastBidderNo}');
    console.log('${au}');
    console.log('${img}');
    console.log('${vo}');
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
        var timeDifference = endDate - currentDate;
        var hoursDifference = Math.floor(timeDifference / (1000 * 60 * 60));
        var minutesDifference = Math.floor((timeDifference % (1000 * 60 * 60)) / (1000 * 60));
        var secondsDifference = Math.floor((timeDifference % (1000 * 60)) / 1000);
        // 표시할 문자열 생성
        var remainingTimeText = "경매남은시간 :" + hoursDifference + "시간 " + minutesDifference + "분 " + secondsDifference + "초";
        // 결과를 HTML에 적용
       	remainingTimeElement.innerHTML = "";
    	remainingTimeElement.textContent = remainingTimeText;

        // 경매가 종료되었을 때 처리
        if (timeDifference <= 0) {
        	if(lastBidNo==0){
        		remainingTimeElement.innerHTML = "유찰"; // 종료 메시지 표시
        	}else{
        		remainingTimeElement.innerHTML = "경매 종료"; // 종료 메시지 표시	
        	}
        	
            elementsToRemove.forEach(element => {
                element.remove();
            });

            clearInterval(intervalId); // 1초마다 실행되는 함수 중지
        }
    };
    // 초기 호출
    updateCurrentDate();

    // 1초마다 updateCurrentDate 함수를 호출
    var intervalId = setInterval(updateCurrentDate, 1000);
</script>
        </c:if>
        </c:forEach>
        </ul>
        </c:if>
	</div>
</div>
</form>
</c:if>
</c:forEach>
</c:forEach>

</c:if>

<div class="fixed">

<div class="list-container">
<h5>네이버 최저가 연관검색어 ${query}</h5>
<c:forEach var="na" items="${naver.items}">
<a href="${na.link}" target="_blank">
<table class="list">
<tr>
   <td><img src="${na.image}"></td>
</tr>
<tr>
 <td>${na.lprice}원</td>
</tr>
</table>
</a>
</c:forEach>
</div>
</div>


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