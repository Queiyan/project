<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>


<%@ include file="../includes/header.jsp"%>



<form role="form" action="/request/register?${_csrf.parameterName}=${_csrf.token}" method="post"
	enctype="multipart/form-data">
	
	<div class="mb-3">
		<label for="exampleFormControlInput1" class="form-label">제목 </label> <input
			type="text" class="form-control" id="exampleFormControlInput1" required
			name='title' placeholder="제목을 입력하셔요">
	</div>

	<div class="mb-3">
		<label for="exampleFormControlInput1" class="form-label">작성자 </label>
		<input type="text" class="form-control" id="exampleFormControlInput1" required
			name='writer' value='<sec:authentication property="principal.username"/>' readonly="readonly">
	</div>

	<div class="mb-3">
		<label for="exampleFormControlTextarea1" class="form-label">
			내용</label>
		<textarea class="form-control" id="exampleFormControlTextarea1" required
			rows="3" placeholder="특이사항/대소변가리는지/나이/성별" name='content'></textarea>
	</div>
	<div class="mb-3">
			<label for="exampleFormControlInput1" class="form-label">펫 종류
				 </label> <input type="text" class="form-control" required
				id="exampleFormControlInput1" name='pet'
				placeholder="ex)강아지,고양이,이구아나,악어">
		</div>
		
	<div class="mb-3">
			<label for="payment" class="form-label">Pay
 			</label> <input type="text" class="form-control" required
				id="payment" name='payment'
				placeholder="보유point : <c:out value="${info.userPoint}" />">
			<span id="ava" class="check-g">포인트가 부족합니다.</span>

		</div>

	<div class="local">
		<input type="button" onclick="Daum_Address()" value="주소 찾기"><br>
		<input type="text" name="address" id="address" placeholder="주소" required><br>
		<input type="text" name="detailAddress" id="detailAddress" placeholder="상세주소">
		<input type="text" name="extraAddress" id="extraAddress" placeholder="참고항목">
	</div>


	<!-- 날짜 타입 선택창, 기본은 날짜시간 같이하는 타입으로-->
	<div class=orderType>
		<input type="radio" name="ordType" id="orderTypeSelect1"
			value="datetime" onclick="div_edtchg('datetime')" checked>기간설정
		<input type="radio" name="ordType" id="orderTypeSelect2"
			value="settime" onclick="div_edtchg('settime')">파트타임설정
		<!-- div_edtchg은 함수호출 이름, 괄호안에는 호출하면서 넘길 값 -->
	</div>

	<!-- 날짜시간 같이있는 타입 -->
	<div class="orderType date" id="datetimetype">
		<div class="dateSelectBefore">
			<p>
				시작날짜&시간: <input type="text" name="startDateTime" id="startDateTime"
					readonly="readonly" pattern="yyyy-MM-dd HH:mm">
			</p>
		</div>

		<div class="dateSelectAfter">
			<p>
				종료날짜&시간: <input type="text" name="endDateTime" id="endDateTime"
					readonly="readonly" pattern="yyyy-MM-dd HH:mm">
			</p>
		</div>
	</div>

	<!-- 날짜 시간 따로 있는 타입 -->
	<div class="orderType partTime" id="settimetype" style="display: none;">
		<div class="dateSelectBefore">
			<p>
				시작날짜: <input type="text" name="startDate" id="startDate"
					readonly="readonly" pattern="yyyy-MM-dd">
			</p>
		</div>

		<div class="dateSelectAfter">
			<p>
				종료날짜: <input type="text" name="endDate" id="endDate"
					readonly="readonly" pattern="yyyy-MM-dd">
			</p>
		</div>

		<div class="timeSelectBefore">
			<input type="time" name="startTime" id="startTime"
				placeholder="클릭하여 시간을 선택해주세요" readonly="readonly" pattern="hh:mm">
		</div>
		<div class="timeSelectAfter">
			<input type="time" name="endTime" id="endTime"
				placeholder="클릭하여 시간을 선택해주세요" readonly="readonly" pattern="hh:mm">
		</div>

	</div>



	<div class="mb-3">
		<label for="formFileSm" class="form-label">이미지</label> <input
			class="form-control form-control-sm" id="formFileSm" type="file"
			name="file" />
		<div class="select_img">
			<img src="" />
		</div>
	</div>

	<button type="submit" id="regbtn" class="btn btn-primary btn-sm">등록</button>
	<button type="reset" class="btn btn-secondary btn-sm">취소</button>
</form>


<script src="/resources/js/mdtimepicker.js"></script>
<script src="/resources/js/jquery.datetimepicker.full.min.js"></script>

<script src="/resources/js/datepicker.js"></script>
<script>
	$("#formFileSm").change(
			function() {
				if (this.files && this.files[0]) {
					var reader = new FileReader;
					reader.onload = function(data) {
						$(".select_img img").attr("src", data.target.result)
								.width(500);
					}
					reader.readAsDataURL(this.files[0]);
				}
			});
</script>

<script>
	// 시작 시간 선택 스크립트 호출&속성
	jQuery('#startTime').mdtimepicker({
		timeFormat : 'HH:mm', // format of the time value (data-time attribute)
		format : 'hh:mm', // format of the input value
		readOnly : false, // determines if input is readonly
		hourPadding : false,
		theme : 'black',
		okLabel : '확인',
		cancelLabel : '취소',
	});
	//종료 시간 선택 스크립트 호출&속성
	jQuery('#endTime').mdtimepicker({
		timeFormat : 'HH:mm', // format of the time value (data-time attribute)
		format : 'hh:mm', // format of the input value
		readOnly : false, // determines if input is readonly
		hourPadding : false,
		theme : 'black',
		okLabel : '확인',
		cancelLabel : '취소',
	});
</script>

<script>
	// 날짜 타입 선택 스크립트
	function div_edtchg(type) {
		if (type == "datetime") {
			document.getElementById('datetimetype').style.display = "";
			document.getElementById('settimetype').style.display = "none";

		} else if (type == "settime") {
			document.getElementById('settimetype').style.display = "";
			document.getElementById('datetimetype').style.display = "none";

		}
	}
</script>


<script>
	// 날짜선택 호출
	$(function() {
		$("#startDate").datepicker({
			dateFormat : 'yy-mm-dd'
		});
	});
	$(function() {
		$("#endDate").datepicker({
			dateFormat : 'yy-mm-dd'
		});
	});
</script>
<script>
	//날짜시간선택 호출과 옵션
	$(function() {
		$("#startDateTime").datetimepicker({
			lang : 'ko',
			format : 'Y-m-d H:i',
			autoclose : true,
			clearBtn : true,
			todayHighlight : true,
			zIndexOffset : 1000
		}).on('hide.bs.modal', function(e) {
			e.stopPropagation();
		});
	});

	$(function() {
		$("#endDateTime").datetimepicker({
			lang : 'ko',
			format : 'Y-m-d H:i',
			autoclose : true,
			clearBtn : true,
			todayHighlight : true,
			zIndexOffset : 1000
		}).on('hide.bs.modal', function(e) {
			e.stopPropagation();
		});
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
	$(document)
			.ready(
					function() {
						
						$("#ava").css("display", "none");
				
						$("#request").on("click", function() {
							self.location = "/request/list"
						});
						
						$("#regbtn").click(function(){
							var payment = $("#payment").val();
							var point = payment * -1;
							$.ajax({
			                    type: "get",
			                    url: "/charge/user/point", 
			                    data: {
			                        "amount" : point,
			                    },
			                });
						});
					});
</script>
<script>
$("#payment").change(function() {
    var payment = $(this).val();
	var userPoint = '<c:out value="${info.userPoint}" />';
    console.log(payment);
    console.log(userPoint);

   if (parseInt(payment) > parseInt(userPoint)) {
      alert("보유포인트가 부족합니다.");
      $("#ava").css("display", "block");
      $("#payment").val('');
      $(this).focus();
      return false;
   }
   else {
	  $("#ava").css("display", "none");

   }
 });
</script>
<%=request.getRealPath("/")%>



<%@ include file="../includes/footer.jsp"%>

