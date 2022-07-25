<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- jstl core 쓸때 태그에 c 로 표시. -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!-- jstl fmt 쓸때 위와 같음. fmt : formatter 형식 맞춰서 표시 -->


<title>회원가입</title>

<link href="/resources/css/bootstrap.min.css" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> 
<script type="text/javascript" src="/resources/js/bootstrap.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/css/signup.css">

<div class="header-title">
<a href="/"><img src="/resources/images/logo-white.png" style="width:300px;"/></a>
</div>
<div class="asd">
   
<form class="row g-3 needs-validation form-floating"  action="/signup" method="post">
   <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
   
<div class="col-md-8">
	
      <label for="validationCustom03" class="form-label">ID</label>
      <input type="text" class="form-control" id="validationCustom03" name="userid" required
      required placeholder="영문자 또는 영문자/숫자 5~15자">
         <span id="ava" class="check-g">사용 가능한 아이디입니다.</span>
         <span id="over" class="check-r">이미 존재하는 아이디입니다.</span>
         <span id="impo" class="check-r">사용할 수 없는 아이디입니다.</span>
      <div class="invalid-feedback">ID</div>
   </div>
   
   <div class="col-md-6">
      <label for="validationCustom01" class="form-label">비밀번호</label>
      <input type="password" class="form-control" id="validationCustom01"
         value="" placeholder="" name="userpw" required placeholder="영문자/숫자/특수문자(!@#$%^&*~ 중) 8~20자">
         <span id="impopw" class="check-r">비밀번호를 양식에 맞춰 설정해 주세요.</span>
      <div class="valid-feedback">비밀번호</div>
   </div>
   <div class="col-md-6">
      <label for="validationCustom02" class="form-label">비밀번호 확인</label> <input
         type="password" class="form-control" id="validationCustom02" value=""
         required>
         <span id="checkOk" class="check-g">비밀번호가 일치합니다.</span>
         <span id="checkNo" class="check-r">비밀번호가 일치하지 않습니다.</span>
   </div>
   
   <div class="col-md-6">
      <label for="validationCustom01" class="form-label">이름</label>
      <input type="text" class="form-control" id="validationCustom01"
         value="" placeholder="" name="userName" required>
      <div class="valid-feedback">이름</div>
   </div>
   <div class="col-md-6">
      <label for="validationCustom02" class="form-label">닉네임</label> <input
         type="text" class="form-control" id="validationCustom02" value=""
          name="nick" required>
      <div class="valid-feedback">닉네임</div>
   </div>
   
   
   <div class="col-md-2">
      <label for="validationCustom03" class="form-label">주소</label>
         <input type="text" class="form-control" id="sample6_postcode" name="zipCode"  placeholder="우편번호" >
   </div>
   <div class="col-md-10">
      <input type="button" class="click-button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기" style="width:120px; margin:28px 0 0 0;">
   </div>
   <div class="col-md-6">
         <input type="text" class="form-control" id="sample6_address" name="address" placeholder="주소">
   </div>
   <div class="col-md-6">
         <input type="text" class="form-control" id="sample6_detailAddress" name="detailAddress" placeholder="상세주소">
   </div>
   <div class="col-md-6">
         <input type="text" class="form-control" id="sample6_extraAddress" name="extraAddress" placeholder="참고항목" >
   </div>
   
   
   <div class="col-md-8">
      <label for="validationCustom03" class="form-label">이메일</label>
         <input type="text" class="form-control" id="email" name="email" required >
         <div class="text_fail" id="em-danger">이미 존재하는 email입니다 .</div>
               <div class="text_success" id="em-success">사용가능한 email 입니다.</div>
               <div class="text_fail" id="em-error">이메일 주소 형식에 맞게 작성해주세요.</div>
   </div>
   <div class="col-md-4">
      <button id="Authentication" class="click-button" style="width:120px; margin:28px 0 0 0;">이메일 인증</button>
   </div>
   
   
   
   
   <div class="col-md-8">
      <div id="AuthConfirmBox" class="mail_input_box">
   
         <input type="text" class="compare form-control" id="validationCustom03" placeholder="인증 키 입력" required >
      </div>
      
   </div>
   <div class="col-md-4">
      <button id="emailAuthBtn" class="click-button" style="width:120px;">확인</button>
   </div>
   
            

   <div class="col-md-8">
      <label for="validationCustom03" class="form-label">전화번호</label> <input
         type="text" class="form-control" id="validationCustom03" name="phone" required >
      <div class="invalid-feedback">Please provide a valid city.</div>
   </div>
   
   <div class="col-md-4">
      <label for="validationCustom04" class="form-label">성별</label> <select
         class="form-select" id="validationCustom04" name="gender" required >
         <option selected disabled value="">성별을 골라주세요.</option>
         <option>남자</option>
         <option>여자</option>
      </select>
      <div class="invalid-feedback">Please select a valid state.</div>
   </div>
   
   <div class="col-12" style="text-align:center;">
      <button  class="submit-button" type="submit">회원 가입</button>
   </div>
</form>
</div>
<script>
$("#em-success").hide();
$("#em-danger").hide();
$("#em-error").hide();

/*본인인증하기 버튼 클릭*/
$("#Authentication").on("click" ,function(e) {
      e.preventDefault();
      //console.log("email : " + $("#userEmail").val());
      $("#AuthConfirmBox").show();
      $("#emailAuthBtn").show();
      
      $.ajax({
         type : 'post',
         url : "/emailAuth",
         dataType : 'json',
         async : "false",
         data : {
            "email" : $("#email").val()
         },
         success : function(data) {
            key = data.key;
         }
      });

      console.log("key : " + key);
      
      alert("입력하신 이메일로 인증번호를 발송했습니다.");
      $(".compare").css("display", "block");
      
   });
/*본인인증하기 버튼 클릭*/


/* 이메일 인증번호 입력 후 확인 버튼 클릭시 처리 */
$("#emailAuthBtn").on("click",function(e) {
   e.preventDefault();
   
   if ($(".compare").val() == key) {   //인증 키 값을 비교를 위해 텍스트인풋과 벨류를 비교
      alert("인증되었습니다.");
      isCertification = true;  //인증 성공여부 check
   } else {
      alert("인증번호가 일치하지 않습니다.");
      $(".compare").val("");
      isCertification = false; //인증 실패
   }
});
/* 이메일 인증번호 입력 후 확인 버튼 클릭시 처리 */

var emReg = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;

$("#em-success").hide();
$("#em-danger").hide();
$("#em-error").hide();

/* 이메일 유효성, 중복 검사. */
$("#email").keyup(function() {
      console.log("em유효 검사");
      if ($("#email").val() != " ") {
         
         if (emReg.test($("#email").val())) {
            
            $.ajax({
               url : "/emCheck",
               data : {"email" : $("#email").val()},
               dataType : "json",
               type : "post",
               async : false,
               success : function(data) {
                  /* 아이디 중복 검사 */
                  if (data == 1) {
                     console.log("em중복검사");
                     $("#em-success").hide();
                     $("#em-error").hide();
                     $("#em-danger").show();
                     $("#Authentication").hide();
                        document.getElementById("emCheckVal").value = 'N';
                  } 
                  else if (data == 0) {
                     $("#em-success").show();
                     $("#em-error").hide();
                     $("#em-danger").hide();
                     $("#Authentication").show();
                     document.getElementById("emCheckVal").value = 'Y';
                  }

               }
            });
         } 
         else if (!emReg.test($("#email").val())) {
               //유효성 검사를 통과하지 못한 경우 - 에러 처리
               $("#em-success").hide();
               $("#em-danger").hide();
               $("#em-error").show();
               $("#Authentication").hide();
               document.getElementById("emCheckVal").value = 'N';
         }
   }
});

</script>
<script>
$(document).ready(function(e) {
   var csrfHeaderName = "${_csrf.headerName}";
   var csrfTokenValue = "${_csrf.token}";
   $(document).ajaxSend(function(e, xhr, options) {
      xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
   });


   // 아이디를 기입했을 때
   var idReg = /^(?=.*[a-z])[a-z0-9]{5,15}$/i;
   $("#validationCustom03").change(function() {
      var userid = $(this).val();

      // 아이디 문자, 길이 제한
      if (userid != '') {
         if (!idReg.test(userid)) {
            alert("아이디는 영문자 혹은 영문자와 숫자로 이루어진 5~15자여야 합니다.");
            $("#ava").css("display", "none");
            $("#over").css("display", "none");
            $("#impo").css("display", "block");
            $(this).focus();
            return false;
         }
      }

    // 아이디 중복 확인
	var data = {userid: userid}
    // {컨트롤러에 넘기는 이름: 데이터}
    $.ajax({
    	type: "post",
		url: "/useridcheck",
		data: data,
		success: function(result) {
			if (result != 'exist') {
			   $("#ava").css("display", "block");
			   $("#over").css("display", "none");
			   $("#impo").css("display", "none");
			} else {
			   $("#over").css("display", "block");
			   $("#ava").css("display", "none");
			   $("#impo").css("display", "none");
			}
        }
	});
   });
   var pwReg = /^(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$%^&*~])[a-z0-9!@#$%^&*~]{5,15}$/i;
   $("#validationCustom01").change(function() {
      var password = $(this).val();
      if (!pwReg.test(password)) {
         alert("비밀번호는 영문자와 숫자, 특수문자(!@#$%^&*~ 중 선택)로 이루어진 8~20자여야 합니다.");
         $("#impopw").css("display", "block");
         $(this).focus();
         return false;
      } else {
         $("#impopw").css("display", "none");
      }
   });


   // 비밀번호 일치 확인
   $("#validationCustom02").on('focus', function() {
      if ($("#validationCustom01").val() == '') {
         alert("비밀번호를 먼저 입력해 주세요.");
         $("input[name='userpw']").focus();
         return false;
      }
   });
   
   // 비밀번호 재확인 스크립트
   $("#validationCustom02").on('blur', function() {
      if (($("#validationCustom01").val() && $(this).val()) != '') {
         if ($("#validationCustom01").val() == $(this).val()) {
            $("#checkOk").css("display", "block");
            $("#checkNo").css("display", "none");
         } else {
            $("#checkNo").css("display", "block");
            $("#checkOk").css("display", "none");
            return false;
         }
      }
   });    
});


</script>

<!-- 주소 api 스크립트 -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    function sample6_execDaumPostcode() {
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
                    document.getElementById("sample6_extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("sample6_extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample6_postcode').value = data.zonecode;
                document.getElementById("sample6_address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("sample6_detailAddress").focus();
            }
        }).open();
    }
    
</script>

<%@ include file="includes/footer.jsp"%>