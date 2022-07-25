<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>


<title>비밀번호 변경</title>


<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> 
<script type="text/javascript" src="/resources/js/bootstrap.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/css/signup.css">
<link href="/resources/css/bootstrap.min.css" rel="stylesheet">

<%@ include file="includes/header.jsp"%>

<h1>비밀번호 변경</h1>
<form role="form"
	action="/modifyPw?${_csrf.parameterName}=${_csrf.token}" method="post"
	enctype="multipart/form-data">
	
<div class="leftsection col-md-4"></div>

<div class="centersection col-md-4">


	<div class="forget-contents">
	   <label for="password" class="form-label FPW">현재 비밀번호:</label><br>
		<input type="password" name="rawPassword" id="password" class="form-control">
	</div>
	
	<br>
	   
	   <div class="forget-contents">
	      <label for="validationCustom01" class="form-label FPW">새 비밀번호</label>
	      <input type="password" class="form-control" id="validationCustom01"
	         value="" placeholder="" name="newPassword" required placeholder="영문자/숫자/특수문자(!@#$%^&*~ 중) 8~20자">
	         <span id="impopw" class="check-r">비밀번호를 양식에 맞춰 설정해 주세요.</span>
	      <div class="valid-feedback">비밀번호</div>
	   </div>
	   
	   <br>
	   
	   <div class="forget-contents">
	      <label for="validationCustom02" class="form-label FPW">새 비밀번호 확인</label> <input
	         type="password" class="form-control" id="validationCustom02" value=""
	         required>
	         <span id="checkOk" class="check-g">비밀번호가 일치합니다.</span>
	         <span id="checkNo" class="check-r">비밀번호가 일치하지 않습니다.</span>
	   </div>
	
			<button id="modalModBtn" type="submit" class="btn btnprimary">수정</button>

</div>
<div class="rightsection col-md-4"></div>

</form>

<script>
$(document).ready(function(e) {
	
	var result = '<c:out value="${result}"/>';
	if (result == 'fail'){
		alert("현재 비밀번호를 확인해주세요.")
	}
	
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
	
	   
	   /* var pwCheck */
	
	
});
</script>





<%@ include file="includes/footer.jsp"%>