<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../Main.jsp" %>

  <style>
    #container{
      width: 700px;
      height: 200px;
      border: 1px solid black;
      border-radius: 30px;
      margin: auto 0;
      display: flex;
    }
    #product_img{
      width: 30%;
      border: 1px solid black;
      border-radius: 10px;
      padding: 10px;
    }
    #content{
      width: 50%;
      display: flex;
      flex-direction: column;
      justify-content: space-evenly;
      padding: 20px;
    }
    #content .title{}
    #content .price{}
    #content .reg_date{}
    #content .remaining_time{}
    #btns{
      width: 20%;
      display: flex;
      flex-direction: column;
      justify-content: space-evenly;
    }
    #btns .btn{
      width: 70%;
      height: 30px;
      border: none;
    }

    #btns .btn:hover{
      background-color: #d9d9d9;
    }

  </style>
  
  <div id="container">
    <a id="product_img"><img src="">이미지</a>
    <div id="content">
      <div class="title">타이틀</div>
      <div class="price">가격</div>
      <div class="reg_data">등록시간</div>
      <div class="remaining_time">경매남은시간</div>
    </div>
    <div id="btns">
      <button class="btn" type="button" >수정</button>
      <button class="btn" type="button" >삭제</button>
      <button class="btn" type="button" >재등록</button>
    </div>
  </div>	
