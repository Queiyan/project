<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>


<%@ include file="../includes/header.jsp"%>
<script src="/resources/js/jquery.star-rating-svg.js"></script>
<link rel="stylesheet" type="text/css" href="/resources/css/star-rating-svg.css">
<link rel="stylesheet" href="/resources/css/requester.css">
<style>
.section {
   width: 49%;
   float: left;
}

.section2 {
   width: 49%;
   float: left;
}

</style>

      
<div class="section col-md-5">
<h5 style="text-align:center;">돌봄요청게시글</h5>
<sec:authentication property="principal" var="pinfo"/>
   
      <sec:authorize access="isAuthenticated()">
      <c:forEach var="request" items="${list }">
         <c:if test="${pinfo.username eq request.writer }">
         <c:forEach var="member" items="${member }">
         <c:if test="${request.sitter eq member.userid }">
      <div class="card mb-3" data-rbno="${request.rbno }">
         <div class="row g-0 card-info" >
               <div class="col-md-5" >
               <img src="${request.img }" class="img-fluid rounded-start getRequest" alt="..." id="requester-right" data-rbno="${request.rbno }"
               onerror="this.src='/resources/images/logo-white.png'" style="width:100%; height: 100%;">
               </div>
               <div class="col-md-1"> </div>
               
               <div class="col-md-5">
                  <div class="card-body getRequest" data-rbno="${request.rbno }">
                  
                     <h6>
                        돌봄 매니저 : <c:out value="${request.sitter }" />
                     </h6>
                     <br>   
                     <p class="card-text"> 연락처 : ${member.phone}</p>
                     <p class="card-text"> 펫 종류 : ${request.pet}</p>
                     <p class="card-text"> 돌봄 페이 : ${request.payment}</p>

                     
<%-- 
                     <div id="address" class="card-text">주소 : ${request.address }</div>
      
                        <small class="text-muted">
                        
                        
                        <c:if test="${not empty request.startDateTime}">
                     <div class="TextType-dateTime">
                        <div class="card-text">
                           <fmt:formatDate value="${request.startDateTime }" pattern="yyyy-MM-dd HH:mm"/>
                        </div>
                        <div class="card-text">
                           ~ <fmt:formatDate value="${request.endDateTime }" pattern="yyyy-MM-dd HH:mm"/>
                        </div>
                     </div>
                  </c:if>
                  <!-- 날짜와시간 값이 없으면 -->
                  <c:if test="${empty request.startDateTime}">
                     <div class="TextType-datePartTime">
                        <div class="card-text">
                           <fmt:formatDate value="${request.startDate }" pattern="yyyy-MM-dd"/> ~ <fmt:formatDate value="${request.endDate }" pattern="yyyy-MM-dd"/>
                           
                        </div>
                        
                        <div class="card-text">
                           파트타임
                           <fmt:formatDate value="${request.startTime }" pattern="HH:mm"/> ~
                           <fmt:formatDate value="${request.endTime }" pattern="HH:mm"/>
                        </div>
                     </div>
                  </c:if>
                     </small> --%>
               
                  </div>
               <button class="move btn btn-primary" id="manager-info-left" data-sitter="${request.sitter }">매니저정보</button>
               <button class="reviewMove btn btn-primary" id="compleat-left" data-payment="${request.payment }" data-rbno="${request.rbno }" data-sitter="${request.sitter }"  data-requester="${request.writer }" >완료</button>
               
               </div>
               
         </div>
      </div>
      </c:if>
      </c:forEach>
      </c:if>
      </c:forEach>
      </sec:authorize>
</div>

<div class="section0 col-md-2"></div>

<div class="section2 col-md-5">
<h5 style="text-align:center;">매니저소개게시글</h5>

<sec:authentication property="principal" var="pinfo"/>
   
      <sec:authorize access="isAuthenticated()">
         <c:forEach var="reply" items="${replyList }">
         <c:if test="${pinfo.username eq reply.replyer }">
         <c:forEach var="member" items="${member }">
         <c:if test="${reply.sitter eq member.userid }">
         
         
      <div class="card mb-3">
         <div class="row g-0 card-info" >
               <div class="col-md-5" >
               <img src="${reply.img }" class="img-fluid rounded-start getReply" alt="..." id="requester-left"  data-rsbno="${reply.rsbno }"
               onerror="this.src='/resources/images/logo-white.png'">
               </div>
               <div class="col-md-1"></div>
               <div class="col-md-6">
                  <div class="card-body getReply"  data-rsbno="${reply.rsbno }" >
                  
                     <h6>
                        돌봄 매니저 : <c:out value="${reply.sitter }" />
                     </h6>

                     <br>   
                     <p class="card-text">연락처 : ${member.phone}</p>
                     <p class="card-text">펫 종류 : ${reply.petType}</p>
                     <p class="card-text">돌봄 페이 : ${reply.payment}</p>
                     

                     <%-- <div id="address" class="card-text">${reply.address }</div>
      
                        <small class="text-muted">
                        
                        
                        <c:if test="${not empty reply.startDateTime}">
                     <div class="TextType-dateTime">
                        <div class="card-text">
                           <fmt:formatDate value="${reply.startDateTime }" pattern="yyyy-MM-dd HH:mm"/>
                        </div>
                        <div class="card-text">
                           ~ <fmt:formatDate value="${reply.endDateTime }" pattern="yyyy-MM-dd HH:mm"/>
                        </div>
                     </div>
                  </c:if>
                  <!-- 날짜와시간 값이 없으면 -->
                  <c:if test="${empty reply.startDateTime}">
                     <div class="TextType-datePartTime">
                        <div class="card-text">
                           <fmt:formatDate value="${reply.startDate }" pattern="yyyy-MM-dd"/> ~ <fmt:formatDate value="${reply.endDate }" pattern="yyyy-MM-dd"/>
                           
                        </div>
                        
                        <div class="card-text">
                           파트타임
                           <fmt:formatDate value="${reply.startTime }" pattern="HH:mm"/> ~
                           <fmt:formatDate value="${reply.endTime }" pattern="HH:mm"/>
                        </div>
                     </div>
                  </c:if>
                     </small> --%>
               
                  </div>
                  <button class="move btn btn-primary" id="manager-info-right" data-sitter="${reply.sitter }">매니저정보</button>
               <button class="reviewMove btn btn-primary" id="compleat-right" data-payment="${reply.payment }" data-rsbno="${reply.rsbno }" data-sitter="${reply.sitter }"  data-requester="${reply.replyer }" >완료</button>
               
               </div>
               
         </div>
      </div>
      </c:if>
      </c:forEach>
      </c:if>
      </c:forEach>


      </sec:authorize>
</div>



<div class="modal fade" id="exampleModalToggle" aria-hidden="true" aria-labelledby="exampleModalToggleLabel" tabindex="-1">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header text-center">
        <h5 class="modal-title" id="exampleModalToggleLabel">리뷰 작성</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
           리뷰를 작성 하시겠습니까?
      </div>
      <div class="modal-footer">
        <button class="reviewBtn btn btn-primary">리뷰 작성</button>
        <button class="regbtn btn btn-primary" data-bs-dismiss="modal" aria-label="Close">완료</button>
        
      </div>
    </div>
  </div>
</div>
<div class="modal fade" id="exampleModalToggle2" aria-hidden="true" aria-labelledby="exampleModalToggleLabel2" tabindex="-1">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header text-center">
        <h5 class="modal-title" id="exampleModalToggleLabel2">리뷰 작성</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <div class="my-rating"></div>
        <textarea class="form-control" id="reviewText"
         rows="3" placeholder="리뷰를 작성해주세요." name='content'></textarea>
        
        
      </div>
      <div class="modal-footer">
        <button class="regBtn btn btn-primary">등록하기</button>
      </div>
    </div>
  </div>
</div>




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
         
             &nbsp;&nbsp;&nbsp;돌봄매니저 : <div class="col-10 fw-bold" id="sitter"></div>
            &nbsp;&nbsp;&nbsp;돌봄 횟수 : <div class="col-10" id="cnt"></div>
             &nbsp;&nbsp;&nbsp;별 점 : <div class="my-rating-2 col-10"></div>
             
             

          
         </div>
         <br>
         <div  id="reviewSize" class="form-group" style="height: 300px; overflow: auto;">
          
          <ol class="reviewList list-group list-group-numbered">
           
          
         </ol>
      </div>
   
      </div>

      <!--Footer-->
      <div class="modal-footer justify-content-center">
        <a type="button" id="modalCloseBtn" class="btn btn-outline-info waves-effect" data-dismiss="modal">닫기</a>
      </div>
    </div>
    <!--/.Content-->
  </div>
</div>



<!-- 요청 자세히 보기 모달 -->
<div class="modal fade" id="requestModal" tabindex="-1" role="dialog"
   aria-labelledby="exampleModalLabel" aria-hidden="true">
   <div class="modal-dialog modal-lg">
      <div class="modal-content">
         <div class="modal-header">
            <h4 class="modal-title" id="requestModalLabel">요청사항 보기</h4>
         </div>
               <div class="modal-body">
                    <div class="row gx-4 gx-lg-5 align-items-center">

                  <div class="col-md-4">
         <img id="petImg" class="card-img-top mb-5 mb-md-0" alt="..." 
         onerror="this.src='/resources/images/logo-white.png'" style="width:100%; height: 100%;">
      </div>
      
      <div class="col-md-8">
         <div class="fs-5 mb-3">
            요청자 : <span id="requester"></span>
         </div>
           <div class="mb-3">
         펫 종류 : <span id="petType"></span>
         </div>
         <small class="text-muted">
         <div class="mb-3">
         주소 : <span  id="address"></span>
         <div class="mb-3">
         돌봄 기간 : <span id="DateTime"></span>
         <span id="DateTime2">
         <span id="Date"></span>
         <span id="Time"></span>
         </span>
         </small>
   </div>
   

               </div>
            </div>
   <div class="col-md-12">
      <div class="text-content" id="content">      
      </div>      
   </div>
   
   
   
            <div class="modal-footer">
                  <button id="requestCloseBtn" type="button" class="btn btndefault">닫기</button>
              </div>
         </div>        
      </div>
</div>
   


<form id="completed" action="/request/completed" method="post">
<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token}" /> 
<input type="hidden" id="completedRbno" name="rbno" value="">
</form>
<form id="sitcompleted" action="/sitreplies/completed" method="post">
<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token}" /> 
<input type="hidden" id="completedRsbno" name="rsbno" value="">
</form>
         

<!-- 매칭 모달 끝 -->
<script type="text/javascript" src="/resources/js/sitterInfo.js"></script>
<script type="text/javascript" src="/resources/js/sitreply.js"></script>

<script>

   $(".my-rating").starRating({
        totalStars: 5,
        starShape: 'rounded',
        starSize: 40,
        emptyColor: 'lightgray',
        hoverColor: 'orange',
        ratedColors: ['orange', 'orange', 'orange', 'orange', 'orange'],
        useGradient: false,
        callback: function(currentRating, $el){
              // make a server call here
          }
      });

   

</script>
<script>
   
   $(document).ready(function() {
      
      
      var csrfHeaderName="${_csrf.headerName}";
      var csrfTokenValue="${_csrf.token}";
      
      $(document).ajaxSend(function(e,xhr,options){
         xhr.setRequestHeader(csrfHeaderName,csrfTokenValue);
      });
      
      
      

      var modal = $("#sitterModal");

      $(".move").on("click", function(e) {

         var sitterVal = $(this).data("sitter");
         
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

         
         sitterService.get(sitterVal,function(sitterReview) {
            $("#sitterModal").find("#sitter").text(sitterVal);
            $(".my-rating-2").starRating('setRating', sitterReview.totalAvg);
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
         
      }); // 끝_덧글 읽기.
      
/*       $(".move").on("click", ".my-rating-3",function(e) {
         var rating = $(this).data("rating");
         console.log(rating);
         
         $(".my-rating-3").starRating('setRating', rating, true);
      }); */
      $("#modalCloseBtn").on("click", function(e){
         modal.modal("hide");
      });
      
      
      
      
      $(".reviewMove").on("click", function(e) {
         $("#exampleModalToggle").modal("show");

         var sitterVal = $(this).data("sitter");
         var requesterVal = $(this).data("requester");
         var rbnoVal = $(this).data("rbno");
         var rsbnoVal = $(this).data("rsbno");
         var paymentVal = $(this).data("payment");



         $(".reviewBtn").on("click", function(e) {
            $("#exampleModalToggle").modal("hide");
            $("#exampleModalToggle2").modal("show");


         });   
         
         var rating;
         $(".my-rating").click(function(){
            rating = $(this).starRating('getRating');
            console.log(rating);
            });
         $(".regBtn").on("click", function(e) {
            
            var sitterInfo = {
               sitter : sitterVal,
               requester : requesterVal,
               review : $("#reviewText").val(),
               average : rating
            };
            sitterService.add(sitterInfo, function(result) {
               alert(result);
            });
            $.ajax({
                    type: "get",
                    url: "/charge/completed/point", 
                    data: {
                        "amount" : paymentVal,
                        "userid" : sitterVal
                    },

                });
            
            if(typeof rbnoVal == "undefined" || rbnoVal == "" || rbnoVal == null){
               $.ajax({
                       type: "post",
                       url: "/sitreplies/completed", 
                       data: {rsbno : rsbnoVal},
                       success : function() {
                               location.reload();
                         }

                   });
               
            
            }else{
               $("#completedRbno").val(rbnoVal);
               $("#completed").submit();
            }
            
            
            
            
            $("#exampleModalToggle2").modal("hide");


         });
      });
      
      
      
      
      
      $(".getRequest").on("click", function(e) {
         var rbno = $(this).data("rbno");
         var type1 = $("#DateType1");
         var type2 = $("#DateType2");
         console.log(rbno);
         $.get("/request/get/" + rbno, function(data) {
            $("#requestModal").find("#petImg").attr("src", data.img);

            $("#requestModal").find("#requester").text(data.writer);
            $("#requestModal").find("#content").text(data.content);
            $("#requestModal").find("#petType").text(data.pet);
            var address = data.address + '' + data.detailAddress + data.extraAddress;
            $("#requestModal").find("#address").text(address);
            
            if(data.startDate==null&&data.startDateTime!=null){
               
               var dateTime = replyService.displayDateTime(data.startDateTime) + ' ~ ' + replyService.displayDateTime(data.endDateTime);
               $("#requestModal").find("#DateTime").text(dateTime);

               document.getElementById('DateTime').style.display="";
               document.getElementById('DateTime2').style.display="none";
            }else if(data.startDate!=null&&data.startDateTime==null){
               
               var date = replyService.displayDate(data.startDate) + ' ~ ' + replyService.displayDate(data.endDate);
               $("#requestModal").find("#Date").text(date);
               
               var time = replyService.displayTime(data.startTime) + ' ~ ' + replyService.displayTime(data.endTime);
               $("#requestModal").find("#Time").text(time);
               
               
               document.getElementById('DateTime').style.display="none";
               document.getElementById('DateTime2').style.display="";
               }
            });
         $("#requestModal").modal("show");
      });


      $(".getReply").on("click", function(e) {
         var rsbno = $(this).data("rsbno");
            replyService.get(rsbno, function(reply){
            $("#requestModal").find("#petImg").attr("src", reply.img);
            console.log(reply.img);

               
              $("#requestModal").find("#requester").text(reply.replyer);
            $("#requestModal").find("#content").text(reply.reply);
            $("#requestModal").find("#petType").text(reply.petType);   

            var address = reply.address + '' + reply.detailAddress + reply.extraAddress;
            $("#requestModal").find("#address").text(address);
            
            if(reply.startDate==null&&reply.startDateTime!=null){
               
               var dateTime = replyService.displayDateTime(reply.startDateTime) + ' ~ ' + replyService.displayDateTime(reply.endDateTime);
               $("#requestModal").find("#DateTime").text(dateTime);

               document.getElementById('DateTime').style.display="";
               document.getElementById('DateTime2').style.display="none";
            }else if(reply.startDate!=null&&reply.startDateTime==null){
               
               var date = replyService.displayDate(reply.startDate) + ' ~ ' + replyService.displayDate(reply.endDate);
               $("#requestModal").find("#Date").text(date);
               
               var time = replyService.displayTime(reply.startTime) + ' ~ ' + replyService.displayTime(reply.endTime);
               $("#requestModal").find("#Time").text(time);
               
               
               document.getElementById('DateTime').style.display="none";
               document.getElementById('DateTime2').style.display="";
               }
             });
             $("#requestModal").modal("show");
      });
      
      $("#modalCloseBtn").on("click", function(e){
         $("#requestModal").modal("hide");
      });

      $("#requestCloseBtn").on("click", function(e){
         $("#requestModal").modal("hide");
      });
      
   });
</script>

<%@ include file="../includes/footer.jsp"%>


