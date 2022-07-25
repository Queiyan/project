<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@ include file="includes/header.jsp"%>

<script src="/resources/js/jquery.star-rating-svg.js"></script>
<link rel="stylesheet" href="/resources/css/mypage.css">
<link rel="stylesheet" type="text/css"
	href="/resources/css/star-rating-svg.css">


<div class="section-form">
   <div class="left-section">
      <div class="left-menu change-page" type="button">
         <!-- OnClick="location.href ='http://주소'" -->
         Mypage
      </div>
      <div class="left-menu" type="button" id="completed">완료된 이용자 요청</div>
      <div class="left-menu" type="button" id="managed">완료된 매니저 요청</div>
      <div class="left-menu" type="button" id="mypoint">돌봄페이 충전</div>
   </div>

   <div class="right-section">
      <div class="right-section-left">
         <div class="name">
            <div>Name</div>
         </div>
         <div class="name" ]>
            <div>NickName</div>
         </div>
         <div class="name">
            <div>Email</div>
         </div>
         <div class="name">
            <div>Phone_number</div>
         </div>
         <div class="name">
            <div>Address</div>
         </div>
         <div class="name">
            <div>Pay</div>
         </div>
         <div class="name">
            <div class="review">    
            Review     
            </div>
         </div>
         <button type="button" class="btn btn-dark" id="mypageModBtn">회원정보 수정</button>
         <button type="button" class="btn btn-dark" data-oper="modifyPw" id="modifyPw">비밀번호 변경</button>
                     
      </div>
      <div class="right-section-right">
         <div class="name">
            <div>
               <c:out value="${info.userName}" />
            </div>
         </div>
         <div class="name">
            <div>
               <c:out value="${info.nick}" />
            </div>
         </div>
         <div class="name">
            <div>
               <c:out value="${info.email}" />123
            </div>
         </div>
         <div class="name">
            <div>
               <c:out value="${info.phone}" />
            </div>
         </div>
         <div class="name">
            <div>
               <c:out value="${info.address}" />123
               <c:out value="${info.detailAddress}" />
               <c:out value="${info.extraAddress}" />
            </div>
         </div>
         <div class="name">
            <div>
               <c:out value="${info.userPoint}" />
            </div>
         </div>
         <div class="name">
              <div class="my-rating-2 review"></div>
         </div>
      </div>
   </div>
</div>


<form role="form"
   action="/mypagemod?${_csrf.parameterName}=${_csrf.token}" method="post"
   enctype="multipart/form-data">
   <div class="modal fade" id="myModal" tabindex="-1" role="dialog"
      aria-labelledby="exampleModalLabel" aria-hidden="true">
      <div class="modal-dialog modal-lg">
         <div class="modal-content" style="width:60%; margin-left:10em;">
            <div class="modal-header">
               <h4 class="modal-title" id="myModalLabel">마이페이지 수정</h4>
            </div>
            <div class="col-md-4">
               <label for="validationCustom03" class="content-label">아이디</label> <input
                  type="text" class="form-control" id="validationCustom03"
                  value="<c:out value="${info.userid}"/>" name="userid" readonly>
            </div>
            
            <div class="col-md-3">
               <label for="validationCustom01" class="content-label">이름</label> <input
                  type="text" class="form-control" id="validationCustom01"
                  value="<c:out value="${info.userName}"/>" name="userName" readonly>
               <div class="valid-feedback">이름</div>
            </div>
            <div class="col-md-2">
               <label for="validationCustom04" class="content-label">성별</label> <input readonly
                  class="form-control" id="validationCustom04" name="gender" value="<c:out value="${info.gender}"/>"/>
            </div>
            <div class="col-md-8">
               <label for="validationCustom03" class="content-label">이메일</label> <input
                  type="text" class="form-control" id="email" name="email"
                  value="<c:out value="${info.email}"/>" readonly>
            </div>
            <div class="col-md-4">
               <label for="validationCustom02" class="content-label">닉네임</label> <input
                  type="text" class="form-control" id="validationCustom02"
                  value="<c:out value="${info.nick}"/>" name="nick">
               <div class="valid-feedback">닉네임</div>
            </div>

			<div class="col-md-8">
               <label for="validationCustom03" class="form-address">주소</label>
            </div>
            <div class="col-md-8" style="display: flex;">
                <input
                  type="text" class="form-control" id="sample6_postcode"
                  name="zipCode" value="<c:out value="${info.zipCode}"/>">
                  <input type="button" onclick="sample6_execDaumPostcode()" id="address-forget"
                  value="우편번호 찾기"/>
            </div>
            
            <div class="col-md-8">
               <input type="text" class="form-control" id="sample6_address"
                  name="address" value="<c:out value="${info.address}"/>">
               <input type="text" class="form-control" id="sample6_detailAddress"
                  name="detailAddress"
                  value="<c:out value="${info.detailAddress}"/>">
               <input type="text" class="form-control" id="sample6_extraAddress"
                  name="extraAddress" value="<c:out value="${info.extraAddress}"/>">
            </div>

            <div class="col-md-4">
               <label for="validationCustom03" class="form-label">전화번호</label> <input
                  type="text" class="form-control" id="validationCustom03"
                  name="phone" value="<c:out value="${info.phone}"/>">
            </div>

            


            <div class="modal-footer">
               <button id="modalModBtn" type="submit" class="btn btnprimary">수정</button>
               <button id="modalCloseBtn" type="button" class="btn btndefault">닫기</button>
            </div>
         </div>

      </div>
   </div>
</form>


<div class="modal fade right" id="sitterModal" tabindex="-1" role="dialog" aria-labelledby="sitterModalLabel"
  aria-hidden="true" data-backdrop="false">
  <div class="modal-dialog modal-side modal-bottom-right modal-notify modal-info modal-lg" role="document">
    <!--Content-->
    <div class="modal-content">
      <!--Header-->
      <div class="modal-header text-center">
        <h4 class="modal-title w-100 font-weight-bold">매니저 정보</h4>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">
        </button>
      </div>

      <!--Body-->
      <div class="modal-body">

        <div class="row">
			
          	&nbsp;&nbsp;&nbsp;ID : <div class="col-10 fw-bold" id="sitter"></div>
            &nbsp;&nbsp;&nbsp;돌봄 횟수 : <div class="col-10" id="cnt"></div>
          	&nbsp;&nbsp;&nbsp;별 점 : <div class="my-rating-3 col-10"></div>
          	
          	

          
         </div>
         <br>
         <div  id="reviewSize" class="form-group" style="height: 300px; overflow: outo;">
          
			 <ol class="reviewList list-group list-group-numbered">
			  
			 
			</ol>
		</div>
   
      </div>

      <!--Footer-->
      <div class="modal-footer justify-content-center">
        <a type="button" id="reviewCloseBtn" class="btn btn-outline-info waves-effect" data-dismiss="modal">닫기</a>
      </div>
    </div>
    <!--/.Content-->
  </div>
</div>



<script type="text/javascript" src="/resources/js/sitterInfo.js"></script>

<script>
$(".my-rating-2").starRating({

	totalStars: 5,
	starShape: 'rounded',
	ratedColors: ['orange', 'orange', 'orange', 'orange', 'orange'],

    starSize: 25,
    readOnly: true,

});
$(".my-rating-3").starRating({

	totalStars: 5,
	starShape: 'rounded',
	ratedColors: ['orange', 'orange', 'orange', 'orange', 'orange'],

    starSize: 25,
    readOnly: true,

});
</script>



<script>
   $(document).ready(function() {
      var modal = $("#myModal");
      var modalModBtn = $("#modalModBtn");
      var modalCloseBtn = $("#modalCloseBtn");

      $("#mypageModBtn").on("click", function(e) {
         modal.modal("show");

      });

      $("#modalCloseBtn").on("click", function(e) {
         modal.modal("hide");
      });
      
      $('#modifyPw').on("click", function(e) {
            e.preventDefault();
            var operation = $(this).data("oper");
            
            if (operation === 'modifyPw') {   // 비밀번호 변경 버튼
               self.location = "/modifyPw";
            }
      });

   
   
   
   var sitterVal =  '<c:out value="${info.userid}" />';
   sitterService.get(sitterVal,function(sitterReview) {
	   console.log(sitterVal);
		$(".my-rating-2").starRating('setRating', sitterReview.totalAvg);
		//$("#sitterModal").find("#cnt").text(sitterReview.count); 

		
	});
   
   
   $(".review").on("click", function(e) {
	   
	   
	   sitterService.get(sitterVal,function(sitterReview) {
		   console.log(sitterVal);
			$("#sitterModal").find("#sitter").text(sitterVal); 

			$(".my-rating-3").starRating('setRating', sitterReview.totalAvg);
			$("#sitterModal").find("#cnt").text(sitterReview.count); 

			
		});
	var reviewList = $(".reviewList");
	
	
	sitterService.getList(sitterVal,
		function(list) {
			
			var str = "";
			if (list == null || list.length == 0) {
				$("#reviewSize").css("height","30px");
				reviewList.html("남겨진 리뷰가 없습니다.");
				return;
				} 
			$("#reviewSize").css("height","300px");
			for (var i = 0, len = list.length || 0; i < len; i++) {
				
				
				
				str += '<li class="list-group-item d-flex justify-content-between align-items-start"><div class="col-md-10 ms-2 me-auto"><div> 요청자 : ' + list[i].requester
				+ '</div> 리뷰 : ' + list[i].review + '</div><div> 별점 : ' +list[i].average+ '</div></li>';
					
				} 
			reviewList.html(str);
		});
	$("#sitterModal").modal("show");
   });
   $("#reviewCloseBtn").on("click", function(e){
	   $("#sitterModal").modal("hide");
	});
});
	
   
   
   
</script>

<!-- 주소 api 스크립트 -->
<script
   src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>

   function sample6_execDaumPostcode() {
      new daum.Postcode(
            {
               oncomplete : function(data) {
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
                  if (data.userSelectedType === 'R') {
                     // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                     // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                     if (data.bname !== ''
                           && /[동|로|가]$/g.test(data.bname)) {
                        extraAddr += data.bname;
                     }
                     // 건물명이 있고, 공동주택일 경우 추가한다.
                     if (data.buildingName !== ''
                           && data.apartment === 'Y') {
                        extraAddr += (extraAddr !== '' ? ', '
                              + data.buildingName : data.buildingName);
                     }
                     // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                     if (extraAddr !== '') {
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
                  document.getElementById("sample6_detailAddress")
                        .focus();
               }
            }).open();
      
      
      
      
   }
</script>
<script>
$("#mypoint").on("click", function(){
    self.location = "/charge/myPoint"
 });
$("#completed").on("click", function(){
    self.location = "/completed"
 });
$("#managed").on("click", function(){
    self.location = "/managed"
 });
</script>


<%@ include file="includes/footer.jsp"%>