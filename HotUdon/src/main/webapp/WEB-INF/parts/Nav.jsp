<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
#wrap{
	position: relative;
	width: 100%;
	height: 100%
	
}
#bar {
  width: 30px;
  height: 25px;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  cursor: pointer;
  position: absolute;
  right: -47px;
  top: 125px;
}
#catrgory_text{
  position: absolute;
  right: -147px;
  top: 95px;
  text-align: right;
  background-color: black;
  background-size: contain;
  padding: 10px 10px 10px 45px;
  color: #fff;
  cursor: pointer;
  border-radius: 10px;
}
.bar1, .bar2, .bar3 {
  width: 100%;
  height: 4px;
  background-color: #fff;
  transition: transform 0.3s ease;
  z-index: 2;
}
#category {
  display: none; /* 초기에는 숨김 */
  position: absolute;
  top: 110px;
  right: 0px;
	width: 80%;
	background-color: #eee;
  
}
#category .category {
	display: block;
	text-align: center;
	text-decoration: none;
	padding: 20px;
}
#category.open {
  display: block; /* h2 클릭시 나타나게 함 */
  
}
#bar.open .bar1 {
  transform: translateY(10px) rotate(45deg);
}

#bar.open .bar2 {
  opacity: 0;
}

#bar.open .bar3 {
  transform: translateY(-10px) rotate(-45deg);
}
</style>
</head>
<body>
    <div id="wrap">
      <div id="bar">
        <div class="bar1"></div>
        <div class="bar2"></div>
        <div class="bar3"></div>
      </div>
      <h2 id="catrgory_text">카테고리</h2>
      <div id="category">
        <div class="category" onclick="location.href='${ctx}/main.do'">전체</div>
        <div class="category">디지털</div>
        <div class="category">의류</div>
        <div class="category">가구</div>
        <div class="category">기타</div>
      </div>
    </div>
</body>
</html>
<script>
var bar = document.getElementById("bar");
var categoryText = document.getElementById("catrgory_text");

document.addEventListener("click", function(event) {
  if (event.target === categoryText) {
    if (bar.classList.contains("open")) {
      bar.classList.remove("open");
      category.classList.remove("open");
    } else {
      bar.classList.add("open");
      category.classList.add("open");
    }
  }
});
</script>
