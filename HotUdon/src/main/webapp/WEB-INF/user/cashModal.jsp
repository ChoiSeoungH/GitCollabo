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
	#cash_num #cash_deposit, #cash_num #cash_withdraw{
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
		margin: 20px 3px;
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
		width: 60%;
		display: flex;
		margin: 0 auto;
		flex-direction: row;
		text-size: 2em;
	}
	#total #modal_header_h4{
		align-items: center;		
		width: 40%;
	}
	#total .total_cash1, #total .total_cash2{
		width: 60%;
		text-align: right;
	}
	.submit{
		margin-top: 10px;
		width: 100%;
		height: 40px;
		border: none;
		position: absolute;
 		bottom: 0;
 		left: 0;
	}
	.submit:hover{
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
    <form id="submit_form" action="${ ctx }/cashUpdate.do" method="post">
    	<input type="hidden" name="no" value="${ user.no }"/>
    	<input type="hidden" name="type" value="deposit"/>
      <div id="modal_header">
        <br><h3> 우동 캐시 충전 </h3><br>
      </div>
      <div id="cash_num">
      <h4 id="modal_header_h4">충전할 캐시</h4>
      <input id="cash_deposit" type="number" min="0" name="cash_update" value=0 step="1000" onchange="addCash()"/><br>
      </div>
      <div id="add_btn">
      <input class="add_btn" type="button" value="+ 1,000" onclick="add1000()"/>
      <input class="add_btn" type="button" value="+ 5,000" onclick="add5000()"/>
      <input class="add_btn" type="button" value="+ 10,000" onclick="add10000()"/>
      </div>
      <div id="total">
        <h4 id="modal_header_h4">충전 후 내 캐시</h4>
        <h4 class="total_cash1">${ user.cash }</h4>
      </div>
      <hr width="300px">
    <h4>결제 수단 선택</h4>
    <div id="payment">
      <input class="payment" type="button" value="계좌이체">
      <input class="payment" type="button" value="신용카드">
      <input class="payment" type="button" value="기타">
    </div>
    <div id="modal_footer">
      <input type="checkbox" id="agree_checkbox"/>[필수]충전에 동의합니다.<br>
      <input class="submit" type="button" value="충전하기" onclick="formSubmit()"/> 
    </div>  
   </form>
    </div>
    
    <div id="modal_withdraw">
   	<form action="${ ctx }/cashUpdate.do" method="post">
   	<input type="hidden" name="no" value="${ user.no }"/>
   	<input type="hidden" name="type" value="withdraw"/>
      <div id="modal_header">
        <br><h3> 우동 캐시 출금 </h3><br>
      </div>
      <div id="cash_num">
      <h4 id="modal_header_h4">출금할 캐시</h4>
      <input id="cash_withdraw" type="number" min="0" name="cash_update" value="0" onchange="minusCash()"/>
      </div>
      <div id="add_btn">
      <input class="add_btn" type="button" value="전액 출금" onclick="withdrawAll()"/>
      </div>
      <div id="total">
        <h4 id="modal_header_h4">출금 후 내 캐시</h4>
        <h4 class="total_cash2">${ user.cash }</h4>
      </div>
    <div id="modal_footer">
      <input class="submit" type="submit" value="출금하기"/> 
    </div>
     </form> 
    </div> 
  	</div>
</body>
</html>
<script type="text/javascript">
	const $cash = document.querySelector(".cash_modal");
	let $deposit = document.querySelector(".deposit"); 	
	let $withdraw = document.querySelector(".withdraw"); 
	let $cash_deposit = document.querySelector("#cash_deposit");
	let $cash_withdraw = document.querySelector("#cash_withdraw");
	let $total_cash1 = document.querySelector(".total_cash1");
	let cur_cash1 = parseInt($total_cash1.textContent);
	let $total_cash2 = document.querySelector(".total_cash2");
	let cur_cash2 = parseInt($total_cash2.textContent);
	let $submit_form = document.querySelector("#submit_form");
	
	function formSubmit(){
	    // 필수 체크박스 엘리먼트 가져오기
	    var agreeCheckbox = document.getElementById('agree_checkbox');
	    
	    // 체크박스가 선택되었는지 확인
	    if (!agreeCheckbox.checked) {
	      // 체크박스가 선택되지 않았다면 제출을 막음
	      alert('필수 항목에 동의해주세요.');
	      return false; // submit을 막기 위해 false 반환
	    } else {
	      // 체크박스가 선택된 경우에는 폼을 서버로 제출
	      document.getElementById('submit_form').submit();
	    }
	}
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
		$cash_deposit.value = parseInt($cash_deposit.value) + 1000;
		let cur_cash1 = parseInt($total_cash1.textContent);
		$total_cash1.textContent = cur_cash1 + 1000;
	}
	function add5000(){
		$cash_deposit.value = parseInt($cash_deposit.value) + 5000;
		let cur_cash1 = parseInt($total_cash1.textContent);
		$total_cash1.textContent = cur_cash1 + 5000;
	}
	function add10000(){
		$cash_deposit.value = parseInt($cash_deposit.value) + 10000;
		let cur_cash1 = parseInt($total_cash1.textContent);
		$total_cash1.textContent = cur_cash1 + 10000;
	}
	function withdrawAll(){
		$cash_withdraw.value = parseInt($total_cash2.textContent);
		$total_cash2.textContent = cur_cash2 - parseInt($cash_withdraw.value);
	}
	
	function addCash(){
		$total_cash1.textContent = cur_cash1 + parseInt($cash_deposit.value);
	}
	function minusCash(){
		$total_cash2.textContent = cur_cash2 - parseInt($cash_withdraw.value);
	}
	
	const $paybtn = document.querySelectorAll('.payment');
	$paybtn.forEach(button => {
	  button.addEventListener('click', () => {
	    $paybtn.forEach(btn => {
	      btn.classList.remove('selected');
	    });
	    button.classList.add('selected');
	  });
	});
</script>