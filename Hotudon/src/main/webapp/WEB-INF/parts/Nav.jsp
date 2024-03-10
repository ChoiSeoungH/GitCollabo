<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>카테고리 메뉴</title>
  <style type="text/css">
      #wrap {
          position: fixed; /* 위치 고정 */
          top: 250px; /* 상단에서부터의 거리 */
          left: 0; /* 좌측에서부터의 거리 */
          width: 312px; /* 너비 설정 */
          height: 100vh; /* 화면 높이에 맞춤 */
          overflow-y: auto; /* 내용이 많을 경우 내부 스크롤 허용 */
          background-color: #e9ecef; /* 배경 색상 */
          padding: 20px; /* 내부 여백 */
      }
      #catrgory_text {
          display: flex; /* Flexbox 모델 사용 */
          justify-content: center; /* 가운데 정렬 */
          align-items: center; /* 세로 방향 가운데 정렬 */
          position: relative; /* 상대적 위치 설정 */
          background-color: #333;
          padding: 10px 20px;
          color: #fff;
          cursor: pointer;
          border-radius: 20px;
          font-weight: bold;
          transition: background-color 0.3s ease;
      }

      #bar {
          position: absolute; /* 절대 위치 */
          right: 10px; /* 오른쪽에서 10px 떨어진 곳에 위치 */
          top: 50%;
          transform: translateY(-50%); /* 세로 방향 중앙 정렬 */
          width: 35px;
          height: 30px;
          display: flex;
          flex-direction: column;
          justify-content: space-between;
          cursor: pointer;
          z-index: 100;
      }

      #catrgory_text:hover {
          background-color: #555;
      }
      .bar1, .bar2, .bar3 {
          width: 100%;
          height: 5px;
          background-color: #fff;
          transition: 0.3s;
      }
      #category {
          display: none;
          position: absolute;
          top: 82px; /* #catrgory_text 바로 아래에 위치, 여백 조정 */
          right: 0;
          left: 0; /* 좌우 정렬 */
          margin-right: auto;
          margin-left: auto;
          width: 250px; /* 너비 */
          background-color: #f0f0f0;
          border-radius: 10px;
          box-shadow: 0 8px 16px rgba(0,0,0,0.2);
          transform: translateY(0);
          transition: transform 0.5s ease, opacity 0.5s ease;
          opacity: 0;
      }


      #category.open {
          display: block;
          opacity: 1;
          transform: translateY(0);
      }
      .category {
          display: block;
          text-align: center;
          text-decoration: none;
          padding: 15px;
          color: #333;
          transition: background-color 0.2s ease;
      }
      .category:hover {
          background-color: #ddd;
      }
      #bar.open .bar1 {
          transform: translateY(12px) rotate(45deg);
      }
      #bar.open .bar2 {
          opacity: 0;
      }
      #bar.open .bar3 {
          transform: translateY(-12px) rotate(-45deg);
      }
  </style>
</head>
<body>
<div id="wrap">

  <h2 id="catrgory_text">카테고리
    <div id="bar">
      <div class="bar1"></div>
      <div class="bar2"></div>
      <div class="bar3"></div>
    </div>
  </h2>
  <div id="category">
    <div class="category" onclick="location.href='${ctx}/main.do'">전체</div>
    <div class="category">디지털</div>
    <div class="category">의류</div>
    <div class="category">가구</div>
    <div class="category">기타</div>
  </div>
</div>
<script>
  var bar = document.getElementById("bar");
  var categoryText = document.getElementById("catrgory_text");
  var category = document.getElementById("category");

  document.addEventListener("click", function(event) {
    if (event.target === categoryText || event.target === bar) {
      bar.classList.toggle("open");
      category.classList.toggle("open");
    }
  });
</script>
</body>
</html>
