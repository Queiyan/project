<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>


<%@ include file="../includes/header.jsp"%>
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
         <c:if test="${pinfo.username eq request.sitter }">
            <c:forEach var="member" items="${member }">
         <c:if test="${request.writer eq member.userid }">
      <div class="getRequest card mb-3" data-rbno="${request.rbno }">
         <div class="row g-0 card-info" >
               <div class="col-md-4" >
               <img src="${request.img }" class="img-fluid rounded-start" alt="/resources/img/none_img.jpg" 
               onerror="this.src='/resources/images/logo-white.png'" style="width:100%; height: 100%;">
               </div>
               <div class="col-md-8">
                  <div class="card-body" >
                  
                     <h6>
                        요청자 : <c:out value="${request.writer }" />
                     </h6>
                     <br>   
                     <p class="card-text"> 연락처 : ${member.phone}</p>
                     <p class="card-text"> 펫 종류 : ${request.pet}</p>
                     <p class="card-text"> 돌봄 페이 : ${request.payment}</p>
                     <p class="card-text"> 돌봄 주소 : ${request.address}</p>
         

      
                  </div>
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
         <c:if test="${pinfo.username eq reply.sitter }">
            <c:forEach var="member" items="${member }">
         <c:if test="${reply.replyer eq member.userid }">
         
         
      <div class="getReply card mb-3" data-rsbno="${reply.rsbno }" >
         <div class="row g-0 card-info" >
               <div class="col-md-4" >
               <img src="${reply.img }" class="img-fluid rounded-start" alt="/resources/img/none_img.jpg" 
               onerror="this.src='/resources/images/logo-white.png'" style="width:100%; height: 100%;">
               </div>
               <div class="col-md-8">
                  <div class="card-body" >
                  
                     <h6>
                        요청자 : <c:out value="${reply.replyer }" />
                     </h6>
                     <br>   
                     <p class="card-text"> 연락처 : ${member.phone}</p>
                     <p class="card-text"> 펫 종류 : ${reply.petType}</p>
                     <p class="card-text"> 돌봄 페이 : ${reply.payment}</p>
                     <p class="card-text"> 돌봄 주소 : ${reply.address}</p>
         


      

   
                  </div>
                  
               </div>
               
         </div>
      </div>
      </c:if>
      </c:forEach>
      </c:if>
      </c:forEach>

      </sec:authorize>
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
         <div id="DateTime"></div>
         <div id="DateTime2">
         <div id="Date"></div>
         <div id="Time"></div>
         </div>
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
   

<script type="text/javascript" src="/resources/js/sitterInfo.js"></script>
<script type="text/javascript" src="/resources/js/sitreply.js"></script>

<script>
   $(document).ready(function() {
      
      $(".getRequest").on("click", function(e) {
         var rbno = $(this).data("rbno");
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

      $("#requestCloseBtn").on("click", function(e){
         $("#requestModal").modal("hide");
      });
      
   });
</script>

<%@ include file="../includes/footer.jsp"%>


