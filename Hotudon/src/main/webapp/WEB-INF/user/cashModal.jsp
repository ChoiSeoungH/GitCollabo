<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="total_cash" value="${ user.cash }"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>캐시 관리</title>
  <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
  <style>
      .cash_modal {
          border-radius: 10px;
          width: 40%;
          max-width: 500px;
          background-color: #fff;
          position: fixed;
          top: 50%;
          left: 50%;
          transform: translate(-50%, -50%);
          box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
          padding: 20px;
          z-index: 1050;
      }

      .modal-header, .modal-footer {
          display: flex;
          justify-content: space-between;
          align-items: center;
      }

      .modal-tab {
          padding: 10px;
          cursor: pointer;
          color: #007bff;
          border: none;
          background: transparent;
      }

      .modal-tab:focus {
          outline: none;
      }

      .modal-tab.active, .modal-tab:hover {
          border-bottom: 2px solid #007bff;
      }

      .payment-method {
          margin: 5px;
          padding: 10px;
          border: 1px solid #ddd;
          border-radius: 5px;
          background-color: #f8f9fa;
          cursor: pointer;
      }

      .payment-method.selected {
          border-color: #007bff;
          background-color: #e9ecef;
      }

      .form-group {
          margin-bottom: 1rem;
      }

      .form-control:focus {
          border-color: #80bdff;
          outline: 0;
          box-shadow: 0 0 0 .2rem rgba(0, 123, 255, .25);
      }

      .form-check-input:checked {
          background-color: #007bff;
          border-color: #007bff;
      }

      .form-check-input:focus {
          box-shadow: 0 0 0 .2rem rgba(0, 123, 255, .25);
      }

      .submit {
          width: 100%;
          padding: 10px;
          border: none;
          border-radius: 5px;
          background-color: #007bff;
          color: white;
          cursor: pointer;
      }

      .submit:hover {
          background-color: #0056b3;
      }

      .hidden {
          display: none;
      }
  </style>
</head>
<body>
<div class="container">
  <div class="modal fade" id="modalCash" tabindex="-1" role="dialog" aria-labelledby="modalCashLabel"
       aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <button class="modal-tab active" id="tab-deposit" onclick="toggleTab('deposit')">충전하기</button>
          <button class="modal-tab" id="tab-withdraw" onclick="toggleTab('withdraw')">출금하기</button>
        </div>
        <div class="modal-body">
          <!-- Deposit Form -->
          <div id="deposit-content" class="content">
            <h3>우동 캐시 충전</h3>
            <form id="depositForm" action="${ctx}/cashUpdate.do" method="post">
              <input type="hidden" name="no" value="${user.no}"/>
              <input type="hidden" name="type" value="deposit"/>
              <div class="form-group">
                <label for="cash_deposit">충전할 캐시</label>
                <input type="number" class="form-control" id="cash_deposit" name="cash_update" min="0" step="1000"/>
              </div>
              <div class="form-group d-flex justify-content-around">
                <button type="button" class="btn btn-outline-primary" onclick="modifyCash('deposit', 1000)">+1,000
                </button>
                <button type="button" class="btn btn-outline-primary" onclick="modifyCash('deposit', 5000)">+5,000
                </button>
                <button type="button" class="btn btn-outline-primary" onclick="modifyCash('deposit', 10000)">+10,000
                </button>
              </div>
              <div class="form-group">
                <h4>충전 후 예상 캐시: <span id="expected_deposit_cash">${total_cash}</span></h4>
              </div>
              <div class="form-group">
                <label>결제 수단 선택</label>
                <div class="d-flex justify-content-around">
                  <div class="payment-method" onclick="selectPaymentMethod(this, 'bank')">계좌이체</div>
                  <div class="payment-method" onclick="selectPaymentMethod(this, 'credit')">신용카드</div>
                  <div class="payment-method" onclick="selectPaymentMethod(this, 'other')">기타</div>
                </div>
              </div>
              <div class="form-group form-check">
                <input type="checkbox" class="form-check-input" id="agree_deposit">
                <label class="form-check-label" for="agree_deposit">[필수] 충전에 동의합니다.</label>
              </div>
              <button type="button" class="submit" onclick="submitForm('deposit')">충전하기</button>
            </form>
          </div>
          <!-- Withdraw Form -->
          <div id="withdraw-content" class="content hidden">
            <h3>우동 캐시 출금</h3>
            <form id="withdrawForm" action="${ctx}/cashUpdate.do" method="post">
              <input type="hidden" name="no" value="${user.no}"/>
              <input type="hidden" name="type" value="withdraw"/>
              <div class="form-group">
                <label for="cash_withdraw">출금할 캐시</label>
                <input type="number" class="form-control" id="cash_withdraw" name="cash_update" min="0"/>
              </div>
              <div class="form-group text-center">
                <button type="button" class="btn btn-outline-danger" onclick="modifyCash('withdraw', -${total_cash})">전액 출금</button>
              </div>
              <div class="form-group">
                <h4>출금 후 예상 캐시: <span id="expected_withdraw_cash">${total_cash}</span></h4>
              </div>
              <button type="submit" class="submit">출금하기</button>
            </form>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script>
      let total_cash = parseInt('${total_cash}');


      function toggleTab(tab) {
        if (tab === 'deposit') {
          document.getElementById('tab-deposit').classList.add('active');
          document.getElementById('tab-withdraw').classList.remove('active');
          document.getElementById('deposit-content').classList.remove('hidden');
          document.getElementById('withdraw-content').classList.add('hidden');
        } else {
          document.getElementById('tab-withdraw').classList.add('active');
          document.getElementById('tab-deposit').classList.remove('active');
          document.getElementById('withdraw-content').classList.remove('hidden');
          document.getElementById('deposit-content').classList.add('hidden');
        }
      }

      function modifyCash(action, amount) {
        let input, expectedCash;
        if (action === 'deposit') {
          input = document.getElementById('cash_deposit');
          expectedCash = document.getElementById('expected_deposit_cash');
        } else {
          input = document.getElementById('cash_withdraw');
          expectedCash = document.getElementById('expected_withdraw_cash');
          if (amount === -total_cash) amount = -parseInt(input.value || 0);
        }
        let newValue = parseInt(input.value || 0) + amount;
        input.value = newValue > 0 ? newValue : 0;
        expectedCash.innerText = (action === 'deposit' ? total_cash + newValue : total_cash - newValue) + '원';
      }

      function selectPaymentMethod(element, method) {
        let methods = document.querySelectorAll('.payment-method');
        methods.forEach((methodElement) => {
          methodElement.classList.remove('selected');
        });
        element.classList.add('selected');
      }

      function submitForm(formType) {
        let form = formType === 'deposit' ? document.getElementById('depositForm') : document.getElementById('withdrawForm');
        let checkbox = form.querySelector('input[type="checkbox"]');
        if (checkbox && !checkbox.checked) {
          alert('[필수] 충전에 동의해야 충전할 수 있습니다.');
          return false;
        }
        form.submit();
      }
    </script>
</body>
</html>
