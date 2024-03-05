<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<c:set var="total_cash" value="${ user.cash }"/> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
    .cash_modal{
   	/* border: 1px solid black; */
   	border-radius: 10px;
   	width: 400px;
   	height: 500px;
   	margin: auto;
   	text-align: center;
   	background-color: #fff;
   	position: absolute;
   	top: 50%;
   	left: 50%;
   	transform: translate(-50%, -50%);
   	visibility: visible;
   	opacity: 1;
   	z-index: 2;
    }
    .hidden{
    	visibility: hidden;
    	opacity: 0;
    }	
    #deposit,#withdraw{
		border: none;
		background-color: #fff;
		style: none;
	}
	#cash_num{
		width: 70%;
		display: flex;
		margin: 0 auto 30px 40px;
		flex-direction: row;
		height: 40px;
		box-sizing: border-box;
		justify-content: center; /* 수평 가운데 정렬 */
    	align-items: center; /* 수직 가운데 정렬 */
	}
	#cash_num #modal_header_h4{
	    align-items: center;        
    	width: 50%;
    	height: 100%;
    	display: flex; /* 중앙 정렬을 위해 추가 */
    	justify-content: center; /* 가운데 정렬을 위해 추가 */
		
	}
	#cash_num #cash_input{
		border: none;
		border-bottom: 1px solid black;
		width: 50%;
		text-align: right;
		align-items: center;		
	}
	.underBar{
		border-bottom: 2px solid skyblue;
		/* background-color: skyblue; */
	}
	#add_btn{
		width: 70%;
		margin: 0 auto;
	}
	#add_btn .add_btn{
		width: 30%;
	}
	#payment{
		width: 80%;
		margin: 0 auto;
		
	}
	#payment .payment{
		width: 30%;
		height: 40px;
		margin: 40px 3px;
		border: none;
	}
	.selected{
		background-color: orange;
	}
	#modal_deposit{
		display: block;
	}
	#modal_withdraw{
		display: none;
	}
	#total{
		width: 70%;
		display: flex;
		margin: 0 auto;
		flex-direction: row;
		text-size: 2em;
	}
	#total #modal_header_h4{
		align-items: center;		
		width: 40%;
	}
	#total .total_cash{
		width: 60%;
		text-align: center;
	}
	#submit{
		margin-top: 10px;
		width: 100%;
		height: 40px;
		border: none;
		position: absolute;
 		bottom: 0;
 		left: 0;
	}
	#submit:hover{
		background-color: #ccc;
	}
</style>
</head>
<body>
  <div class="cash_modal hidden">
  	<table id="modal_log">
	<tr>
	<td class="modal_td deposit underBar"> <button id="deposit" onclick="withdrawBtn()"> 충전하기</button> </td>
	<td class="modal_td withdraw "> <button id="withdraw" onclick="depositBtn()">출금하기</button> </td>
	</tr>
	</table>
    <div id="modal_deposit">
    <form action="${ ctx }/cashUpdate.do" method="post">
    	<input type="hidden" name="no" value="${ user.no }"/>
      <div id="modal_header">
        <br><h3> 우동 캐시 충전 </h3><br><br>
      </div>
      <div id="cash_num">
      <h4 id="modal_header_h4">충전할 캐시</h4>
      <input id="cash_input" type="number" min="0" name="cash_update" value=0 step="1000" onchange="addCash()"/><br>
      </div>
      <div id="add_btn">
      <input class="add_btn" type="button" value="+ 1,000" onclick="add1000()"/>
      <input class="add_btn" type="button" value="+ 5,000" onclick="add5000()"/>
      <input class="add_btn" type="button" value="+ 10,000" onclick="add10000()"/>
      </div>
      <div id="total">
        <h4 id="modal_header_h4">충전 후 내 캐시</h4>
        <h4 class="total_cash">${ user.cash }</h4>
      </div>
      <br>
      <hr width="300px">
    <div id="payment">
      <input class="payment" type="button" value="계좌이체">
      <input class="payment" type="button" value="신용카드">
      <input class="payment" type="button" value="기타">
    </div>
    <div id="modal_footer">
      <input class="" type="checkbox"/>[필수]충전에 동의합니다.<br>
      <input id="submit" type="submit" value="충전하기"/> 
    </div>  
    </div>
   </form>
    
    <div id="modal_withdraw">
      <div id="modal_header">
        <br><h3> 우동 캐시 출금 </h3><br>
      </div>
      <div id="cash_num">
      <h4 id="modal_header_h4">출금할 캐시</h4>
      <input id="cash_input" type="number" min="0" name="cash_update" value="0" step="1000" onchange="minusCash()"/>
      </div>
      <div id="total">
        <h4 id="modal_header_h4">출금 후 내 캐시</h4>
        <h4 class="total_cash">${ user.cash }</h4>
      </div>
    <div id="modal_footer">
      <input id="submit" type="button" value="출금하기"/> 
    </div>
    </div>  
  	</div>
</body>
</html>
<script type="text/javascript">
	const $cash = document.querySelector(".cash_modal");
	let $deposit = document.querySelector(".deposit"); 	
	let $withdraw = document.querySelector(".withdraw"); 
	let $cash_input = document.querySelector("#cash_input");
	let $total_cash = document.querySelector(".total_cash");
	let cur_cash = parseInt($total_cash.textContent);
	
	function cashModal() {
		$cash.classList.remove("hidden");
		$overlay.classList.remove("hidden");
	}
	function depositBtn(){
		$deposit.classList.remove("underBar");
		$withdraw.classList.add("underBar");
  		document.getElementById("modal_deposit").style.display = "none";
  		document.getElementById("modal_withdraw").style.display = "block";
	}
	function withdrawBtn(){
		$deposit.classList.add("underBar");
		$withdraw.classList.remove("underBar");
  		document.getElementById("modal_deposit").style.display = "block";
  		document.getElementById("modal_withdraw").style.display = "none";
	}
	function add1000(){
		$cash_input.value = parseInt($cash_input.value) + 1000;
		let cur_cash = parseInt($total_cash.textContent);
		$total_cash.textContent = cur_cash + 1000;
	}
	function add5000(){
		$cash_input.value = parseInt($cash_input.value) + 5000;
		let cur_cash = parseInt($total_cash.textContent);
		$total_cash.textContent = cur_cash + 5000;
	}
	function add10000(){
		$cash_input.value = parseInt($cash_input.value) + 10000;
		let cur_cash = parseInt($total_cash.textContent);
		$total_cash.textContent = cur_cash + 10000;
	}
	function addCash(){
		$total_cash.textContent = cur_cash + parseInt($cash_deposit.value);
	}
	function minusCash(){
		$total_cash.textContent = cur_cash - parseInt($cash_withdraw.value);
	}
	const $paybtn = document.querySelectorAll('.payment');

	// 각 버튼에 대해 클릭 이벤트를 추가합니다.
	$paybtn.forEach(button => {
	  button.addEventListener('click', () => {
	    // 모든 버튼의 선택 상태를 초기화합니다.
	    $paybtn.forEach(btn => {
	      btn.classList.remove('selected');
	    });
	    // 클릭된 버튼의 선택 상태를 변경합니다.
	    button.classList.add('selected');
	  });
	});
</script>