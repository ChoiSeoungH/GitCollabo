<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
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
  .list-container {
        display: flex;
    justify-content: center; 
    align-items: center; 
    position: fixed;
    bottom: 0;
    width: 50%; 
    background-color: #f1f1f1;
    padding: 5px;
    text-align: center;
	height: 100px;
      }
   img{
 width:50px;
 height:50px;
 }
.list {
margin-right: 10px;
	width:100px;
	height:300px;
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
 display: flex;
    background-color: #f1f1f1;
    padding: 5px;
    text-align: center;
      justify-content: center; 
    align-items: center; 
    position: fixed;
    bottom: 0;
    width: 50%;
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
<c:if test="${auction ne true }">
<c:forEach var="vo" items="${vo}">
	<h3 align="center">상품 : ${vo.title}</h3>
	<form action="${ctx}/productUpdate.do" method="post">
		<table align="center" border=1>
		<input type="hidden" name="no" value="${vo.no }" >
	<tr>	
		<td id="myTd">
		</td>
			
			</tr>
			<tr>
				<td class="space">상품가격 : 
				 ${vo.price }원
				 
				 <end><input type="button" value="채팅하기" onclick=""></end>
				</td>
			</tr>
			<tr>
				<td>거래방법 :
				<c:if test="${vo.productMethod == 0 }">
						직거래
						</c:if>
				<c:if test="${vo.productMethod == 1 }">
						택배	
						</c:if>
				<c:if test="${vo.productMethod == 2 }">
					다른 서비스
						</c:if>
			<c:if test="${vo.productMethod == 3 }">
					상관없음
						</c:if>
						</td> 
			</tr>

			<tr>
				<td class="Content">상품정보
					<hr>
				</td>
			</tr>
			<tr>
				<td><textarea style="height:150px;"  readonly>${vo.description }</textarea></td>
			</tr>
			<tr>
				<td style="text-align: center; padding: 10px;">
				<input type="button" value="뒤로가기" onclick="window.history.back()">
				<input type="button" value="메인으로" onclick="location.href='${ctx}/main.do'"></td>
			</tr>
		</table>
	</form>
	<hr>
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
	</c:forEach>
	</c:if>
	
	
<!-- 옥션일 경우 -->	
	<c:if test="${auction eq true}">

	
	<c:forEach var="vo" items="${vo}">
	<c:forEach var="au" items="${au}">
	
	<h3 align="center">상품 : ${vo.title}</h3>
	<form action="${ctx}/productUpdate.do" method="post">
		<table align="center" border=1>
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

				</td>
			</tr>
			<tr>
				<td><input type="button" class="prevent"  id="btn10" value="+10% 입찰하기" onclick="bidmoney(10)"> 
					<input type="button" class="prevent"  id="btn50"   value="+50% 입찰하기" onclick="bidmoney(50)"> 
					<input type="button"  class="prevent" id="btn100"   value="+100% 입찰하기" onclick="bidmoney(100)"></td> 
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
		<%-- 	<if test="${vo.sellerNo != }"> userNo같지않을경우에만 생성	 --%>	
				<td style="text-align: center; padding: 10px;">
					<input type="button" value="입찰신청" onclick="submitBid()">
 					<input type="button" value="메인으로" onclick="location.href='${ctx}/main.do'"></td>
			</if> 
			</tr>
				<%-- 	<if test="${vo.sellerNo == }"> userNo같지않을경우에만 생성		
				<td style="text-align: center; padding: 10px;">
					<h4>판매자 본인은 입찰이 불가능합니다.</h4>
 					<input type="button" value="메인으로" onclick="location.href='${ctx}/main.do'"></td>
			</if> --%>
			
			<script>
			const recentBid = Number('${au.lastPrice}');
			const lastBidDate = new Date("${au.lastBidDate}");
			const endDate = new Date(lastBidDate.getTime() + 3 * 60 * 60 * 1000);
			const elementsToRemove = document.querySelectorAll('.prevent');
			const resultElement = document.querySelector('#expectation');
			const no = ('${vo.no}');
			let selectedBidAmount;
			
			function bidmoney(money){
				var  w = money / 100;	
				const bid =w*(recentBid) +recentBid
				selectedBidAmount = bid;
				
				 resultElement.innerHTML = '입찰가격예상 : '+ bid +'원'
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
				console.log(selectedBidAmount);
			        fetch('auctionBid.do', {
			            method: 'POST',
			            headers: {
			                "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8",
			            },
			            body: "bidAmount=" + selectedBidAmount +"&no=" + no + "&id=" + "1",  //아이디값 넘기기
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

			  // 남은 시간 계산
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
		</table>
	</form>
	</c:forEach>
	</c:forEach>
	</c:if>
	
</body>
</html>
<c:forEach var="img" items="${img}">
<script type="text/javascript">
var imageUrl = "${img.imageUrl}";
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
	
</script>
</c:forEach>


