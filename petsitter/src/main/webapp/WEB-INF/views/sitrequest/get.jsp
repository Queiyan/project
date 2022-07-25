<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@ include file="../includes/header.jsp"%>
<script src="/resources/js/jquery.star-rating-svg.js"></script>
<link rel="stylesheet" href="/resources/css/get.css">
<link rel="stylesheet" type="text/css"
   href="/resources/css/star-rating-svg.css">


<section class="py-5">
   <div class="request-body">
      <sec:authentication property="principal" var="pinfo" />

      
      <div class="row gx-4 gx-lg-5 align-items-center">

         <div class="col-md-3">

            <img class="card-img-top mb-5 mb-md-0" onerror="this.src='/resources/images/logo-white.png'"
               src="<c:out value="${sitrequest.img }"/>" alt="...">
         </div>
         <div class="col-md-9">

            <h3 class="display-9 fw-bolder">
               <c:out value="${sitrequest.title }" />
            </h3>
            <div class="fs-5 writer">     
               <span class="content-name">작성자:  <c:out
                     value="${sitrequest.writer }" /></span>
            </div>

            <p>
               돌봄 가능한 펫:
               <c:out value="${sitrequest.pet }" />
            </p>

            돌봄 횟수 : <span id="cnt"></span>
               <div class="my-rating-2">별점 : </div>
            <div class=""> 
               <span class="content-address">주소 : <c:out
                     value="${sitrequest.address }" /> <c:out
                     value="${sitrequest.detailAddress }" /> <c:out
                     value="${sitrequest.extraAddress }" /></span>
            </div>
            <button class="move btn btn-primary" id="sitterInfoBtn" data-sitter="${sitrequest.writer }">매니저정보</button>
            
            
         </div>

         
         <div class="d-flex content-text">
            <c:out value="${sitrequest.content }" />
            <!-- <input class="form-control text-center me-3" id="inputQuantity"
               type="num" value="1" style="max-width: 3rem"> -->
            <!-- <button class="btn btn-outline-dark flex-shrink-0" type="button">
               <i class="bi-cart-fill me-1"></i> Add to cart
            </button> -->





            <form id="operForm" action="/sitrequest/modify" method="get">
               <input type="hidden" id="sbno" name="sbno"
                  value="${sitrequest.sbno }" /> <input type="hidden"
                  name="pageNum" value="${cri.pageNum }" /> <input type="hidden"
                  name="amount" value="${cri.amount }" /> <input type="hidden"
                  name="type" value="${cri.type }"> <input type="hidden"
                  name="keyword" value="${cri.keyword }">
            </form>
         </div>

      </div>
   </div>
</section>
   
   <sec:authorize access="isAuthenticated()">
         <c:if test="${pinfo.username eq sitrequest.writer }">
            <button data-oper="modify" id="sitrequestModBtn"
               class="btn btn-warning">수정</button>
         </c:if>
      </sec:authorize>
<button data-oper="list" id="sitrequestListBtn" class="btn btn-info">목록</button>
   
   <!-- 덧글쓰기버튼 -->
   <div style="display: flex; justify-content: space-between;">
      <i class="fa fa-comment fa" id="comment-header"></i>
      <sec:authorize access="isAuthenticated()">
         <button type="button" class="btn btn-dark" id="addReplyBtn">요청하기</button>
      </sec:authorize>
   </div>
   <sec:authorize access="isAnonymous()">
      <textarea class="form-control mt-2" id="comment-alert" name="reply"
         rows="3" readonly="readonly">댓글을 달려면 로그인 해주세요.</textarea>
   </sec:authorize>



   <div class="replyList"></div>

   <!-- 댓글 입력 창 -->
   <sec:authorize access="isAuthenticated()">

      <div class="modal fade" id="myModal" tabindex="-1" role="dialog"
         aria-labelledby="exampleModalLabel" aria-hidden="true">
         <div class="modal-dialog modal-lg">
            <div class="modal-content">
               <div class="modal-header">
                  <h4 class="modal-title" id="myModalLabel">요청 창</h4>
               </div>
               <div class="modal-body">
                  <label>작성자</label> <input id="replyer" class="form-control"
                     name="replyer" value="123" readonly="readonly"> <label>내용</label>
                  <textarea class="form-control mt-2" id="reply_content_176"
                     name="reply" rows="3"></textarea>
                  <div class="mb-3">
                     <label> 펫 분류 </label> <input type="text" class="form-control"
                        id="exampleFormControlInput1" name='petType'
                        placeholder="ex)강아지,고양이,이구아나,악어" value="">
                  </div>
                  <div class="mb-3">
                     <label>payment </label> <input type="text" class="form-control"
                        id="exampleFormControlInput1" name='payment' placeholder=""
                        value=""> <span id="ava" class="check-g">포인트가
                        부족합니다.</span>

                  </div>
                  <label>장소</label>
                  <div class="local">
                     <input type="button" id="address-button1"
                        onclick="Daum_Address()" value="주소 찾기"><br> <input
                        type="text" name="address" id="address" placeholder="주소"><br>
                     <input type="text" name="detailAddress" id="detailAddress"
                        placeholder="상세주소"> <input type="text"
                        name="extraAddress" id="extraAddress" placeholder="참고항목">
                  </div>

                  <!-- 날짜 타입 선택창, 기본은 날짜시간 같이하는 타입으로-->
                  <div class=orderType>
                     <input type="radio" name="ordType" id="orderTypeSelect1" 
                        value="datetime" onclick="div_edtchg('datetime')" checked>기간설정
                     <input type="radio" name="ordType" id="orderTypeSelect2"
                        value="settime" onclick="div_edtchg('settime')">타임설정
                  </div>
                  <!-- div_edtchg은 함수호출 이름, 괄호안에는 호출하면서 넘길 값 -->
               <!-- 날짜시간 같이있는 타입 -->
      
                  <div class="orderType date" id="datetimetype">
                     <div class="dateSelectBefore">
                        <p>
                           시작날짜&시간: <input type="text" name="startDateTime"
                              id="startDateTime" readonly="readonly"
                              pattern="yyyy-MM-dd HH:mm">
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
                  <div class="orderType partTime" id="settimetype"
                     style="display: none;">

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
                     시작시간: <input type="text" name="startTime" id="startTime"
                        readonly="readonly" pattern="HH:mm"/>
                  </div>
                  <div class="timeSelectAfter">
                     종료시간: <input type="text" name="endTime" id="endTime"
                        readonly="readonly" pattern="HH:mm"/>
                  </div>
                  </div>

                  <div class="inputArea">
                     <label for="img">이미지</label> <input type="file" id="img"
                        name="file" />
                     <div class="select_img">
                        <img  id="imgfile"/>
                     </div>
                  </div>
               </div>
               <div class="modal-footer">
                  <button id="modalRegisterBtn" type="button" class="btn btnprimary">등록</button>
                  <button id="modalCloseBtn" type="button" class="btn btndefault">닫기</button>
               </div>
            </div>
         </div>
      </div>
   </sec:authorize>

   <!-- 수정용모달 -->
   <div class="modal fade" id="modModal" tabindex="-1" role="dialog"
      aria-labelledby="exampleModalLabel" aria-hidden="true">
      <div class="modal-dialog modal-lg">
         <div class="modal-content">
            <div class="modal-header">
               <h4 class="modal-title" id="myModalLabel">요청 창</h4>
            </div>
            <div class="modal-body">
               <label>작성자</label> <input id="replyer" class="form-control"
                  name="replyer" value="123" readonly="readonly"> <label>내용</label>
               <textarea class="form-control mt-2" id="reply_content_176"
                  name="reply" rows="3"></textarea>
               <div class="mb-3">
                  <label> 펫 종류 </label> <input type="text" class="form-control"
                     id="exampleFormControlInput1" name='petType'
                     placeholder="ex)강아지,고양이,이구아나,악어" value="">
               </div>
               <div class="mb-3">
                  <label>payment </label> <input type="text" class="form-control"
                     id="mod_payment" name='payment' placeholder="" value="">
                  <span id="mod_ava" class="check-g">포인트가 부족합니다.</span>

               </div>
               <label>장소</label>
               <div class="local">
                  <input type="button" id="address-button"
                     onclick="mod_Daum_Address()" value="주소 찾기"><br> <input
                     type="text" name="address" id="mod_address" placeholder="주소"><br>
                  <input type="text" name="detailAddress" id="mod_detailAddress"
                     placeholder="상세주소"> <input type="text"
                     name="extraAddress" id="mod_extraAddress" placeholder="참고항목">
               </div>

               <!-- 날짜 타입 선택창, 기본은 날짜시간 같이하는 타입으로-->
               <div class=orderType>
                  <input type="radio" name="ordType" id="mod_orderTypeSelect1"
                     value="datetime" onclick="mod_div_edtchg('datetime')" checked>기간설정
                  <input type="radio" name="ordType" id="mod_orderTypeSelect2"
                     value="settime" onclick="mod_div_edtchg('settime')">파트타임설정
               </div>
               <!-- div_edtchg은 함수호출 이름, 괄호안에는 호출하면서 넘길 값 -->
            </div>
            <!-- 날짜시간 같이있는 타입 -->
            <div class="modal-body">
               <div class="orderType date" id="mod_datetimetype">
                  <div class="dateSelectBefore">
                     <p>
                        시작날짜&시간: <input type="text" name="startDateTime"
                           id="mod_startDateTime" readonly="readonly"
                           pattern="yyyy-MM-dd HH:mm">
                     </p>
                  </div>

                  <div class="dateSelectAfter">
                     <p>
                        종료날짜&시간: <input type="text" name="endDateTime"
                           id="mod_endDateTime" readonly="readonly"
                           pattern="yyyy-MM-dd HH:mm">
                     </p>
                  </div>
               </div>

               <!-- 날짜 시간 따로 있는 타입 -->
               <div class="orderType partTime" id="mod_settimetype"
                  style="display: none;">

                  <div class="dateSelectBefore">
                     <p>
                        시작날짜: <input type="text" name="startDate" id="mod_startDate"
                           readonly="readonly" pattern="yyyy-MM-dd">
                     </p>
                  </div>

                  <div class="dateSelectAfter">
                     <p>
                        종료날짜: <input type="text" name="endDate" id="mod_endDate"
                           readonly="readonly" pattern="yyyy-MM-dd">
                     </p>
                  </div>

                  <div class="timeSelectBefore">
                     시작시간: <input type="text" name="startTime" id="mod_startTime"
                        readonly="readonly" pattern="HH:mm"/>
                  </div>
                  <div class="timeSelectAfter">
                     종료시간: <input type="text" name="endTime" id="mod_endTime"
                        readonly="readonly" pattern="HH:mm"/>
                  </div>
               </div>

               <div class="inputArea">
                  <label for="mod_img">이미지</label> <input type="file" id="mod_img"
                     name="file" />
                  <div class="mod_select_img">
                     <img id="modImg" src="" />
                  </div>
                  <input type="hidden" name="gdsImg" value="" /> <input
                     type="hidden" name="gdsThumbImg" value="" />
               </div>
            </div>
            <div class="modal-footer">
               <button id="modalModBtn" type="button" class="btn btnwarning">수정</button>
               <button id="modalRemoveBtn" type="button" class="btn btndanger">삭제</button>
               <button id="modmodalCloseBtn" type="button" class="btn btndefault">닫기</button>
            </div>
         </div>
      </div>
   </div>




<!-- 덧글 작성용 모달 끝 -->


<!-- 프로필 보기 모달 -->
<div class="modal fade" id="profileModal" tabindex="-1" role="dialog"
   aria-labelledby="exampleModalLabel" aria-hidden="true">
   <div class="modal-dialog modal-lg">
      <div class="modal-content">
         <div class="modal-header" id="profile-header">
            <h4 class="modal-title" id="myModalLabel">프로필 보기 창</h4>
         </div>
         <div class="modal-body" style="display: flex;">
            <div class="col-md-6">
               <img id="img" alt="이미지가 없습니다" style="width: 300px;height: auto;">
            </div>
            <div class="col-md-6">
               내용 : <span id="replycontent"></span>
            </div>
         </div>
      </div>
   </div>
</div>
<!-- 프로필 보기 끝 -->
<!-- 시터 리뷰 모달 -->
<div class="modal fade right" id="sitterModal" tabindex="-1" role="dialog" aria-labelledby="sitterModalLabel"
  aria-hidden="true" data-backdrop="false">
  <div class="modal-dialog modal-side modal-bottom-right modal-notify modal-info modal-lg" role="document">
    <!--Content-->
    <div class="modal-content">
      <!--Header-->
      <div class="modal-header text-center" id="modal-title">
        <h4 class="modal-title w-100 font-weight-bold">매니저 정보</h4>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">
        </button>
      </div>

      <!--Body-->
      <div class="modal-body">

        <div class="row">
         
             &nbsp;&nbsp;&nbsp;돌봄매니저 : <div class="col-10 fw-bold" id="sitter"></div>
            &nbsp;&nbsp;&nbsp;돌봄 횟수 : <div class="col-10" id="cnt"></div>
             &nbsp;&nbsp;&nbsp;별 점 : <div class="my-rating-3 col-10"></div>
             
             

          
         </div>
         <br>
         <div  id="reviewSize" class="form-group" style="height: 300px; overflow: auto;">
          
          <ol class="reviewList list-group list-group-numbered">
           
          
         </ol>
      </div>
   
      </div>

      <!--Footer-->
      <div class="modal-footer justify-content-center">
        <a type="button" id="sitterModalCloseBtn" class="btn btn-outline-info waves-effect" data-dismiss="modal">닫기</a>
      </div>
    </div>
    <!--/.Content-->
  </div>
</div>



<form id="matchingForm" action="/sitrequest/matching" method="post">
   <input type="hidden" name="${_csrf.parameterName }"
      value="${_csrf.token}" /> <input type="hidden" name="sbno"
      value="${sitrequest.sbno}"> <input type="hidden" name="writer"
      value="${sitrequest.writer}"> <input type="hidden"
      name="requester" id="matchingRequester" value=""> <input
      type="hidden" name="rsbno" id="matchingrsbno" value="">

</form>

<script type="text/javascript" src="/resources/js/sitreply.js"></script>
<script type="text/javascript" src="/resources/js/sitterInfo.js"></script>


<script src="/resources/js/mdtimepicker.js"></script>
<script src="/resources/js/jquery.datetimepicker.full.min.js"></script>
<script src="/resources/js/datepicker.js"></script>

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
// 날짜 타입 선택 스크립트
function div_edtchg(type) {
   if (type=="datetime") {   
      document.getElementById('startDate').value ='';
      document.getElementById('endDate').value ='';
      document.getElementById('startTime').value ='';
      document.getElementById('endTime').value ='';
      document.getElementById('datetimetype').style.display="";
      document.getElementById('settimetype').style.display="none";

   } else if (type=="settime") {
      document.getElementById('startDateTime').value ='';
      document.getElementById('endDateTime').value ='';
      document.getElementById('settimetype').style.display="";
      document.getElementById('datetimetype').style.display="none";

   }
}
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

<!-- 수정용 날짜 -->
<script>
// 시작 시간 선택 스크립트 호출&속성
jQuery('#mod_startTime').mdtimepicker({
   timeFormat: 'hh:mm', // format of the time value (data-time attribute)
    format: 'hh:mm',    // format of the input value
    readOnly: false,       // determines if input is readonly
    hourPadding: false,
    theme: 'black',
    okLabel: '확인',
    cancelLabel: '취소',
});
//종료 시간 선택 스크립트 호출&속성
jQuery('#mod_endTime').mdtimepicker({
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
// 날짜 타입 선택 스크립트
function mod_div_edtchg(type) {
   if (type=="datetime") {   
      document.getElementById('mod_startDate').value ='';
      document.getElementById('mod_endDate').value ='';
      document.getElementById('mod_startTime').value ='';
      document.getElementById('mod_endTime').value ='';
      document.getElementById('mod_datetimetype').style.display="";
      document.getElementById('mod_settimetype').style.display="none";

   } else if (type=="settime") {
      document.getElementById('mod_startDateTime').value ='';
      document.getElementById('mod_endDateTime').value ='';
      document.getElementById('mod_settimetype').style.display="";
      document.getElementById('mod_datetimetype').style.display="none";

   }
}
</script>


<script>
// 날짜선택 호출
   $(function(){
      $("#mod_startDate").datepicker({
         dateFormat: 'yy-mm-dd'
       });
   });
   $(function(){
      $("#mod_endDate").datepicker({
         dateFormat: 'yy-mm-dd'
       });
   });
</script>
<script>
//날짜시간선택 호출과 옵션
   $(function() {
      $("#mod_startDateTime").datetimepicker({
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
      $("#mod_endDateTime").datetimepicker({
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
<!-- 수정용 날짜 끝 -->
<script>
$(".my-rating-2").starRating({
   totalStars: 5,
   starShape: 'rounded',
   ratedColors: ['orange', 'orange', 'orange', 'orange', 'orange'],

    starSize: 25,
    readOnly: true,
    callback: function(currentRating, $el){
        // make a server call here
    }
});
</script>
<script>
   $(document).ready(function() {
      
      var csrfHeaderName = "${_csrf.headerName}";
      var csrfTokenValue = "${_csrf.token}";
      
      $(document).ajaxSend(function(e,xhr,options){
         xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
      });
      
      $("#ava").css("display", "none");
       $("#mod_ava").css("display", "none");


      
      var formObj = $("#operForm");
      
      $("#sitrequestModBtn").on("click", function(e){
         e.preventDefault();
         var operation = $(this).data("oper");
         console.log(operation);
         if (operation === 'modify') {
            formObj.attr("action", "/sitrequest/modify");
         }
         formObj.submit();
      });
      
      $("#sitrequestListBtn").on("click", function(e) {
         e.preventDefault();
         var operation = $(this).data("oper");
         console.log(operation);
         if(operation === 'list') {
            formObj.attr("action", "/sitrequest/list");
            formObj.find("#sbno").remove();
         }
         formObj.submit();
      });
      
      console.log(replyService);
      var sbnoValue = '<c:out value="${sitrequest.sbno}"/>';
      var loginUser = null;
     var writer = '<c:out value="${sitrequest.writer }" />';

      <sec:authorize access="isAuthenticated()">
      loginUser= '<sec:authentication property="principal.username"/>';
      </sec:authorize>
      
      /* replyService.add({
         reply : "js test",
         replyer : "tester",
         sbno : sbnoValue
      }, function(result) {
         alert("result: " + result);
      }); */
      
      var modal = $("#myModal");
      
      var modalInputReplyer = modal.find("input[name='replyer']");
      var modalInputReply = modal.find("textarea[name='reply']");
      var modalInputPetType = modal.find("input[name='petType']");
      var modalInputaddress = modal.find("input[name='address']");
      var modalInputdetailAddress = modal.find("input[name='detailAddress']");
      var modalInputextraAddress = modal.find("input[name='extraAddress']");
      var modalInputStartDateTime = modal.find("input[name='startDateTime']");
      var modalInputEndDateTime = modal.find("input[name='endDateTime']");
      var modalInputStartDate = modal.find("input[name='startDate']");
      var modalInputEndDate = modal.find("input[name='endDate']");
      var modalInputStartTime = modal.find("input[name='startTime']");
      var modalInputEndTime = modal.find("input[name='endTime']");
      var modalInputPayment = modal.find("input[name='payment']");
     // var imgfile =document.getElementById("imgfile").src;   
      
      var modalRegisterBtn = $("#modalRegisterBtn");
      var modalModBtn = $("#modalModBtn");
      var modalRemoveBtn = $("#modalRemoveBtn");
      var userPoint;
      
      var gap;
      $("#addReplyBtn").on("click", function(e){
         /* modal.find("input").val(""); */
         modal.find("input[name='replyer']").val(loginUser);
         modal.find("input[name='replyer']").attr("readonly","readonly");
         
         $.get("/getInfo/" + loginUser, function(data) {
           userPoint = data.userPoint;
              modal.find("input[name='payment']").attr("placeholder","보유point : "+userPoint);

        });


         modal.find("button[id != 'modalCloseBtn']").hide();
         modalRegisterBtn.show();
         
         modalInputReply.val(null);
         

         $("#mod_orderTypeSelect1").prop("checked",true);

         
         $("#myModal").modal("show");
         
         
         modal.find("input[name='payment']").change(function() {
               var payment = $(this).val();
               console.log(payment);
               
               console.log(userPoint);

              if (parseInt(payment) > parseInt(userPoint)) {
                 alert("보유포인트가 부족합니다.");
                 $("#ava").css("display", "block");
                 modal.find("input[name='payment']").val('');
                 $(this).focus();
                 return false;
              }
              else {
                $("#ava").css("display", "none");

              }
            });
         
      });
      
      $("#modalCloseBtn").on("click", function(e){
         modal.modal("hide");
         
      });

      
      

      
      modalRegisterBtn.on("click", function(e){
          var form = new FormData();

/*          const reply = {
               reply : modalInputReply.val(),
               replyer : modalInputReplyer.val(),
               petType : modalInputPetType.val(),
               address : modalInputaddress.val(),
               detailAddress : modalInputdetailAddress.val(),
               extraAddress : modalInputextraAddress.val(),
               startDateTime : modalInputStartDateTime.val(),
               endDateTime : modalInputEndDateTime.val(),
               startDate : modalInputStartDate.val(),
               endDate : modalInputEndDate.val(),
               startTime : modalInputStartTime.val(),
               endTime : modalInputEndTime.val(),
               sbno : sbnoValue,
               file : file
         }; */
          if(imgfile==null){
             alert('사진을 등록해주세요.');
          }
          
          console.log(imgfile);
         
         
         form.append( "file", $("#img")[0].files[0] );
         form.append( "reply", modalInputReply.val() );
         form.append( "replyer", modalInputReplyer.val() );
         form.append( "petType", modalInputPetType.val() );
         form.append( "address", modalInputaddress.val() );
         form.append( "detailAddress", modalInputdetailAddress.val() );
         form.append( "extraAddress", modalInputextraAddress.val() );
         form.append( "startDateTime", modalInputStartDateTime.val() );
         form.append( "endDateTime", modalInputEndDateTime.val() );
         form.append( "startDate", modalInputStartDate.val() );
         form.append( "endDate", modalInputEndDate.val() );
         form.append( "startTime", modalInputStartTime.val() );
         form.append( "endTime", modalInputEndTime.val() );
         form.append( "sbno", sbnoValue );
         form.append("payment", modalInputPayment.val());
         
         
         
         replyService.add(form, function(result){
            alert(result);
            modal.find("input").val("");
            modal.modal("hide");
            showList(-1);
            location.reload();
         });
         
         var payment = modalInputPayment.val();
         var point = payment * -1;
         $.ajax({
                   type: "get",
                   url: "/charge/user/point", 
                   data: {
                       "amount" : point,
                   },
               });
      });
      
      /* replyService.getList({
         sbno : sbnoValue,
         page : 1
      }, function(list){
         for (var i = 0, len = list.length || 0; i < len; i++) {
            console.log(list[i]);
         }
      }); */
      
      var replyUL = $(".replyList");
      
      function showList(page) {
         console.log(page);
         replyService.getList({
            sbno : sbnoValue,
            page : page || 1
         }, function(replyTotalCnt, list) {
            console.log("replyTotalCnt :" + replyTotalCnt);
            
            if(page == -1) {
               pageNum = Math.ceil(replyTotalCnt / 10.0);
               showList(pageNum);
               return;
            }
            var str="";
            if(list==null || list.length == 0) {
               replyUL.html("");
               return;
            }
            for(var i = 0, len=list.length || 0; i < len; i++){
               str += '<div id="enroll" class="card mt-2" data-sitter="'+list[i].replyer + '" data-rsbno="'+list[i].rsbno +'"><div class="card-header p-2"><table style="color: white;"><tbody><tr class="align-middle">';
            str += '<td rowspan="2" class="pr-2"></td><td class="ml">'+
               list[i].replyer + '</td></tr><tr><td><font size="2">'+
               replyService.displayTime(list[i].replyDate)+'</font></td></tr></tbody></table></div><div class="card-body"><p class="card-text"><input id="rsbno" type="hidden" value="'+
               list[i].rsbno +'"<textarea class="form-control mt-2" id="reply_content_176" readonly="readonly" name="reply" rows="3">' 
               /* +list[i].reply */+'</textarea></p>';
            if(list[i].petType!=null){
               str += '<div class="body-pettype" name="petType">동물종류: '+list[i].petType+'</div>';
            }
            /* if(list[i].petType!=null){   
               str += '<div class="body-pettype" name="petType">사진: <img src="'+list[i].img+'"></div>';
            } */
            if(list[i].address!=null){
               str += '<div class="body-place" name="petType">주소: '+list[i].address+' '
               +list[i].detailAddress+list[i].extraAddress+'</div>';
            }

            if(list[i].startDateTime!=null&&list[i].startDate==null){   
               str += '<div class="body-DateTime" name="startDateTime">기간 : '+list[i].startDateTime+' ~ '+list[i].endDateTime+'</div>';
               
            }
            if(list[i].payment!=null){   
                str += '<div class="body-DateTime" name="payment">Pay : '+list[i].payment+'</div>';
                
             }
            if(list[i].startDate!=null&&list[i].startDateTime==null){
               str += '<div class="body-DateTime" name="startDate">시작 날짜: '+list[i].startDate+'</div>';
               str += '<div class="body-DateTime" name="endDate">종료 날짜: '+list[i].endDate+'</div>';
               
               str += '<div class="body-DateTime">파트타임: '+list[i].startTime+' ~ ';
               str += list[i].endTime+'</div>';
            }
            <sec:authorize access="isAuthenticated()">

            if(loginUser == list[i].replyer){
            str += '<button type="button" name="modBtn" class="modBtn btn btn-outline-dark flex-shrink-0" data-rsbno="'+list[i].rsbno +'">수정</button>';
            str += '<button type="button" name="removeBtn" class="removeBtn btn btn-outline-dark flex-shrink-0" data-payment="'+list[i].payment+'" data-rsbno="'+list[i].rsbno +'">삭제</button>';
            }
            if(loginUser == writer && loginUser != list[i].replyer){
               str += '<button type="button" class="matchingBtn btn btn-outline-dark flex-shrink-0" data-rsbno="'+list[i].rsbno +'" data-requester="'+list[i].replyer + '">매칭</button>';
               str += '<button type="button" name="profile" class="profileBtn btn btn-outline-dark flex-shrink-0" data-rsbno="'+list[i].rsbno +'" data-requester="'+list[i].replyer + '">자세히 보기</button>';
            }
            </sec:authorize>
            str += '</div></div>';

         /*       str += "<li class='left clearfix' data-rsbno='"+
               list[i].rsbno +"'><div><div class='header'><strong class='primary-font'>"+
               list[i].replyer+"</strong><small class='float-sm-right'>"+
               replyService.displayTime(list[i].replyDate) +"</small></div><p>"+
               list[i].reply + "</p></div></li>"; */
            }
            replyUL.html(str);
            
            showReplyPage(replyTotalCnt);
            
            
         });
      }
      showList(-1);
      
      var pageNum = 1;
      var replyPageFooter = $(".panel-footer");
      function showReplyPage(replyCnt) {
         var endNum = Math.ceil(pageNum / 10.0) * 10;
         var startNum = endNum - 9;
         var prev = startNum != 1;
         var next = false;
         
         if(endNum * 10 >= replyCnt){
               endNum = Math.ceil(replyCnt / 10.0);
         }
         if(endNum * 10 < replyCnt){
            next = true;
         }
         var str = "<ul class='pagination justify-content-center'>";
         if (prev) {
            str += "<li class='page-item'><a class='page-link' href='" +
            (startNum - 1) +"'>이전</a></li>";
         }
         for (var i = startNum; i <= endNum; i++) {
            var active = pageNum == i ? "active" : "";
            str += "<li class='page-item " + active + "'><a class='page-link' href='" +
            i + "'>" + i + "</a></li>";
         }
         if (next) {
            str += "<li class='page-item'> <a class='page-link' href='" +
            (endNum + 1) + "'>다음</a></li>";

         }
         str += "</ul>";
         console.log(str);
         replyPageFooter.html(str);
      }
      
      replyPageFooter.on("click", "li a", function(e){
         e.preventDefault();
         var targetPageNum = $(this).attr("href");
         pageNum = targetPageNum;
         showList(pageNum);
      });
      var modModal = $("#modModal");
      // 목록에서 댓글  수정창 띄우기
      $("#modmodalCloseBtn").on("click", function(e){
          modModal.modal("hide");
       });
      
      $(".replyList").on("click","button[name='modBtn']", function(e) {
         const rsbno = new $(this).data("rsbno");
         console.log(rsbno); 
         $.get("/getInfo/" + loginUser, function(data) {
           userPoint = data.userPoint;
          
        });
         
         replyService.get(rsbno, function(reply){
           
           
           modModal.find("input[name='replyer']").val(reply.replyer);
           modModal.find("textarea[name='reply']").val(reply.reply);
           modModal.find("input[name='petType']").val(reply.petType);
           modModal.find("input[name='address']").val(reply.address);
           modModal.find("input[name='detailAddress']").val(reply.detailAddress);
           modModal.find("input[name='extraAddress']").val(reply.extraAddress);
           modModal.find("input[name='startDateTime']").val(reply.startDateTime);
           modModal.find("input[name='endDateTime']").val(reply.endDateTime);
           modModal.find("input[name='startDate']").val(reply.startDate);
           modModal.find("input[name='endDate']").val(reply.endDate);
           modModal.find("input[name='startTime']").val(reply.startTime);
           modModal.find("input[name='endTime']").val(reply.endTime);
           modModal.find("input[name='payment']").val(reply.payment);
           modModal.find("input[name='gdsImg']").val(reply.img);
           modModal.find("input[name='gdsThumbImg']").val(reply.thumbImg);
           $("#modImg").attr("src",reply.thumbImg);


           
           if(reply.startDate==null&&reply.startDateTime==null){
                $("#mod_orderTypeSelect1").prop("checked",true);
                $("#mod_orderTypeSelect2").prop("checked",false);
             }
           else if(reply.startDate==null&&reply.startDateTime!=null){
               $("#mod_orderTypeSelect1").prop("checked",true);
               $("#mod_orderTypeSelect2").prop("checked",false);
               
              document.getElementById('mod_settimetype').style.display="none";
              document.getElementById('mod_datetimetype').style.display="";
            }
           else if(reply.startDate!=null&&reply.startDateTime==null){
               $("#mod_orderTypeSelect2").prop("checked",true);
               $("#mod_orderTypeSelect1").prop("checked",false);
              document.getElementById('mod_datetimetype').style.display="none";
              document.getElementById('mod_settimetype').style.display="";
            }
            
            
           
            var totalPoint = parseInt(userPoint) + parseInt(reply.payment);
            $("#mod_payment").attr("placeholder","보유point : "+userPoint + "게"+reply.payment +"총"+totalPoint);

            
            $("#mod_payment").change(function() {
               payment = $(this).val();         
              gap = parseInt(payment) - parseInt(reply.payment);

               if (parseInt(payment) > parseInt(reply.payment)) {
                 if (parseInt(gap) > parseInt(userPoint)) {
                    alert("보유포인트가 부족합니다.");
                    $("#mod_ava").css("display", "block");
                    $("#mod_payment").val('');
                    $(this).focus();
                    return false;
                 }
                 else {
                   $("#mod_ava").css("display", "none");
                 }
               }
            });
            
            
            modModal.data("rsbno",reply.rsbno);
            modModal.data("payment",reply.payment);

            modalModBtn.show();
            modalRemoveBtn.show();
            
            $("#modModal").modal("show");
         });
      });
      
      
      // 목록에서 댓글 프로필 보기

      $(".replyList").on("click","button[name='profile']", function(e) {
         const rsbno = new $(this).data("rsbno");
         console.log(rsbno);
         
         replyService.get(rsbno, function(reply){
             $("#profileModal").find("#img").attr("src",reply.img);
             $("#profileModal").find("#replycontent").text(reply.reply);

            

            modal.data("rsbno",reply.rsbno);
            modal.find("button[id !='modalCloseBtn']").hide();
            
            $("#profileModal").modal("show");
         });
      });
         
      // 목록에서 댓글 삭제
      $(".replyList").on("click","button[name='removeBtn']", function(e) {
         const rsbno = new $(this).data("rsbno");
         const payment = new $(this).data("payment");

         console.log(rsbno);
          
          replyService.remove(rsbno, loginUser, function(result){
             alert(result);
             
             $.ajax({
                 type: "get",
                 url: "/charge/user/point", 
                 data: {
                     "amount" : payment
                 },

             });
             modal.modal("hide");
             showList(-1);
             
          });
       });

      modalModBtn.on("click", function(e){
/*           const reply = {
                rsbno : modModal.data("rsbno"),
                reply : modModal.find("textarea[name='reply']").val(),
                replyer : loginUser,
                petType : modModal.find("input[name='petType']").val(),
                address :modModal.find("input[name='address']").val(),
                detailAddress : modModal.find("input[name='detailAddress']").val(),
                extraAddress : modModal.find("input[name='extraAddress']").val(),
                startDateTime : modModal.find("input[name='startDateTime']").val(),
                endDateTime : modModal.find("input[name='endDateTime']").val(),
                startDate : modModal.find("input[name='startDate']").val(),
                endDate : modModal.find("input[name='endDate']").val(),
                startTime : modModal.find("input[name='startTime']").val(),
                endTime : modModal.find("input[name='endTime']").val(),
                payment : modModal.find("input[name='payment']").val(),
                sbno : sbnoValue
                

          }; */
          var modForm = new FormData();
          




          modForm.append( "file", $("#mod_img")[0].files[0] );
          modForm.append( "rsbno", modModal.data("rsbno") );
          modForm.append( "reply", modModal.find("textarea[name='reply']").val() );
          modForm.append( "replyer", loginUser );
          modForm.append( "petType", modModal.find("input[name='petType']").val() );
          modForm.append( "address", modModal.find("input[name='address']").val() );
          modForm.append( "detailAddress", modModal.find("input[name='detailAddress']").val() );
          modForm.append( "extraAddress", modModal.find("input[name='extraAddress']").val() );
          modForm.append( "startDateTime", modModal.find("input[name='startDateTime']").val() );
          modForm.append( "endDateTime",  modModal.find("input[name='endDateTime']").val() );
          modForm.append( "startDate", modModal.find("input[name='startDate']").val() );
          modForm.append( "endDate", modModal.find("input[name='endDate']").val() );
          modForm.append( "startTime", modModal.find("input[name='startTime']").val() );
          modForm.append( "endTime", modModal.find("input[name='endTime']").val() );
          modForm.append( "sbno", sbnoValue );
          modForm.append("payment", modModal.find("input[name='payment']").val());
          modForm.append("img", modModal.find("input[name='gdsImg']").val());
          modForm.append("thumbImg", modModal.find("input[name='gdsThumbImg']").val());

          var rsbno = modModal.data("rsbno");
       console.log(modForm);
          
          replyService.update(modForm,rsbno, function(result){
             alert(result);
             modModal.find("input").val("");
             
             console.log("gap"+gap);

            var mGap = gap * -1;
            console.log("gap"+mGap);

             $.ajax({
               type: "get",
               url: "/charge/user/point", 
               data: {
                   "amount" : mGap
               },

           });
             
             modModal.modal("hide");
             showList(-1);
             location.reload();
          });
          
       });
      
      modalRemoveBtn.on("click", function(e){
         var rsbno = modModal.data("rsbno");
         var payment = modModal.data("payment");


         replyService.remove(rsbno, loginUser, function(result){
            alert(result);
            $.ajax({
                type: "get",
                url: "/charge/user/point", 
                data: {
                    "amount" : payment,
                },

            });

            
            modModal.modal("hide");
            showList(-1);
         });
      });
      
      
      $(".replyList").on("click", ".matchingBtn", function(e) {
         console.log($(this).data("requester"));
         var requesterVal = $(this).data("requester");
         var rsbnoVal =$(this).data("rsbno");
         
         $("#matchingRequester").val(requesterVal);
         $("#matchingrsbno").val(rsbnoVal);

         $("#matchingForm").submit();
         
      });
      
      

      var sitterVal = '<c:out value="${sitrequest.writer }" />';
      sitterService.get(sitterVal,function(sitterReview) {
         $(".my-rating-2").starRating('setRating', sitterReview.totalAvg, true);
         $("#cnt").text(sitterReview.count);   
   
      });
      
      $(".move").on("click", function(e) {
         console.log(sitterVal);

         $(".my-rating-3").starRating({
            initialRating: 1,
            totalStars: 5,
            starShape: 'rounded',
            ratedColors: ['orange', 'orange', 'orange', 'orange', '#CCCCCC'],

             starSize: 25,
             readOnly: true,

         });
         $(".my-rating-3").starRating('setRating', 5, true);

         $(".my-rating-3").starRating({

            ratedColors: ['orange', 'orange', 'orange', 'orange', 'orange'],


         });

         
         sitterService.get(sitterVal,function(sitterReview) {
            $("#sitterModal").find("#sitter").text(sitterVal);
            $(".my-rating-3").starRating('setRating', sitterReview.totalAvg);
            $("#sitterModal").find("#avg").text(sitterReview.totalAvg);
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

                  // 리뷰, 작성자, 평점, 날짜
                  
                  

                  } 
               reviewList.html(str);
            });
      
         
         $("#sitterModal").modal("show");
         
      });
      $("#sitterModalCloseBtn").on("click", function(e){
         $("#sitterModal").modal("hide");
      });
         

   });
</script>


<script
   src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
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
    function mod_Daum_Address() {
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
                    document.getElementById("mod_extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("mod_extraAddress").value = '';
                }

                document.getElementById("mod_address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("mod_detailAddress").focus();
            }
        }).open();
    }
</script>
<!-- 파일 등록되면 현재화면에서 어떤 이미지 인지 보여주는 스크립트-->
<script>
  $("#img").change(function(){
   if(this.files && this.files[0]) {
    var reader = new FileReader;
    reader.onload = function(data) {
     $(".select_img img").attr("src", data.target.result).width(150);        
    }
    reader.readAsDataURL(this.files[0]);
   }
  });
 </script>
<script>
  $("#mod_img").change(function(){
   if(this.files && this.files[0]) {
    var reader = new FileReader;
    reader.onload = function(data) {
     $(".mod_select_img img").attr("src", data.target.result).width(150);        
    }
    reader.readAsDataURL(this.files[0]);
   }
  });
 </script>

<%@ include file="../includes/footer.jsp"%>