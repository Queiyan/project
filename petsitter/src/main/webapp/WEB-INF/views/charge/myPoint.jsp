<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>


<%@ include file="../includes/header.jsp"%>

<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<link rel="stylesheet" href="/resources/css/myPoint.css">


<div class="second" align="center">
                    <div>
                    	<img class="card-img-top" style="width: 700px; margin-bottom: 40px;border-radius: 10px;"
                    	src="/resources/images/kakaopay.png" alt="..." />
                    </div>
                    <!-- <p style="font-weight: bold">카카오페이 현재 사용가능</p> -->
                    <label class="box-radio-input"><input type="radio" name="cp_item" value="5000"><span>5,000원</span></label>
                    <label class="box-radio-input"><input type="radio" name="cp_item" value="10000"><span>10,000원</span></label>
                    <label class="box-radio-input"><input type="radio" name="cp_item" value="15000"><span>15,000원</span></label><br/>
                    <label class="box-radio-input"><input type="radio" name="cp_item" value="20000"><span>20,000원</span></label>
                    <label class="box-radio-input"><input type="radio" name="cp_item" value="25000"><span>25,000원</span></label>
                    <label class="box-radio-input"><input type="radio" name="cp_item" value="30000"><span>30,000원</span></label><br/>
                    <label class="box-radio-input"><input type="radio" name="cp_item" value="35000"><span>35,000원</span></label>
                    <label class="box-radio-input"><input type="radio" name="cp_item" value="40000"><span>40,000원</span></label>
                    <label class="box-radio-input"><input type="radio" name="cp_item" value="50000"><span>50,000원</span></label>
                    <p  style="color: #ac2925; margin-top: 30px">카카오페이의 최소 충전금액은 5,000원이며 <br/>최대 충전금액은 50,000원 입니다.</p>
                    <button type="button" class="btn btn-outline-dark" id="charge_kakao">충 전 하 기</button>
                </div>

<script>

	var csrfHeaderName="${_csrf.headerName}";
	var csrfTokenValue="${_csrf.token}";
	
	$(document).ajaxSend(function(e,xhr,options){
		xhr.setRequestHeader(csrfHeaderName,csrfTokenValue);
	});
	
	
	 <sec:authorize access="isAuthenticated()">
     var loginUser= '<sec:authentication property="principal.username"/>';
     </sec:authorize>
     
     var email = '<c:out value="${info.email}" />';
     var phone = '<c:out value="${info.phone}" />';
     var address = '<c:out value="${info.address}" /> ' +'<c:out value="${info.detailAddress}" />' +'<c:out value="${info.extraAddress}" />';
     var zipCode = '<c:out value="${info.zipCode}" />';

     
	

    $('#charge_kakao').click(function () {
        // getter
        var IMP = window.IMP;
        IMP.init('imp94390443');
        var money = $('input[name="cp_item"]:checked').val();
        console.log(money);

        IMP.request_pay({
            pg: 'kakao',
            merchant_uid: 'merchant_' + new Date().getTime(),

            name: '행복하개 돌볼고양 포인트 충전',
            amount: money,
            buyer_email: email,
            buyer_name: loginUser,
            buyer_tel: phone,
            buyer_addr: address,
            buyer_postcode: zipCode
        }, function (rsp) {
            console.log(rsp);
            if (rsp.success) {
                var msg = '결제가 완료되었습니다.';
                msg += '고유ID : ' + rsp.imp_uid;
                msg += '상점 거래ID : ' + rsp.merchant_uid;
                msg += '결제 금액 : ' + rsp.paid_amount;
                msg += '카드 승인번호 : ' + rsp.apply_num;
                
               var cvo = { point : rsp.paid_amount,
                        chargeId : rsp.merchant_uid,
                        userid : rsp.buyer_name};
                
                $.ajax({
                    type: "post",
                    url: "/charge/point", 
                    data: JSON.stringify(cvo),
                    contentType: "application/json; charset=utf-8",
                });
                
                $.ajax({
                    type: "get",
                    url: "/charge/user/point", //충전 금액값을 보낼 url 설정
                    data: {
                        "amount" : money
                    },

                });

            } else {
                var msg = '결제에 실패하였습니다.';
                msg += '에러내용 : ' + rsp.error_msg;
            }
            alert(msg);
            document.location.href="/charge/myPoint"; //alert창 확인 후 이동할 url 설정
        });
    });
    

</script>

<%@ include file="../includes/footer.jsp"%>



