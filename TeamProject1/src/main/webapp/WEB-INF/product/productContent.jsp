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
}

.Content {
	text-align: center;
	border: 0;
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

#myTd>.btn {
	width: 10px;
	height: 10px;
	border-radius: 50%; /* 동그라미를 만들기 위한 속성 */
	border: none;
	background-color: #808080;
	cursor: pointer;
}
.prevent-multiple-clicks {
    pointer-events: none;
}
</style>

<head>
<meta charset="UTF-8">
<title>상품제목</title>
</head>
<body>
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
	</c:forEach>
	</c:if>
	
	
<!-- 옥션일 경우 -->	
	<c:if test="${auction eq true}">

	
	<c:forEach var="vo" items="${vo}">
	<c:forEach var="au" items="${au}">
	
	<h3 align="center">상품 : ${vo.title}</h3>
	<form action="${ctx}/productUpdate.do" method="post">
		<table align="center" border=1>
		<input type="hidden" name="no" value="${vo.no }" >
		<tr>	<td id="myTd">
		</td>
			
			</tr>
		
			<tr class="space">
				<td>현재입찰가 :
				 ${au.lastPrice}원
				
				
				</td>
			</tr>
			
			<tr class="space">
	<td><div id="remainingTime"></div>
<script>
  const lastBidDate = new Date(au.lastBidDate);
  let currentDate = new Date(lastBidDate.getTime() + 3 * 60 * 60 * 1000);

  // 1초마다 실행되는 함수
  const updateCurrentDate = () => {
    currentDate = new Date(currentDate.getTime() - 1000); // 1000밀리초는 1초

    // 표시할 문자열 생성
    const hoursDifference = Math.floor((currentDate - lastBidDate) / (1000 * 60 * 60));
    const minutesDifference = Math.floor((currentDate - lastBidDate) % (1000 * 60 * 60) / (1000 * 60));
    const secondsDifference = Math.floor((currentDate - lastBidDate) % (1000 * 60) / 1000);
    const remainingTimeText = `경매남은시간 : ${hoursDifference}시간 ${minutesDifference}분 ${secondsDifference}초`;

    // 결과를 HTML에 적용
    document.getElementById('remainingTime').textContent = remainingTimeText;
  };

  // 1초마다 updateCurrentDate 함수를 호출
  const intervalId = setInterval(updateCurrentDate, 1000);
</script>
				</td>
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
				<input type="button"  class="prevent-multiple-clicks" value="+10% 입찰하기" onclick=""> 
					<input  class="prevent-multiple-clicks" type="button"  value="+50% 입찰하기" onclick=""> 
					<input  class="prevent-multiple-clicks" type="button" value="+100% 입찰하기" onclick=""> 
					<input class="prevent-multiple-clicks"  type="button" value="메인으로" onclick="location.href='${ctx}/main.do'"></td>
			</tr>
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


