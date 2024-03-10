<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../Main.jsp" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="user" value="${user}"/>
<c:set var="nick" value="${nick}"/>
<!DOCTYPE html>
<html>
<style>
table {
	width: 500px;
	height: 400px;
}

textarea {
	text-align: center;
	width: 500px;
	height: 200px;
}
tr{
	text-align:center;
		border:0;
}

.Content {
	text-align: center;
	border: 0;
}

td{
	text-align:center;
		border:0;
}
#remainingTime{
	text-align:center;
	color:red;
	border:0;
}


.input {
	width: 300px;
	text-align: center;
}
.space {
  display: flex;
  justify-content: space-between;
  align-items: center; /* 추가로 수직 가운데 정렬도 가능하도록 설정 */
}
.search{
	text-align:center;
}
.search>query{
	width:300px;
	height:100px;
}
 
   img{
 width:50px;
 height:50px;
 }
.list {
margin-right: 10px;
	width:100px;
	height:200px;
	border:1px;

}

#myTd>.btn {
	width: 10px;
	height: 10px;
		border-radius: 50%; /* 동그라미를 만들기 위한 속성 */
	border: none;
	background-color: #808080;
	cursor: pointer;
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
tr{
border: 1px solid #ccc;

}
td{
border: 1px solid #ccc;
}

.close-button {
  position: absolute;
  top: 5px;
  right: 5px;
  cursor: pointer;
  font-size: 18px;
  color: #000; /* x 버튼 색상 */
}

.product{
 margin-right: 20px;
	text-align:center;
  background-color: white;
    border: 3px solid transparent;
    border-radius: 50%;
    border-image: linear-gradient(to right, red 0%, orange 100%);
    border-image-slice: 1;
     margin: 0 auto;

}
.btn1{
 margin-right: 20px;
	text-align:center;
  background-color: white;
    border: 3px solid transparent;
    border-radius: 50%;
    border-image: linear-gradient(to right, red 0%, orange 100%);
    border-image-slice: 1;

}

</style>
<head>
<meta charset="UTF-8">


<title>상품제목</title>
</head>
<body>

<form action="${ctx}/productSearch.do" method="get" class="search">
<input class="query" placeholder="검색어 입력" type="text" name="query">

<input type=submit value="검색">
</form>
	


<!-- 옥션이 아닐 경우 -->
<div class="s">
    <c:if test="${auction ne true }">
        <h3 align="center">상품 : ${vo.title}</h3>
        <form action="${ctx}/productUpdate.do" method="post">
            <table class="product">
                <input type="hidden" name="ProductNo" value="${vo.no}">
                <input type="hidden" value="${user.no}" name="no">
                <tr>
                    <td id="myTd">
                    </td>
                </tr>
                <tr>
                    <c:if test="${vo.sellerNo!=user.no && vo.buyerNo == 0 }">
                        <td class="space">상품가격 : 
                            ${vo.price }원
                            <end><input type="button" class="btn1" value="결제하기" onclick="processPayment()"></end></td>
                    </c:if>
                    <c:if test="${vo.sellerNo==user.no }">
                        <td class="space">상품가격 : 
                            ${vo.price }원
                            <end><h4>판매자(본인) 상품입니다</h4></end>
                            <input type="button" class="btn1" value="수정하기" onclick="location.href='${ctx}/productUpdate.do?productNo=${vo.no}&check=1&no=${user.no}'"></td>
                    </c:if>
                    <c:if test="${vo.sellerNo!=user.no && vo.buyerNo != 0 }">
                        <td><h4>판매가 종료된 상품입니다</h4></td>
                    </c:if>
                </tr>
                <tr>
                    <td class="space">판매자 : ${bo.nickname}
                        <end>판매자위치: ${vo.sellLocation}</end>
                    </td>
                </tr>
                <tr>
                    <td>거래방법 :
                        <c:if test="${vo.productMethod == 0 }">직거래</c:if>
                        <c:if test="${vo.productMethod == 1 }">택배</c:if>
                        <c:if test="${vo.productMethod == 2 }">퀵서비스</c:if>
                        <c:if test="${vo.productMethod == 3 }">상관없음</c:if>
                    </td>
                </tr>
                <tr>
                    <td class="Content">상품정보
                        <hr>
                    </td>
                </tr>
                <tr>
                    <td><textarea style="height:150px;" readonly>${vo.description}</textarea></td>
                </tr>
                <tr>
                    <td style="text-align: center; padding: 10px;">
                        <input type="button" class="btn1" value="뒤로가기" onclick="window.history.back()">
                        <input type="button" class="btn1" value="메인으로" onclick="location.href='${ctx}/main.do'">
                    </td>
                </tr>
            </table>
        </form>
        <div class="fixed" id="fixedContainer">
        <div class="close-button" onclick="hideFixedContainer()">x</div>
            <div class="list-container">
                <h5>네이버 최저가 연관검색어</h5>
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
    </c:if>
</div>
<script>
  function hideFixedContainer() {
    var fixedContainer = document.getElementById('fixedContainer');
    fixedContainer.style.display = 'none';
  }
</script>
	
<!-- 옥션일 경우 -->	
	<c:if test="${auction eq true}">
<div class="t">	
	<h3 align="center">상품 : ${vo.title}</h3>
	<form action="${ctx}/productUpdate.do" method="post">
		<table align="center" class="product">
		<tr>	<td id="myTd">
		</td>
			
			</tr>
		
			<tr class="space">
				<td id="result">현재입찰가 :
				 ${au.lastPrice}원
				</td>
				<td id="expectation">입찰가격예상 : 원</td>
	
			</tr>
			
			<tr class="space">
	<td id="remainingTime">
			<!--  밑에 if문 주기 -->
	<c:if test="${au.lastBidderNo == 0 }">
			<td>현재 입찰자 없음</td> 
				</c:if>
	<c:if test="${au.lastBidderNo != 0 }">			
	<td>현재 입찰자:${nick.nickname}</td> 
				</c:if>		
			</tr>
			<tr>
			<c:if test="${vo.sellerNo != user.no && user.no != au.lasetBidderNo}">
				<td><input type="button" class="prevent"  id="btn10" value="+10% 입찰하기" onclick="bidmoney(10)"> 
					<input type="button" class="prevent"  id="btn50"   value="+50% 입찰하기" onclick="bidmoney(50)"> 
					<input type="button"  class="prevent" id="btn100"   value="+100% 입찰하기" onclick="bidmoney(100)"></td> 
			</c:if>
			<c:if test="${vo.sellerNo == user.no}">
				<td><h3>판매자는 입찰을 하실수 없습니다</h3></td> 
			</c:if>
				<c:if test="${au.lastBidderNo == user.no}">
				<td><h3>현재 최고 입찰자이십니다</h3></td> 
			</c:if>
			</tr>
			<tr>
				<td class="Content">상품정보
					<hr>
				</td>
			</tr>
			<tr>
				<td><textarea width="400"  readonly>${vo.description }</textarea></td>
			</tr>
			
			<tr>
	
				<td style="text-align: center; padding: 10px;">
					<c:if test="${vo.sellerNo != user.no }" >
					<input type="button" class="btn1" value="입찰신청" onclick="submitBid()">
 					</c:if>
 					<input type="button" class="btn1" value="메인으로" onclick="location.href='${ctx}/main.do'"></td>
			</if> 
			</tr>
		</table>
        <div class="fixed" id="fixedContainer1">
        <div class="close-button" onclick="hideFixedContainer1()">x</div>
<h5>경매 관련 카테고리</h5>
	<c:forEach var="list" items="${list}">
 	<c:forEach var="auList" items="${auList}">
 	<c:forEach var="imgList" items="${imageList}">
 	<c:if test="${list.no==auList.productNo && imgList.productNo == list.no}">
 <form action="${ctx}/productContent.do"  method="post" class="myForm">
             	<input type="hidden" value="${user.no}" name="no">
<input type="hidden" value="${list.no}" name="productNo">
<input type="hidden" value="${list.auction}" name="auction">
<input type="hidden" value="${list.title}" name="query">
<table class= "list">
<tr>
<c:if test="${list.no == imgList.productNo}"> 
<c:choose>
    <c:when test="${not empty imgList.imageUrl}">
        <script>
            // 이미지 URL
            var card = "img/${imgList.imageUrl}";

            // URL에서 파일 이름 추출
            var parts = card.split(",");
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
</c:if>
</tr>
<tr>
<c:if test="${list.no == auList.productNo}" >
<td>현재입찰가 : ${auList.lastPrice }</td>
</c:if>
</tr>
</table>            
</form>
</c:if>
</c:forEach>
</c:forEach>
</c:forEach>
</div>
<script>
function hideFixedContainer1() {
    var fixedContainer = document.getElementById('fixedContainer1');
    fixedContainer.style.display = 'none';
  }
</script>
</div>
		
	</form>
</div>	
	</c:if>
	
</body>
</html>
<c:forEach var="img" items="${img}">
<script type="text/javascript">
var imageUrl = "${img.imageUrl}"; 
const recentBid = Number('${au.lastPrice}');
const lastBidDate = new Date("${au.lastBidDate}");
let  lastBidNo = Number('${au.lastBidderNo}');
let endDate;
const elementsToRemove = document.querySelectorAll('.prevent');
const resultElement = document.querySelector('#expectation');
let selectedBidAmount;
let cash=Number('${user.cash}');
let user=('${user.no}');
let productPrice = Number('${vo.price}');
let seller=('${vo.sellerNo}');
let aus = ('${auction}');
let product = ('${vo.no}');

	 function processPayment(){
		    if(productPrice>cash){
		    	alert('현재 소지하신 금액이 제품금액보다 적습니다');
		    	return
		    }
		
		        fetch('auctionBid.do', {
		            method: 'POST',
		            headers: {
		                "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8",
		            },
		            body: "product=" + product  + "&no=" + user +"&productPrice=" +productPrice +"&seller=" + seller,  //아이디값 넘기기
		        })
		        .then(response => response.text())
		        .then(() => {
					// 여기에 다음 화면으로 이동하는 코드 추가
				alert("상품 구매 성공하셨습니다");	
				window.location.href =	'${ctx}/productList.do';
				})
		        
		        .catch(() => alert("error"));
		 
	 }




if(imageUrl){
		var parts = imageUrl.split(",");
		var fileName = parts[parts.length - 1];
		for(var i=0; i<parts.length; i++){
			var image = document.createElement("img");
			var button = document.createElement("button");
			button.classList.add("btn");
			button.style.position="absolute";
			button.style.top = "380px";
			button.style.left = 730+(i*20)+"px";
			var myTd = document.getElementById("myTd");
			image.alt="";
			image.style.width ="500px";
			image.style.height= "300px";
			image.src= "img/"+parts[i];
			image.style.display ='none';
			
			   (function(i) {
			        button.addEventListener("click", function(event) {
			            // 이미지를 변경하는 로직
			            image.src = "img/" + parts[i];
			            image.style.display = 'inline-block';
			            var firstImage = myTd.querySelector('img');
			            firstImage.style.display = 'none';
			            event.preventDefault();
			            return false;
			        });
			    })(i);
			
			myTd.appendChild(image);
			myTd.appendChild(button);
		}

        var firstImage = myTd.querySelector('img');
        if (firstImage) {
            firstImage.style.display = 'inline-block';
        }
	}else{
	var image = document.createElement("img");
	var myTd = document.getElementById("myTd");
	image.alt="";
	image.style.width ="500px";
	image.style.height= "300px";
	image.src= "img/unnamed.jpg";
	myTd.appendChild(image);
	}
	
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
     
    
		function bidmoney(money){
			var  w = money / 100;	
			const bid =w*(recentBid) +recentBid
			selectedBidAmount = Math.round(bid);
			
			 resultElement.innerHTML = '입찰가격예상 : '+ selectedBidAmount +'원'
			var buttonId = "btn" + money; 
		    var clickedButton = document.getElementById(buttonId);

		 
		    clickedButton.style.backgroundColor = "red";  


		    var allButtons = document.querySelectorAll('.prevent');
		    allButtons.forEach(function(button) {
		        if (button.id !== buttonId) {
		            button.style.backgroundColor = ""; 
		        }
		    });

		    
			
			  
			}
		function submitBid() {
		    if (!selectedBidAmount) {
		        alert('입찰 금액을 선택해주세요.');
		        return;
		    }
		    if(Number(selectedBidAmount)>cash){
		    	alert('현재 소지하신 금액이 입찰금액보다 적습니다');
		    	return
		    }
		
		        fetch('auctionBid.do', {
		            method: 'POST',
		            headers: {
		                "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8",
		            },
		            body: "bidAmount=" + selectedBidAmount +"&product=" + product  + "&no=" + user,  //아이디값 넘기기
		        })
		        .then(response => response.text())
		        .then(() => {
					// 여기에 다음 화면으로 이동하는 코드 추가
				alert("경매 입찰에 성공하셨습니다");	
				window.location.href =	'${ctx}/productList.do';
				})
		        
		        .catch(() => alert("error"));
		
		    }
		
		
		
		const updateCurrentDate = () => {
			// 현재 시간
		  const currentDate = new Date();
			if(lastBidNo == 0){
			endDate = new Date(lastBidDate.getTime() + 24 * 60 * 60 * 1000); // 초기
			}else {
			endDate = new Date(lastBidDate.getTime() + 3 * 60 * 60 * 1000); // 초기
			}
			const timeDifference = endDate - currentDate;
		  var hoursDifference = Math.floor(timeDifference / (1000 * 60 * 60));
		  var minutesDifference = Math.floor((timeDifference % (1000 * 60 * 60)) / (1000 * 60));
		  var secondsDifference = Math.floor((timeDifference % (1000 * 60)) / 1000);
		  // 표시할 문자열 생성
		  var remainingTimeText = "경매남은시간 :" +hoursDifference + "시간 "+minutesDifference+"분 "+secondsDifference+"초";
		  // 결과를 HTML에 적용
		 document.getElementById('remainingTime').innerHTML = "";
		document.getElementById('remainingTime').textContent = remainingTimeText;

		  // 경매가 종료되었을 때 처리
		  if (timeDifference <= 0) {
			  document.getElementById('remainingTime').innerHTML = "경매 종료"; // 종료 메시지 표시
			  elementsToRemove.forEach(element => {
			      element.remove();
			    });
			  
			  clearInterval(intervalId); // 1초마다 실행되는 함수 중지
		  
		  }
		};
		// 초기 호출
		updateCurrentDate();
		
		// 1초마다 updateCurrentDate 함수를 호출
		const intervalId = setInterval(updateCurrentDate, 1000);
	    
	
	
</script>
</c:forEach>


