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
               src="<c:out value="${request.img }"/>" alt="...">
         </div>
         <div class="col-md-9">

            <h3 class="display-9 fw-bolder">
               <c:out value="${request.title }" />
            </h3>
            <div class="fs-5 writer">     
               <span class="content-name">작성자:  <c:out
                     value="${request.writer }" /></span>
            </div>

            <p>
               펫 종류:
               <c:out value="${request.pet }" />
            </p>

            <p>
               돌봄 페이:
               <c:out value="${request.payment }" />원
            </p>
            <div class=""> 
               <span class="content-address">주소: <c:out
                     value="${request.address }" /> <c:out
                     value="${request.detailAddress }" /> <c:out
                     value="${request.extraAddress }" /></span>
            </div>
            <!-- 날짜 타입 1의 값이 있을 때 -->
            <c:if test="${not empty request.startDateTime}">
               <div class="date" >
                  돌봄 기간: <span class="content-date"><fmt:formatDate
                        value="${request.startDateTime }" pattern="yyyy-MM-dd HH:mm" /></span>
                  ~ <span class="content-date"><fmt:formatDate
                        value="${request.endDateTime }" pattern="yyyy-MM-dd HH:mm" /></span>
               </div>
            </c:if>
            <!-- 날짜 타입 1의 값이 없을 때 -->
            <c:if
               test="${empty request.startDateTime and not empty request.startDate}">
               <div class="content-date-1">
                  <span class="content-date">돌봄 기간 : <fmt:formatDate
                        value="${request.startDate }" pattern="yyyy-MM-dd" /></span> <span
                     class="content-date">~<fmt:formatDate
                        value="${request.endDate }" pattern="yyyy-MM-dd" /></span>
               </div>
               
               <div class="partTime">파트타임 : 
                  <fmt:formatDate value="${request.startTime }" pattern="HH:mm" />
                  ~
                  <fmt:formatDate value="${request.endTime }" pattern="HH:mm" />
               </div>
            </c:if>

         </div>

         
         <div class="d-flex content-text">
            <c:out value="${request.content }" />
            <!-- <input class="form-control text-center me-3" id="inputQuantity"
               type="num" value="1" style="max-width: 3rem"> -->
            <!-- <button class="btn btn-outline-dark flex-shrink-0" type="button">
               <i class="bi-cart-fill me-1"></i> Add to cart
            </button> -->





            <form id="operForm" action="/request/modify" method="get">
               <input type="hidden" id="rbno" name="rbno" value="${request.rbno }" />
               <input type="hidden" name="pageNum" value="${cri.pageNum }" /> <input
                  type="hidden" name="amount" value="${cri.amount }" /> <input
                  type="hidden" name="type" value="${cri.type }"> <input
                  type="hidden" name="keyword" value="${cri.keyword }">
            </form>
         </div>

      </div>
   </div>
</section>

<sec:authorize access="isAuthenticated()">
         
         <c:if test="${pinfo.username eq request.writer }">
            <button data-oper="modify" id="requestModBtn"
               class="btn btn-warning">수정</button>
         </c:if>
      </sec:authorize>
<button data-oper="list" id="requestListBtn" class="btn btn-info">목록</button>

<!-- 댓글 입력 창 -->
<div class="card mb-2" id="comment-card">
   <div class="comment-header">
      <i class="fa fa-comment fa"></i> 댓글
   </div>
   <div class="card-body">
      <ul class="list-group list-group-flush">
         <li class="list-group-item">
            <form id="boardReplyFrm_176">
               <sec:authorize access="isAnonymous()">
                  <textarea class="form-control mt-2" id="reply_content_176"
                     name="reply" rows="3" readonly="readonly">로그인 해주세요.</textarea>
               </sec:authorize>


               <sec:authorize access="isAuthenticated()">
                  <label>작성자</label>
                  <input id="replyer" class="form-control" name="replyer"
                     value='<sec:authentication property="principal.username"/>'
                     readonly="readonly">
                  <textarea class="form-control mt-2" id="reply_content"
                     name="reply" rows="3" value=""></textarea>

               </sec:authorize>


            </form> <sec:authorize access="isAuthenticated()">
               <button type="button" class="btn btn-dark" id="addReplyBtn">등록</button>
            </sec:authorize>

         </li>
      </ul>
   </div>
</div>

<div class="replyList"></div>
<div class="panel-footer"></div>

<div class="modal fade right" id="myModal" tabindex="-1" role="dialog" aria-labelledby="sitterModalLabel"
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
                  &nbsp;&nbsp;&nbsp;별 점 : <div class="col-10 my-rating-2"></div>
                   
                   
      
                
               </div>
               <br>
               <div id="reviewSize" class="form-group" style="height: 300px; overflow: auto;">

               <ol class="reviewList list-group list-group-numbered">


               </ol>
            </div>

         </div>

         <form id="matchingForm" action="/request/matching" method="post">
            <input type="hidden" name="${_csrf.parameterName }"
               value="${_csrf.token}" /> <input type="hidden" name="rbno"
               value="${request.rbno}"> <input type="hidden" name="writer"
               value="${request.writer}"> <input type="hidden"
               name="sitter" id="matchingSitter" value="">




            <div class="modal-footer">
               <button id="modalMatchingBtn" type="submit"
                  class="matching btn btnwarning">매칭</button>
               <button id="modalCloseBtn" type="button" class="btn btndefault">닫기</button>
            </div>
         </form>
      </div>
      <!--/.Content-->
   </div>
</div>






<script type="text/javascript" src="/resources/js/reply.js"></script>
<script type="text/javascript" src="/resources/js/sitterInfo.js"></script>


<script>


$(document).ready(function() {
   var csrfHeaderName="${_csrf.headerName}";
   var csrfTokenValue="${_csrf.token}";
   
   $(document).ajaxSend(function(e,xhr,options){
      xhr.setRequestHeader(csrfHeaderName,csrfTokenValue);
   });
   
   var formObj = $("#operForm");/* 문서중 form 요소를 찾아서 변수에 할당. */
   $("#requestModBtn").on("click", function(e) {
      e.preventDefault();
      var operation = $(this).data("oper");
      /* 버튼에서 oper 속성 읽어서 변수에 할당. */
      console.log(operation);
      /* 브라우저 로그로 oper값 출력. */
      if (operation === 'modify') {
         formObj.attr("action", "/request/modify");
         /* form에 액션 속성을 변경. */
      }
      formObj.submit();
   });
   $("#requestListBtn").on("click", function(e) {
      e.preventDefault();
      var operation = $(this).data("oper");
      /* 버튼에서 oper 속성 읽어서 변수에 할당. */
      console.log(operation);
      /* 브라우저 로그로 oper값 출력. */
      if (operation === 'list') {
         
         formObj.attr("action", "/request/list");
         formObj.find("#rbno").remove();
         // form 에서 아이디 bno 요소를 찾아서 삭제.
      }
      formObj.submit();
   });
   
   var rbnoValue = '<c:out value="${request.rbno}"/>';
   

   var inputReply = $("#reply_content");
   
   var inputReplyer = $("#replyer");
   var writer = '<c:out value="${request.writer }" />';
   <sec:authorize access="isAuthenticated()">
   var loginUser='<sec:authentication property="principal.username"/>';
   </sec:authorize>
   

   
   
   $("#addReplyBtn").on("click", function(e) {
      // 덧글 등록    버튼을 눌렀다면, 
      var reply = {
         reply : inputReply.val(),
         replyer : inputReplyer.val(),
         rbno : rbnoValue
      }; // ajax로 전달할 reply 객체 선언 및 할당.
         replyService.add(reply, function(result) {
         alert(result);
         showList(-1);
      });
      inputReply.val("");
   });

   var replyUL = $(".replyList");
   function showList(page) {
      replyService.getList( {
         rbno : rbnoValue,
         page : page || 1 },
         function(replyTotalCnt ,list) {
            console.log("replyTotalCnt :"+ replyTotalCnt); 
            if (page == -1) { 
               // 페이지 번호가 음수 값 이라면, 
               pageNum = Math.ceil(replyTotalCnt / 10.0); 
               // 덧글의 마지막 페이지 구하기. 
               showList(pageNum); 
               // 덧글 목록 새로고침(갱신) 
               return; 
               }
            var str = "";
            if (list == null || list.length == 0) {
               replyUL.html("");
               return;
               } 
            for (var i = 0, len = list.length || 0; i < len; i++) {
         
               
               str += '<div id="enroll" class="card mt-2" data-replyer="'+list[i].replyer + '" data-rrno="'+list[i].rrno +'"><div class="comment-header p-2"><table><tbody><tr class="align-middle">';
               str += '<td rowspan="2" class="pr-2"></td><td class="comment-writer">'+
                  list[i].replyer + '</td></tr><tr><td><font size="2">'+
                  replyService.displayTime(list[i].replyDate)+'</font></td></tr></tbody></table></div><div class="card-body"><p class="card-text"><input id="rrno" type="hidden" value="'+
                  list[i].rrno +'"<textarea class="form-control mt-2" id="reply_content" readonly="readonly" name="reply" rows="3">' 
                  +list[i].reply+'</textarea></p>';
               <sec:authorize access="isAuthenticated()">
               if(loginUser == list[i].replyer){
                  str += '<button type="button" class="modBtn btn btn-outline-dark flex-shrink-0">수정</button> <button type="button" class="removeBtn btn btn-outline-dark flex-shrink-0">삭제</button>';
               }
               if(loginUser == writer && loginUser != list[i].replyer){
                  str += '<button type="button" class="infoBtn btn btn-outline-dark flex-shrink-0" data-sitter="'+
                     list[i].replyer + '">정보</button> <button type="button" class="matchingBtn btn btn-outline-dark flex-shrink-0" data-sitter="'+list[i].replyer + '">매칭</button>';
               }
               </sec:authorize>
                  str += '</div></div>';
            }
               

            replyUL.html(str);
            
            //삭제 시작
            
            
            $(".removeBtn").on("click", function(e) {
               var rrno = $(this).parents("#enroll").data("rrno");
               var replyer = $(this).parents("#enroll").data("replyer");

               replyService.remove(rrno,replyer, function(result) {

               alert(result);
               });
               showList(-1);
            });
            

            //수정시작
            $(".modBtn").click(function() {
               console.log("hi");
               var replyUL = $(this).parents("#enroll");
               var rrno = $(this).parents("#enroll").data("rrno");
               var replyer = $(this).parents("#enroll").data("replyer");

               
               
               replyService.get(rrno,function(reply){
                  console.log(reply);
                  
                  str = "";
                   str += '<div id="mod" class="">' +
                   reply.replyer + '</div><div class="card-body"><ul class="list-group list-group-flush"><li class="list-group-item">';
                  str += '<form id="boardReplyFrm_176"><textarea class="form-control mt-2" id="modContent" name="reply" rows="3">' 
                     +reply.reply+'</textarea></form><button type="button" class="btn btn-dark" id="modRegBtn">수정</button></li></ul></div>';
                  replyUL.html(str); 
                  
                  
                  $("#modRegBtn").on("click", function(e) {
                     var reply = {
                     rrno : rrno,
                     reply : $("#modContent").val(),
                     replyer : replyer
                     };
                     replyService.update(reply, function(result) {
                     alert(result);
                     
                     showList(-1);
                     });
                  });
                   
               });
            });
            //수정 끝
            
            
            
            
            
            showReplyPage(replyTotalCnt);

               
         });
      }
   
   showList(-1);
   
   var pageNum = 1;
   var replyPageFooter = $(".panel-footer");// 덧글 목록의 footer

   function showReplyPage(replyCnt) {
      var endNum = Math.ceil(pageNum / 10.0) * 10;
      // pageNum : 1 이라고 가정하면,
      // Math.ceil(1/10.0) 처리하고 *10, 즉 endNum : 10
      var startNum = endNum - 9;// - 나올지도..
      var prev = startNum != 1;// false = (1 !=1)
      var next = false;
      // replyCnt : 384, endNum : 39
      if (endNum * 10 >= replyCnt) {// 100 >= 384
         endNum = Math.ceil(replyCnt / 10.0);
      }
      if (endNum * 10 < replyCnt) {
         next = true;
      }
      var str = "<ul class='pagination";
      str+=" justify-content-center'>";
      if (prev) {
         str += "<li class='page-item'><a ";
         str += "class='page-link' href='";
         str += (startNum - 1);
         str += "'>이전</a></li>";
      }
      for (var i = startNum; i <= endNum; i++) {
         var active = pageNum == i ? "active" : "";
         str += "<li class='page-item "+ active
         +"'><a class='page-link' ";
         str+="href='"+i+"'>"
         + i + "</a></li>";
      }
      if (next) {
         str += "<li class='page-item'>";
         str += "<a class='page-link' href='";
         str += (endNum + 1) + "'>다음</a></li>";
      }
      str += "</ul>";
      console.log(str);
      replyPageFooter.html(str);
   }
   /* 덧글 페이징 끝 */
   
   replyPageFooter.on("click", "li a", function(e) {
      e.preventDefault();
      var targetPageNum = $(this).attr("href");
      pageNum = targetPageNum;
      showList(pageNum);
      });
   
   
   var modal = $("#myModal");

   $(".replyList").on("click", ".infoBtn", function(e) {
      $(".my-rating-2").starRating({
         initialRating: 1,
         totalStars: 5,
         starShape: 'rounded',
         ratedColors: ['orange', 'orange', 'orange', 'orange', '#CCCCCC'],

          starSize: 25,
          readOnly: true,

      });
      $(".my-rating-2").starRating('setRating', 5, true);

      $(".my-rating-2").starRating({

         ratedColors: ['orange', 'orange', 'orange', 'orange', 'orange'],


      });
      //클래스 chat 을 클릭하는데, 하위 요소가 li라면,
      console.log($(this).data("sitter"));
      var sitterVal = $(this).data("sitter");
      console.log(sitterVal);
      // 덧글에 포함된 값들 중에서 rno를 추출하여 변수 할당.


      sitterService.get(sitterVal,function(sitterReview) {
         $("#myModal").find("#sitter").text(sitterVal);
         console.log(sitterReview.totalAvg);
         $(".my-rating-2").starRating('setRating', sitterReview.totalAvg);
         $("#myModal").find("#cnt").text(sitterReview.count);   

         
      });
      $("#modalMatchingBtn").on("click", function(e){
         e.preventDefault();
         $("#matchingSitter").val(sitterVal);
         // $("#myModal").find("#matchingForm").append("<input type='hidden' name='sitter' value='"+sitterVal+"'>");
         $("#matchingForm").submit();
      });
      
      
      var reviewList = $(".reviewList");
      sitterService.getList(sitterVal,
         function(list) {
            
            var str = "";
            if (list == null || list.length == 0) {
               $("#reviewSize").css("height","0px");
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

         
      
      
      $("#myModal").modal("show");
      
      var matchingForm = $("#matchingForm");

   }); // 끝_덧글 읽기.
   $("#modalCloseBtn").on("click", function(e){
      modal.modal("hide");
   });
   
   $(".replyList").on("click", ".matchingBtn", function(e) {
      console.log($(this).data("sitter"));
      var sitterVal = $(this).data("sitter");
      
      $("#matchingSitter").val(sitterVal);
      $("#matchingForm").submit();
      
   });
   
   

   
});
</script>


<%@ include file="../includes/footer.jsp"%>