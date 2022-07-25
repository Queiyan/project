<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
<head>
<link href="/resources/css/login.css" rel="stylesheet">
<link href="/resources/css/bootstrap.min.css" rel="stylesheet"
	id="bootstrap-css">
<script src="/resources/js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<title>로그인</title>
</head>
<body>
	<div id="login">
	<div class="linkLogo">
		<a href="/"><img src="/resources/images/logo-white.png" style="width:300px;"/></a>
	</div>
		
<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
   aria-labelledby="exampleModalLabel" aria-hidden="true">
   <div class="modal-dialog modal-small">
      <div class="modal-content">
         <div class="modal-header">
            <h4 class="modal-title" id="myModalLabel">에러 메시지</h4>
         </div>
         		<div class="modal-body">
				<h2 id="error-modal">${error}</h2>
				<div class="modal-footer">
		            <button id="modalCloseBtn" type="button" class="btn btndefault">닫기</button>
		         </div>
         </div>
	         
      </div>
	</div>
</div>		
		

		<div class="container">
			<div id="login-row"
				class="row justify-content-center align-items-center">
				<div id="login-column" class="col-md-6">
					<div id="login-box" class="col-md-12">
						<form id="login-form" class="form" action="/login" method="post">
							
							<div class="form-group">
								<label for="username" class="">아이디:</label><br>
								<input type="text" name="username" id="username"
									class="form-control">
							</div>
							<div class="form-group">
								<label for="password" class="">비밀번호:</label><br>
								<input type="password" name="password" id="password"
									class="form-control">
							</div>

							<div class="form-group">
								<div class="remember-button">
									<span>아이디 기억하기</span>
									
										 
										<span><input id="remember-me" name="remember-me" class="remember-check" type="checkbox">
											<label for="remember-me" ><span></span></label></span>
								</div>
								
								<a href="signup" class="text-info">
									<button class="btn btn-info btn-md" type="button" id="signup-btn">
										회원가입
									</button>
								</a>
								
								<button type="button" data-oper="findAccount"
									class="btn btn-md" class="login-btn" id="findAccount">아이디/비밀번호
									찾기</button>

							</div>
							<div class="form-login">
								<input type="submit"
										name="submit" class="btn btn-info btn-md" value="로그인" id="login-Btn">
							</div>
							<input type="hidden" name="${_csrf.parameterName }"
								value="${_csrf.token}" />
						</form>
					</div>
				</div>
			</div>
		</div>
</div>

<script>
$(document).ready(function() {
	const modal = $("#myModal");
	const modalCloseBtn = $("#modalCloseBtn");
	var errorValue = "${error}";
	console.log(errorValue);
	
	
	$('#findAccount').on("click", function(e) {
	   e.preventDefault();
	   var operation = $(this).data("oper");
	   
	   if (operation === 'findAccount') {   // 회원가입 버튼
	      self.location = "/findAccount";
	   }
	});

	$("#myModal").modal("hide");
	modal.find("button[id != 'modalCloseBtn']").hide();

	if(errorValue == "계정을 확인해 주세요"){
		$("#myModal").modal("show");
	}
	$("#modalCloseBtn").on("click", function(e) {
		$("#myModal").modal("hide");
		self.location = "/customLogin"
	});
});

</script>
<script>	
	$(document).ready(function(){
		// 저장된 쿠키값을 가져와서 ID 칸에 넣어준다. 없으면 공백으로 들어감.
	    var key = getCookie("key");
	    $("#username").val(key); 
	    // 그 전에 ID를 저장해서 처음 페이지 로딩 시, 입력 칸에 저장된 ID가 표시된 상태라면,
	    if($("#username").val() != ""){ 
	        $("#remember-me").attr("checked", true); // ID 저장하기를 체크 상태로 두기.
	        
	    }
	     
	    $("#remember-me").change(function(){ // 체크박스에 변화가 있다면,
	        if($("#remember-me").is(":checked")){ // ID 저장하기 체크했을 때,
	            setCookie("key", $("#username").val(), 7); // 7일 동안 쿠키 보관
	        }else{ // ID 저장하기 체크 해제 시,
	            deleteCookie("key");
	        }
	    });
	     
	    // ID 저장하기를 체크한 상태에서 ID를 입력하는 경우, 이럴 때도 쿠키 저장.
	    $("#username").keyup(function(){ // ID 입력 칸에 ID를 입력할 때,
	        if($("#remember-me").is(":checked")){ // ID 저장하기를 체크한 상태라면,
	            setCookie("key", $("#username").val(), 7); // 7일 동안 쿠키 보관
	        }
	    });

	// 쿠키 저장하기 
	// setCookie => saveid함수에서 넘겨준 시간이 현재시간과 비교해서 쿠키를 생성하고 지워주는 역할
	function setCookie(cookieName, value, exdays) {
		var exdate = new Date();
		exdate.setDate(exdate.getDate() + exdays);
		var cookieValue = escape(value)
				+ ((exdays == null) ? "" : "; expires=" + exdate.toGMTString());
		document.cookie = cookieName + "=" + cookieValue;
	}

	// 쿠키 삭제
	function deleteCookie(cookieName) {
		var expireDate = new Date();
		expireDate.setDate(expireDate.getDate() - 1);
		document.cookie = cookieName + "= " + "; expires="
				+ expireDate.toGMTString();
	}
     
	// 쿠키 가져오기
	function getCookie(cookieName) {
		cookieName = cookieName + '=';
		var cookieData = document.cookie;
		var start = cookieData.indexOf(cookieName);
		var cookieValue = '';
		if (start != -1) { // 쿠키가 존재하면
			start += cookieName.length;
			var end = cookieData.indexOf(';', start);
			if (end == -1) // 쿠키 값의 마지막 위치 인덱스 번호 설정 
				end = cookieData.length;
                console.log("end위치  : " + end);
			cookieValue = cookieData.substring(start, end);
		}
		return unescape(cookieValue);
	}
	});
</script>

<%@ include file="includes/footer.jsp"%>