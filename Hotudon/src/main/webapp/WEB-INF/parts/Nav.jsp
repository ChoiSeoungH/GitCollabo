<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>카테고리 메뉴</title>
  <style type="text/css">
      #wrap {
          position: relative;
          width: 100%;
          height: 100vh;
      }
      #bar {
          width: 35px;
          height: 30px;
          display: flex;
          flex-direction: column;
          justify-content: space-between;
          cursor: pointer;
          position: absolute;
          right: 20px;
          top: 20px;
          z-index: 100;
      }
      #catrgory_text {
          position: absolute;
          right: 70px;
          top: 15px;
          text-align: right;
          background-color: #333;
          padding: 10px 20px;
          color: #fff;
          cursor: pointer;
          border-radius: 20px;
          font-weight: bold;
          transition: background-color 0.3s ease;
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
          top: 70px;
          right: 20px;
          width: 250px;
          background-color: #f0f0f0;
          border-radius: 10px;
          box-shadow: 0 8px 16px rgba(0,0,0,0.2);
          transform: translateY(-20px);
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
          transform: translateY(8px) rotate(45deg);
      }
      #bar.open .bar2 {
          opacity: 0;
      }
      #bar.open .bar3 {
          transform: translateY(-8px) rotate(-45deg);
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
