<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>



<%@ include file="../includes/header.jsp"%>
<link rel="stylesheet" href="/resources/css/modify.css">

<form role="form" action="/request/modify?${_csrf.parameterName}=${_csrf.token}" method="post"
	enctype="multipart/form-data">
	<div class="mb-3">
		<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token}" />
		<input type="hidden" name="rbno" value="${request.rbno}" /> 
		<input type="hidden" name="pageNum" value="${cri.pageNum }" /> 
		<input type="hidden" name="amount" value="${cri.amount }" />
		<input type="hidden" name="type" value="${cri.type }"> 
        <input type="hidden" name="keyword" value="${cri.keyword }">
		
		<label for="exampleFormControlInput1" class="form-label">제목 </label> 
		<input type="text" class="form-control" id="exampleFormControlInput1"
			name='title' value="<c:out value="${request.title }" />">
	</div>

	<div class="mb-3">
		<label for="exampleFormControlInput1" class="form-label">작성자 </label>
		<input type="text" class="form-control" id="exampleFormControlInput1"
			name='writer' value="<c:out value="${request.writer }" />" readonly>
	</div>

	<div class="mb-3">
		<label for="exampleFormControlTextarea1" class="form-label">
			내용</label>
		<textarea class="form-control" id="exampleFormControlTextarea1"
			rows="3" name='content'><c:out value="${request.content }" />
			</textarea>

		
		</div>
		<div class="mb-3">
			<label for="exampleFormControlInput1" class="form-label">펫
				종류 </label> <input type="text" class="form-control"
				id="exampleFormControlInput1" name='pet'
				value="<c:out value="${request.pet }" />">
		</div>
	
		
		<div class="mb-3">
			<label for="payment" class="form-label">돌봄 페이
 			</label> <input type="text" class="form-control" required
				id="payment" name='payment' value="<c:out value="${request.payment }" />"
				placeholder="사용가능한 point : <c:out value="${info.userPoint+request.payment}" />">
			<span id="ava" class="check-g">포인트가 부족합니다.</span>

		</div>

	
		<div class="local">
			<input type="button" onclick="Daum_Address()" value="주소 찾기" id="address-forget"><br>
			<input type="text" name="address" id="address" value="<c:out value="${request.address }" />">
			<input type="text" name="detailAddress" id="detailAddress" value="<c:out value="${request.detailAddress }" />">
			<input type="text" name="extraAddress" id="extraAddress" value="<c:out value="${request.extraAddress }" />">
		</div>
		<div class= orderType>
			<input type="radio" name="ordType" id="orderTypeSelect1" value="datetime"
			onclick="div_edtchg('datetime')" <c:if test="${empty request.startDate}">checked</c:if>>기간설정
			<input type="radio" name="ordType" id="orderTypeSelect2" value="settime"
			onclick="div_edtchg('settime')"<c:if test="${not empty request.startDate}">checked</c:if>>파트타임설정
		</div>
	
	<!-- 날짜시간 같이있는 타입 -->
	
	<div class="orderType date" id="datetimetype" 
	<c:if test="${not empty request.startDate}">style="display:none;"</c:if>>
		<div class="dateSelectBefore">
			<p>
				시작날짜&시간: <input type="text" name="startDateTime" id="startDateTime"
				readonly="readonly"
				value="<fmt:formatDate value="${request.startDateTime }" pattern="yyyy-MM-dd HH:mm"/>">
			</p>
		</div>
	
		<div class="dateSelectAfter">
			<p>
				종료날짜&시간: <input type="text" name="endDateTime" id="endDateTime"
					readonly="readonly" 
					value="<fmt:formatDate value="${request.endDateTime }" pattern="yyyy-MM-dd HH:mm"/>">
			</p>
		</div>
	</div>
	
	<!-- 날짜 시간 따로 있는 타입 -->
	
	<div class="orderType partTime" id="settimetype" 
	<c:if test="${empty request.startDate}">style="display:none;"</c:if>>
		<div class="dateSelectBefore">
			<p>
				시작날짜: <input type="text" name="startDate" id="startDate"
				readonly="readonly"
				value="<fmt:formatDate value="${request.startDate }" pattern="yyyy-MM-dd"/>">
			</p>
		</div>
	
		<div class="dateSelectAfter">
			<p>
				종료날짜: <input type="text" name="endDate" id="endDate"
					readonly="readonly" 
					value="<fmt:formatDate value="${request.endDate }" pattern="yyyy-MM-dd"/>">
			</p>
		</div>
		
		 <div class="timeSelectBefore">
			시작시간: <input type="text" name="startTime" id="startTime"
				readonly="readonly"
				value="<fmt:formatDate value="${request.startTime }" pattern="HH:mm"/>">
		</div>
		<div class="timeSelectAfter">
			종료시간: <input type="text" name="endTime" id="endTime"
					readonly="readonly" 
					value="<fmt:formatDate value="${request.endTime }" pattern="HH:mm"/>">
		</div> 
		
	</div>


	<div class="mb-3">
		<label for="formFileSm" class="form-label">이미지</label> 
		<input class="form-control form-control-sm" id="formFileSm" type="file" name="file" />
		<div class="select_img">
			<img src="<c:out value="${request.img }" />" onerror="this.src='/resources/images/img-ready.png'" style="width:200px; height: 200px;"/>
			<input type="hidden" name="img" value="${request.img}" style="width:200px; height: 200px;"/>
		 <input type="hidden" name="thumImg" value="${request.thumImg}" />
		</div>
	</div>
	

	<sec:authentication property="principal" var="pinfo" />
	<sec:authorize access="isAuthenticated()">
	<c:if test="${pinfo.username eq request.writer }">

	<button type="submit" data-oper='modify' class="btn btn-success">글수정</button>
	<button type="submit" data-oper='remove' class="btn btn-danger">삭제</button>
	
	</c:if>
	</sec:authorize>
	
	<button type="submit" data-oper='list' class="btn btn-info" id="requestListBtn">목록</button>

</form>


<script src="/resources/js/jquery.datetimepicker.full.min.js"></script>
<script src="/resources/js/mdtimepicker.js"></script>
<script>
// 날짜 타입 선택 스크립트
function div_edtchg(type) {
	if (type=="datetime") {	
		document.getElementById('startDate').value ='';
		document.getElementById('endDate').value ='';
		document.getElementById('startTime').value ='';
		document.getElementById('endTime').value ='';
		document.getElementById('settimetype').style.display="none";
		document.getElementById('datetimetype').style.display="";
		
		
		

	} else if (type=="settime") {
		document.getElementById('startDateTime').value ='';
		document.getElementById('endDateTime').value ='';	
		document.getElementById('datetimetype').style.display="none";
		document.getElementById('settimetype').style.display="";

	}
}
</script>
<script>
//날짜시간선택 호출과 옵션
	$(function() {
		$("#startDateTime").datetimepicker({
	        lang:'ko',
	        format:'Y-m-d H:i',
	        autoclose: true,
	    	clearBtn: true,
    	    todayHighlight: true,
    	    zIndexOffset: 1000
    	}).on('hide.bs.modal', function (e) {
    	    e.stopPropagation();
    	});
	});
	
	$(function() {
		$("#endDateTime").datetimepicker({
	        lang:'ko',
	        format:'Y-m-d H:i',
	        autoclose: true,
    	    clearBtn: true,
    	    todayHighlight: true,
    	    zIndexOffset: 1000
    	}).on('hide.bs.modal', function (e) {
    	    e.stopPropagation();
    	});
	});
</script>
<script>
// 시작 시간 선택 스크립트 호출&속성
jQuery('#startTime').mdtimepicker({
	timeFormat: 'hh:mm', // format of the time value (data-time attribute)
    format: 'hh:mm',    // format of the input value
    readOnly: false,       // determines if input is readonly
    hourPadding: false,
    theme: 'black',
    okLabel: '확인',
    cancelLabel: '취소',
});
//종료 시간 선택 스크립트 호출&속성
jQuery('#endTime').mdtimepicker({
	timeFormat: 'hh:mm', // format of the time value (data-time attribute)
    format: 'hh:mm',    // format of the input value
    readOnly: false,       // determines if input is readonly
    hourPadding: false,
    theme: 'black',
    okLabel: '확인',
    cancelLabel: '취소',
});

</script>



<script>
// 날짜선택 호출
	$(function(){
		$("#startDate").datepicker({
			dateFormat: 'yy-mm-dd'
    	});
	});
	$(function(){
		$("#endDate").datepicker({
			dateFormat: 'yy-mm-dd'
    	});
	});
</script>
<script>
	$("#formFileSm").change(
			function() {
				if (this.files && this.files[0]) {
					var reader = new FileReader;
					reader.onload = function(data) {
						$(".select_img img").attr("src", data.target.result)
								.width(200);
					}
					reader.readAsDataURL(this.files[0]);
				}
			});
</script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script>
    function Daum_Address() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("extraAddress").value = '';
                }

                document.getElementById("address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("detailAddress").focus();
            }
        }).open();
    }
</script>
<script>
   $(document).ready(
         function() {
        	 
     		$("#ava").css("display", "none");
     	    
     		var userPoint = '<c:out value="${info.userPoint}" />';
     		var rawpayment = '<c:out value="${request.payment}" />';
     		var payment;
     		var gap;
     		$("#payment").change(function() {
     		    payment = $(this).val();
     			
     			gap = parseInt(payment) - parseInt(rawpayment);

     		    if (parseInt(payment) > parseInt(rawpayment)) {
     			   if (parseInt(gap) > parseInt(userPoint)) {
     			      alert("보유포인트가 부족합니다.");
     			      $("#ava").css("display", "block");
     			      $("#payment").val('');
     			      $(this).focus();
     			      return false;
     			   }
     			   else {
     				  $("#ava").css("display", "none");
     			   }
     		    }
     		 });
     		

            var formObj = $("form");/* 문서중 form 요소를 찾아서 변수에 할당. */
            $("button[type='submit']").on(
                  "click",
                  function(e) {
                     /* 버튼이 클릭된다면 아래 함수 수행, e라는 이벤트 객체를
                     전달하면서 */
                     e.preventDefault();/* 기본 이벤트 동작 막기. */
                     var operation = $(this).data("oper");
                     
                     var startDate = '${request.startDate }'
                   	 var endDate = '${request.endDate }'
                     /* 버튼에서 oper 속성 읽어서 변수에 할당. */
                     console.log(operation);
                     /* 브라우저 로그로 oper값 출력. */
                     if (operation === 'remove') {
                        
                        if (confirm("정말 삭제하시겠습니까??") == true){    //확인

                        	$.ajax({
			                    type: "get",
			                    url: "/charge/user/point", 
			                    data: {
			                        "amount" : rawpayment,
			                    },

			                });
                        	formObj.attr("action", "/request/remove?${_csrf.parameterName}=${_csrf.token}");

                        }else{   //취소

                            return false;

                        }
                     } else if (operation === 'list') {
                        
                        //return;
                        formObj.attr("action","/request/list")
                        .attr("method","get");
                        var pageNumTag=$("input[name='pageNum']");
                        var amountTag=$("input[name='amount']");
                        formObj.empty();//폼의 내용들 비우기.
                        formObj.append(pageNumTag);
                        formObj.append(amountTag);
                     } else{
                    	 
                    	 
              			var mGap = gap * -1;

                    	 $.ajax({
			                    type: "get",
			                    url: "/charge/user/point", 
			                    data: {
			                        "amount" : mGap
			                    },

			                });
                    	 formObj.submit();
                     }
                     formObj.submit();
                  });

});
</script>



<%@ include file="../includes/footer.jsp"%>