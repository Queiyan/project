<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>


<%@ include file="../includes/header.jsp"%>


<link rel="stylesheet" href="/resources/css/requestlist.css">

<!-- 검색창 시작 -->
         <div>
            <div class="col-lg-12" >
               <form id="searchForm" action="/request/list" method="get">
                  <!-- 선택 상자에서 선택된 모습(selected)을 표시하기 위해 삼항연산자 이용. 
               el 표기중에서 eq 는 == 과 같은 의미
               -->
                  &nbsp;&nbsp;&nbsp;<select name="type" class="type-form">
                     <option value="TCWPL" ${pageMaker.cri.type eq "T||C||W||P||L" ?"selected":"" }>
				전체
				</option>
                     <option value="T" ${pageMaker.cri.type eq "T"?"selected":"" }>
                        제목</option>
                     <option value="C" ${pageMaker.cri.type eq "C"?"selected":"" }>
                        내용</option>
                     <option value="W" ${pageMaker.cri.type eq "W"?"selected":"" }>
                        작성자</option>
                     <option value="P" ${pageMaker.cri.type eq "P"?"selected":"" }>
           	동물</option>
                  </select> 
                  <input type="text" class="keyword-form" name="keyword" value="${pageMaker.cri.keyword }" /> 
                  <input type="hidden"name="pageNum" value="${pageMaker.cri.pageNum }"> 
                  <input type="hidden" name="amount" value="${pageMaker.cri.amount }">
                  <button class="btn btn-warning" id="searchBtn">검색</button>
                  
               </form>
            </div>
         </div>
<!-- 검색창 끝 -->
<div class="card-body py-3" align="right">
	<button id="regBtn">글작성</button>
</div>

<!-- 이용자요청목록 -->
<div class="row">
	<c:forEach var="request" items="${list }">
		<div class="col-lg-3">
			<div class="card" id="card-content" style="width: 14rem; height:22em;">
				<a href="${request.rbno }"class="move"> 
				<img class="card-img-top" alt="..." src="${request.thumImg }" 
				 onerror="this.src='/resources/images/logo-white.png'"
				style="height:180px; width:100%;"></a>

				
				<div class="card-body">
					<div class="card-title">
						<a href="${request.rbno }"class="move">
						<c:out value="${request.title }" />
						</a>
					</div>
					<div class="card-text">펫 종류: ${request.pet}</div>
					<div class="card-text">
						지역: <c:out value="${request.address }" />
					</div>
					<!-- 날짜와시간 값이 있으면 -->
					<c:if test="${not empty request.startDateTime}">
						<div class="TextType-dateTime">
							
							<p class="card-text">
								기간 : <fmt:formatDate value="${request.startDateTime }" pattern="MM월 dd일 HH:mm"/>
							</p>
							<p class="card-text">
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ~ <fmt:formatDate value="${request.endDateTime }" pattern="MM월 dd일 HH:mm"/>
							</p>
						</div>
					</c:if>
					<!-- 날짜와시간 값이 없으면 -->
					<c:if test="${empty request.startDateTime}">
						<div class="TextType-datePartTime">
							<div class="card-text">
								기간 : <fmt:formatDate value="${request.startDate }" pattern="MM월 dd일"/>
								~
								<fmt:formatDate value="${request.endDate }" pattern="MM월 dd일"/>
							</div>
							<div class="card-text">
								파트타임
								<fmt:formatDate value="${request.startTime }" pattern="HH:mm"/> ~
								<fmt:formatDate value="${request.endTime }" pattern="HH:mm"/>
							</div>
						</div>
					</c:if>
					
					<div class="card-text">
					돌봄 페이: <c:out value="${request.payment }" />원
					</div>
					
					<c:if test="${request.replyCnt ne 0 }">
					<span style="color:black;">[<c:out value="${request.replyCnt }"/>]
					</span> </c:if>
					
					
				</div>
			</div>
		</div>
	</c:forEach>
</div>

<!-- 쪽번호 시작 -->
<div>
	<ul class="pagination justify-content-center">
		<c:if test="${pageMaker.prev}">
			<li class="page-item previous"><a
				href="${pageMaker.startPage-1 }" class="page-link"> Prev</a></li>
		</c:if>
		<c:forEach var="num" begin="${pageMaker.startPage }"
			end="${pageMaker.endPage }">

			<li class='page-item ${pageMaker.cri.pageNum==num?"active":"" }'>
				<a href="${num }" class="page-link">${num }</a>
			</li>
		</c:forEach>
		<c:if test="${pageMaker.next }">
			<li class="page-item next"><a href="${pageMaker.endPage+1 }"
				class="page-link"> Next</a></li>
		</c:if>
	</ul>
</div>
<!-- 쪽번호 끝 -->



<form id="actionForm" action="/request/list" method="get">
	<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
	<input type="hidden" name="amount" value="${pageMaker.cri.amount }">
	<input type="hidden" name="type" value="${pageMaker.cri.type }">
	<input type="hidden" name="keyword" value="${pageMaker.cri.keyword }">
</form>

<script>
	$(document).ready(function() {
		var actionForm = $("#actionForm");
		
		// 클래스 page-item 에 a 링크가 클릭 된다면,
		$(".page-item a").on(
		"click",
		function(e) {
		e.preventDefault();
		// 기본 이벤트 동작을 막고,
		console.log("click");
		// 웹 브라우저 검사 창에 클릭을 표시
		actionForm.find("input[name='pageNum']").val(
		$(this).attr("href"));
		// 액션폼 인풋태그에 페이지넘 값을 찾아서,
		// href로 받은 값으로 대체함.
		actionForm.submit();
		});
		
		
		
		$(".move").on("click", function(e) {
			e.preventDefault();
			/* 뒤로가기 버튼 클릭시 bno 2개 생성되는 문제 해결 */
            var rbno=actionForm.find("input[name='rbno']").val();
            if(rbno!=''){
               actionForm.find("input[name='rbno']").remove();
            } 
			actionForm.append("<input type='hidden' name='rbno' "
			+"value='"+$(this).attr("href")+"'>");
			actionForm.attr("action","/request/get");
			actionForm.submit();
			});
		
		$('#searchBtn').on("click", function(e) {
			e.preventDefault();
			var searchForm = $("#searchForm");
			
			/* $("#searchForm button").on("click", function(e) {
				if(!searchForm.find("option:selected").val()){
				alert("검색 종류를 선택하세요.");
				return false;
				}
				if(!searchForm.find("input[name='keyword']").val()){
				alert("키워드를 입력하세요.");
				return false;
				}
				searchForm.find("input[name='pageNum']").val(1);
				e.preventDefault();
				searchForm.submit();
				}); */
			
			var searchKeyword = $(
			"input[name='keyword']")
			.val();
			var sKey = '<c:out value="${pageMaker.cri.keyword }"/>';
			console.log("이전 검색어: " + sKey);
			console.log("현재 검색어: "
			+ searchKeyword);
			if
			(sKey != searchKeyword) {
			searchForm
			.find(
			"input[name='pageNum']")
			.val(1);
			}
			searchForm.submit();
			});
			
		  /* var address ='${request.address}';
	      console.log(address);

	      var addrSplit = address.split(" ");
	      var sido = addrSplit[0];
	      var gugun = addrSplit[1];
	      var newAddress = sido + ' ' + gugun;
	      console.log(newAddress);
	      document.getElementById("address").innerHTML=newAddress; */
	      
	     /*  $(".move").on("click", function(e) {
	         e.preventDefault();
	         actionForm.append("<input type='hidden' name='rbno' "
	         +"value='"+$(this).attr("href")+"'>");
	         actionForm.attr("action","/request/get");
	         actionForm.submit();
	         }); */

		$("#regBtn").on("click", function(){
			self.location = "/request/register"
		});   		
	});
</script>

<%@ include file="../includes/footer.jsp"%>



