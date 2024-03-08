<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="list" value="${list}"/>
<c:set var="user" value="${user}"/>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
 <style>
 body {
  display: grid;

  place-items: center;
  margin: 0;
}
    .container {
      width: 700px;
      height: 200px;
      border: 1px solid black;
      border-radius: 30px;
      margin: auto 0;
      display: flex;
      
    }

a{
      width: 30%;
      border: 1px solid black;
      border-radius: 10px;
      padding: 10px;
    }

    .content {
      width: 50%;
      display: flex;
      flex-direction: column;
      justify-content: space-evenly;
      padding: 20px;
    }
    #btns {
      width: 20%;
      display: flex;
      flex-direction: column;
      justify-content: space-evenly;
    }

    #btns .btn {
      width: 70%;
      height: 30px;
      border: none;
    }

    #btns .btn:hover {
      background-color: #d9d9d9;
    }
 .remainingTime{
	color:red;
}
  </style>
</head>

<body>
<c:if test="${list.size()==0 }">
<h3>판매 상품이 존재하지 않습니다</h3>
</c:if>
<c:if test="${list.size()!=0 }">
<c:forEach var="img" items="${img}">
<c:forEach var="vo" items="${list}">

<c:if test="${vo.no == img.productNo }">
			<%-- 	<input type="hidden" value="${vo.sellerNo}" name="no">
            	<input type="hidden" value="${vo.no}" name=roductNo">
              <input type="hidden" value="${vo.auction}" name="auction"> --%>
  <div class="container">
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
                document.write('<a><img src="' + parts[0] + '" alt="이미지" width="100%" height="100%"/> </a>');
            }
        </script>
    </c:when>
    <c:otherwise>
        <script>
            document.write('<a><img src="img/unnamed.jpg" alt="이미지" width="100%" height="100%" /></a>');
        </script>
    </c:otherwise>
</c:choose>
    <div class="content">
      <div class="title">제목 : ${vo.title}</div>
      <c:if test="${vo.auction ==false}">
      <div class="price">가격 ${vo.price}</div>
    <div class="reg_data">등록일 :${vo.regDate}</div>	
      	<c:if test="${vo.endDate == null}">	
      <div class="reg_data">판매중</div>
      </c:if>
      <c:if test="${vo.endDate != null}">
      <div class="reg_data">판매종료일 :${vo.endDate}</div>
      </c:if>
      </c:if>
   
            <c:if test="${vo.auction == true }">
      <c:forEach var="au" items="${au}">
        <c:if test="${vo.no == au.productNo}">
      <div class="price">입찰가 : ${au.lastPrice}</div>
  <div class="remainingTime" data-auction-id="${au.productNo}"></div>
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
            endDate = new Date(lastBidDate.getTime() + 1 * 60 * 60 * 1000); // 초기
        } else {
            endDate = new Date(lastBidDate.getTime() + 1 * 60 * 60 * 1000); // 초기
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
      </c:if>
  
    </div>
        <div id="btns">
   <button class="btn" type="button" onclick="location.href='${ctx}/productUpdate.do?productNo=${vo.no}&check=1&no=${user.no}'">수정</button>
      <button class="btn" type="button" onclick="location.href='${ctx}/productUpdate.do?productNo=${vo.no}&check=2&no=${user.no}'">삭제</button>
     <button class="btn" type="button" onclick="location.href='${ctx}/productUpdate.do?productNo=${vo.no}&check=3&no=${user.no}'">재등록</button>
    </div>
  </div>
  </c:if>
  </c:forEach>
  </c:forEach>
  </c:if>
</body>

</html>