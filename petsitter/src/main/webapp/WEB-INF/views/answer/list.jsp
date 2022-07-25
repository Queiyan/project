<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@ include file="../includes/header.jsp"%>

<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>FAQ 1</title>

<style>
/* FAQ */
ul {
   list-style: none;
   padding-left: 0px;
     
}
.a > ul > li {
    padding: 5px;
}
.faq {
   border-bottom: 0px solid #ddd;
   margin: 1em 0;
   margin-left: 20%;
    margin-right: 20%;
}
.FAQ-header {
    text-align: center;
    font-size: xxx-large;
}
.faq .faqHeader {
   position: relative;
   zoom: 1
}

.faq .faqHeader .showAll {
   position: absolute;
   bottom: 0;
   right: 0;
   border: 0;
   padding: 0;
   overflow: visible;
   background: none;
   cursor: pointer
}

.faq .faqBody {
   margin: 0;
   padding: 0
}

.faq .faqBody .article {
   list-style: none
}

.faq .q {
   margin:
}

.faq .q a {
   display: block;
   text-align: left;
   background: url("faq1_icon_q.png") no-repeat 0 0;
   padding: 0 0 0 35px;
   font-size: xx-large;
   color: #5e5e5e;
   font-weight: bold;
   cursor: pointer;
   margin: 10px 0;
   !
   important
}

.faq .q a:hover, .faq .q a:active, .faq .q a:focus {
   
}

.faq .a {
   background: #f8f8f8 url("faq1_icon_a.png") no-repeat 40px 10px;
   padding: 10px 75px 10px 75px;
   font-size: 16px;
   color: #444444;
   line-height: 22px;
   border-top: 1px solid #bdbdbd;
   margin: 5px 0 0 0;
}
</style>
<script type="text/javascript"
   src="https://code.jquery.com/jquery-latest.js"></script>

</head>

<body>
   <h1 class="FAQ-header">자주묻는 질문</h1>
   <div class="faq">
      <div class="faqHeader">
         <!--button type="button" class="showAll">답변 모두 여닫기</button-->
      </div>
      <ul class="faqBody">
         <li class="article" id="a1">
            <p class="q">
               <a href="#a1">행복하게 돌볼고양?</a>
            </p>
            <div class="a">
               <ul class="description-list___3AFQT">
                  <li><span class="dot___24M3O">*</span><span> 돌봄</span></li>
                  <li><span class="dot___24M3O">*</span><span> 산책</span></li>
                  <li><span class="dot___24M3O">*</span><span> 병원,미용,펫유치원 픽업</span></li>
                  <li><span class="dot___24M3O">*</span><span> 기타 요청사항 등등</span></li>
               </ul>
               <ul class="description-list___3AFQT">
                  <li><span class="dot___24M3O">*</span><span> 누구나 돌봄요청을 할 수 있고</span></li>
                  <li><span class="dot___24M3O">*</span><span> 누구나 돌봄 매니저가 될 수 있는</span></li>
                  <li><span class="dot___24M3O">*</span><span> 반려동물 돌봄 서비스</span></li>
                  <li><span class="dot___24M3O"></span><span> "행복하게 돌볼고양"입니다.</span></li>
               </ul>
            </div>
         </li>
         <li class="article" id="a2">
            <p class="q">
               <a href="#a2">돌봄요청하기란?</a>
            </p>
            <div class="a">
               <ul class="description-list___3AFQT">
                  <li><span class="dot___24M3O">*</span><span> 돌봄 요청을 원하는 요청자가 요청사항과 반려동물의 정보를 기입합니다.</span></li>
                  <li><span class="dot___24M3O">*</span><span> 글 작성 시 기입한 돌봄페이는 요청자가 보유한 돌봄페이에서 차감됩니다.</span></li>
                  <li><span class="dot___24M3O">*</span><span> 돌봄 페이가 부족한 경우 충전 후 글 작성해야 합니다.</span></li>
                  <li><span class="dot___24M3O">*</span><span> 돌봄을 원하는 매니저는 댓글을 작성합니다.</span></li>
                  <li><span class="dot___24M3O">*</span><span> 요청자는 돌봄 매니저의 정보(별점, 리뷰, 돌봄 횟수)를 볼 수 있습니다. </span></li>
                  <li><span class="dot___24M3O">*</span><span> 원하는 돌봄 매니저와 매칭 시 해당글은 사라지며, 요청자 매칭정보에서 확인 할 수 있습니다.</span></li>
                  
               </ul>
               
            </div>
         </li>
         <li class="article" id="a3">
            <p class="q">
               <a href="#a3">돌봄 매니저 소개란?</a>
            </p>
            <div class="a">
               <ul class="description-list___3AFQT">
                  <li><span class="dot___24M3O">*</span><span> 돌봄 매니저를 원하는 이용자가 본인을 소개하는 글을 작성합니다.</span></li>
                  <li><span class="dot___24M3O">*</span><span> 해당 글에서 돌봄 매니저의 정보(별점, 리뷰, 돌봄 횟수)를 볼 수 있습니다.</span></li>
                  <li><span class="dot___24M3O">*</span><span> 돌봄 요청을 원하는 사용자는 해당 글에 직접 요청사항과 반려동물의 정보를 기입하여 요청할 수 있습니다.</span></li>
                  <li><span class="dot___24M3O">*</span><span> 요청 댓글 작성 시 기입한 돌봄페이는 요청자가 보유한 돌봄페이에서 차감됩니다.</span></li>
               </ul>
               <ul class="description-list___3AFQT">
                  <li><span class="dot___24M3O">*</span><span> 매니저는 원하는 요청과 매칭할 수 있습니다.</span></li>
                  <li><span class="dot___24M3O">*</span><span> 매칭이 되어도 소개글은 사라지지않고 다른 요청과 매칭할 수 있습니다.</span></li>
                  
               </ul>
            </div>
         </li>
         <li class="article" id="a4">
            <p class="q">
               <a href="#a4">요청자매칭정보란?</a>
            </p>
            <div class="a">
               <ul class="description-list___3AFQT">
                  <li><span class="dot___24M3O">*</span><span> 이용자의 요청이 매칭되면 해당 정보를 볼 수 있습니다.</span></li>
                  <li><span class="dot___24M3O">*</span><span> 매칭 카드를 누르면 요청사항을 자세히 볼 수 있습니다.</span></li>
                  <li><span class="dot___24M3O">*</span><span> 매칭된 매니저의 정보를 볼 수 있습니다.</span></li>
                  <li><span class="dot___24M3O">*</span><span> 돌봄이 완료되면 리뷰 작성/돌봄 완료 처리를 할 수 있습니다. </span></li>
               </ul>
            </div>
         </li>
         <li class="article" id="a5">
            <p class="q">
               <a href="#a5">강아지와 고양이 동시에 돌봄 가능한가요?</a>
            </p>
            <div class="a">
               <ul class="description-list___3AFQT">
                  <li><span class="dot___24M3O">*</span><span> 원하는 돌봄매니저가 있을 시 가능합니다.</span></li>

               </ul>
            </div>
         </li>
   <!--       <li class="article" id="a6">
            <p class="q">
               <a href="#a6">강아지와 고양이 동시에 돌봄 가능한가요?</a>
            </p>
            <div class="a">
               <ul class="description-list___3AFQT">
                  <li><span class="dot___24M3O">*</span><span>원하는 돌봄매니저가 있을 시 가능합니다.</span></li>
               
               </ul>
            </div>
         </li> -->


      </ul>
   </div>

   <script>
      jQuery(function($) {
         // Frequently Asked Question
         var article = $('.faq>.faqBody>.article');
         article.addClass('hide');
         article.find('.a').hide();
         article.eq(0).removeClass('hide');
         article.eq(0).find('.a').show();
         $('.faq>.faqBody>.article>.q>a').click(function() {
            var myArticle = $(this).parents('.article:first');
            if (myArticle.hasClass('hide')) {
               article.addClass('hide').removeClass('show');
               article.find('.a').slideUp(100);
               myArticle.removeClass('hide').addClass('show');
               myArticle.find('.a').slideDown(100);
            } else {
               myArticle.removeClass('show').addClass('hide');
               myArticle.find('.a').slideUp(100);
            }
            return false;
         });
         $('.faq>.faqHeader>.showAll').click(function() {
            var hidden = $('.faq>.faqBody>.article.hide').length;
            if (hidden > 0) {
               article.removeClass('hide').addClass('show');
               article.find('.a').slideDown(100);
            } else {
               article.removeClass('show').addClass('hide');
               article.find('.a').slideUp(100);
            }
         });
      });
   </script>

   <%@ include file="../includes/footer.jsp"%>