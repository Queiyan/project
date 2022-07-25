<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@ include file="../includes/header.jsp"%>

<link rel="stylesheet" href="/resources/css/list.css">
<link rel="stylesheet" href="/resources/css/requestlist.css">
<!-- 검색창 시작 -->
<div>
	<div class="col-lg-12">
		<form id="searchForm" action="/sitrequest/list" method="get">
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
				<option value="L" ${pageMaker.cri.type eq "L"?"selected":"" }>
					장소</option>
			</select> <input type="text" class="keyword-form" name="keyword"
				value="${pageMaker.cri.keyword }" /> <input type="hidden"
				name="pageNum" value="${pageMaker.cri.pageNum }"> <input
				type="hidden" name="amount" value="${pageMaker.cri.amount }">
			<button class="btn btn-warning" id="searchBtn">검색</button>

		</form>

	</div>
</div>
<!-- 검색창 끝 -->
<div class="card-body py-3" align="right">
	<button id="regBtn">글작성</button>
</div>




<div class="row">
	<c:forEach var="sitrequest" items="${list }">
		<div class="col-lg-3">
			<div class="card" id="card-content" style="width: 14rem; height:20em;">
				<a href="${sitrequest.sbno }"class="move"> 
				<img class="card-img-top" alt="..." src="${sitrequest.thumImg }" 
				 onerror="this.src='/resources/images/user.png'"
				style="height:180px; width:100%;"></a>

				
				<div class="card-body">
					<div class="card-title">
						<a href="${sitrequest.sbno }"class="move">
						<c:out value="${sitrequest.title }" />
						</a>
					</div>
					<div class="card-text">돌봄가능한 동물: ${sitrequest.pet}</div>
					<div class="card-text">
						지역: <c:out value="${sitrequest.address }" />
					</div>				
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



<form id="actionForm" action="/sitrequest/list" method="get">
	<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
	<input type="hidden" name="amount" value="${pageMaker.cri.amount }">
	<input type="hidden" name="type" value="${pageMaker.cri.type }">
	<input type="hidden" name="keyword" value="${pageMaker.cri.keyword }">
</form>


<script>
	$(document).ready(
			function() {
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

				$(".move").on(
						"click",
						function(e) {
							e.preventDefault();
							/* 뒤로가기 버튼 클릭시 bno 2개 생성되는 문제 해결 */
							var sbno = actionForm.find("input[name='sbno']")
									.val();
							if (sbno != '') {
								actionForm.find("input[name='sbno']").remove();
							}
							actionForm
									.append("<input type='hidden' name='sbno' "
											+ "value='" + $(this).attr("href")
											+ "'>");
							actionForm.attr("action", "/sitrequest/get");
							actionForm.submit();
						});

				$('#searchBtn').on("click", function(e) {
					e.preventDefault();
					var searchForm = $("#searchForm");

					var searchKeyword = $("input[name='keyword']").val();
					var sKey = '<c:out value="${pageMaker.cri.keyword }"/>';
					console.log("이전 검색어: " + sKey);
					console.log("현재 검색어: " + searchKeyword);
					if (sKey != searchKeyword) {
						searchForm.find("input[name='pageNum']").val(1);
					}
					searchForm.submit();
				});

				$("#regBtn").on("click", function() {
					self.location = "/sitrequest/register"
				});

			});
</script>


<%@ include file="../includes/footer.jsp"%>