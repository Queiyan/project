<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
   prefix="sec"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>행복하개 돌볼고양</title>

<link rel="stylesheet" href="/resources/css/style.css">
<link rel="stylesheet" href="/resources/css/header.css">
<link rel="stylesheet" href="/resources/css/list.css">
<link href="/resources/css/jquery.datetimepicker.css" rel="stylesheet">
<link href="/resources/css/mdtimepicker.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>



<script
   src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript" src="/resources/js/bootstrap.js"></script>
<link rel="stylesheet"
   href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

<link href="/resources/css/localselect.css" rel="stylesheet">
<link href="/resources/css/bootstrap.min.css" rel="stylesheet">


<div class="header-head">



   <sec:authorize access="isAnonymous()">
      <i class="fas fa-cogs fa-sm fa-fw mr-2 text-gray-400"></i>
   </sec:authorize>

   <sec:authorize access="isAnonymous()">
      <a href="/signup"><button type="button"
            class="btn-primary" id="signup">회원가입</button></a>
      <a href="/customLogin"><button type="button" class="btn-primary"
            id="loginBtn">로그인</button></a>
   </sec:authorize>

   <sec:authorize access="isAuthenticated()">

      <form id="logoutForm" role="form" method="post" action="/customLogout"
         style="margin: 0;">
         <fieldset>
            <div class="username-form">
               <div class="username-body">
                  <span class="username-content">환영합니다. </span> <span
                     class="username-content"> <sec:authentication
                        property="principal.username" />
                  </span> <span class="username-content">님</span>
               </div>
            </div>
            <a href="/charge/myPoint"><button type="button"
                  class="btn-primary" id="cashCharge">돌봄페이 충전</button></a> 
                  <a href="/admin/page"><button type="button" class="btn-primary" id="adminPage">관리자페이지</button></a> 
                  <a href="/mypage"><button type="button" class="btn-primary" id="mypageBtn">마이페이지</button></a> 
                  
                  <a href="/customLogout"
               class="btn-primary" id="logoutBtn">로그아웃 </a>
         </fieldset>
         <input type="hidden" name="${_csrf.parameterName }"
            value="${_csrf.token}" />
      </form>
   </sec:authorize>
</div>
<div class="header-title">
   <a href="/"><img src="/resources/images/logo.png"
      style="width: 300px;" /></a>
</div>
<div class="header-body">
   <header style="padding:0;"
      class="d-flex flex-wrap align-items-center justify-content-center justify-content-md-between py-3 mb-4 border-bottom">
      <!--       <a href="/" class="d-flex align-items-center col-md-3 mb-2 mb-md-0 text-dark text-decoration-none"> -->
      <!--         <svg class="bi me-2" width="40" height="32" role="img" aria-label="Bootstrap"><use xlink:href="#bootstrap"></use></svg> -->
      <!--       </a> -->

      <ul class="nav col-12 col-md-auto mb-2 justify-content-center mb-md-0">
         <li id="head-request" class="headers"><a href="/request/list"
            class="nav-link px-2 link-dark head-link" id="request">돌봄요청하기</a></li>
         <li id="head-sitrequest" class="headers"><a href="/sitrequest/list"
            class="nav-link px-2 link-dark head-link" id="sitrequest">돌봄매니저소개</a></li>
         <li id="head-matching" class="headers"><a href="/matching/requester"
            class="nav-link px-2 link-dark head-link" id="requester">요청자매칭정보</a></li>
         <li id="head-request" class="headers"><a href="/matching/sitter"
            class="nav-link px-2 link-dark head-link" id="sitter">매니저매칭정보</a></li>
         <li id="head-request" class="headers"><a href="/answer/list"
            class="nav-link px-2 link-dark head-link" id="FAQ">자주묻는질문</a></li>
      </ul>
   </header>
</div>
<script>
   $("#logoutBtn").on("click", function(e) {
      // 로그아웃 버튼을 클릭한다면,
      e.preventDefault();
      $("#logoutForm").submit();// csrf 값을 가지고 /customLogout 으로 post 접근 처리.
   });
</script>

<c:if test="${param.logout != null }">
   <script>
      $(document).ready(function() {
         alert("로그아웃");
      });
   </script>
   <!-- 로그아웃 파라미터 값이 있다면, 로그아웃 안내창 표시 -->
</c:if>
<script>
   $(document).ready(function() {

      
      var select = location.pathname;

      if (select.match("^/request")) {
         $("#request").css({
            "color" : "#2ac1bc"
         });
      } else {
         $("#request").css({
            "background-color" : "none"
         });
      }
      if (select.match("^/sitrequest")) {
         $("#sitrequest").css({
            "color" : "#2ac1bc"
         });
      } else {
         $("#sitrequest").css({
            "background-color" : "none"
         });
      }
      if (select.match("^/matching/requester")) {
         $("#requester").css({
            "color" : "#2ac1bc"
         });
      } else {
         $("#requester").css({
            "background-color" : "none"
         });
      }
      if (select.match("^/matching/sitter")) {
         $("#sitter").css({
            "color" : "#2ac1bc"
         });
      } else {
         $("#sitter").css({
            "background-color" : "none"
         });
      }
      if (select.match("^/answer")) {
         $("#FAQ").css({
            "color" : "#2ac1bc"
         });
      } else {
         $("#FAQ").css({
            "background-color" : "none"
         });
      }
      
      /* 관리자 페이지 접근 권한 시작 */
      <sec:authorize access="isAuthenticated()">
       var loginUser= '<sec:authentication property="principal.username"/>';    
      
       $.ajax({
           type: "get",
           url: "/get/auth", 
           data: {
               userid : loginUser
           },
           dataType : "text",

       }).done(function (data, textStatus, xhr) {
           if(data=="admin"){
              $("#adminPage").css("display","inline");
              $("#mypageBtn").css("display","none");

           } else {
              $("#adminPage").css("display","none");
              $("#mypageBtn").css("display","inline");

           }
       });
       </sec:authorize>
      /* 관리자 페이지 접근 권한 끝*/
      
      
      

      console.log(select);
   });
</script>

</head>
<body>
   <div style="width: 100%; padding-right: 10%; padding-left: 11%;">