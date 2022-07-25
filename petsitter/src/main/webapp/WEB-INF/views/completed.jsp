<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@ include file="includes/header.jsp"%>

<link rel="stylesheet" href="/resources/css/mypage.css">


<div class="section-form">
	<div class="left-section">
		<div class="left-menu" type="button"
			onclick="location.href='/mypage';">
			<!-- OnClick="location.href ='http://주소'" -->
			Mypage
		</div>
		<div class="left-menu change-page" type="button" id="completed">완료된
			요청</div>
		<div class="left-menu" type="button" id="managed">완료된 매니저 요청</div>
		<div class="left-menu" type="button" id="mypoint">돌봄페이 충전</div>
	</div>


	<div class="right-section">
		<div class="container">
			<section id="container">
				<form role="form" method="get">
					<table class="table table-hover">
						<thead>
							<tr>
								<th>요청일</th>
								<th>펫</th>
								<th>요청자</th>
								<th>자세히 보기</th>
							</tr>
						</thead>

						<!-- 목록 시작 -->
						<c:forEach items="${completed}" var="completed">
							<tr>
								<td><fmt:formatDate pattern="yyyy-MM-dd"
										value="${completed.regdate }" /></td>
								<td>${completed.pet}</td>
								<td>${completed.sitter}</td>
								<td><button type="button" class="detailBtn"
										data-pet="${completed.pet }"
										data-content="${completed.content }"
										data-payment="${completed.payment }"
										data-img="${completed.img }"
										data-writer="${completed.writer }">보기</button></td>
							</tr>
						</c:forEach>
					</table>
				</form>
			</section>
		</div>
	</div>
</div>
<!-- 목록 끝 -->

<!-- 완료된 게시물 자세히 보기 모달 -->

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
					<div class="col-md-3" style="margin-left: 0px!important;">
						<img id="petImg" class="card-img-top mb-5 mb-md-0" alt="...">
					</div>
					<div class="col-md-9" style="margin-left: 0px!important;">
						<div class="fs-5 mb-3">
							아이디: <span id="requester"></span>
						</div>
						<div class="mb-3">
						펫 종류 : <span class="mb-3" id="petType"></span>
						</div>
						<div class="mb-3">
						돌봄 페이 : <span id="payment"></span>
						</div>
						<div class="text-muted">
							<div id="address" class="content-info"></div>
							<div id="DateTime" class="content-info"></div>
							<div id="DateTime2" class="content-info">
								<div id="Date"></div>
								<div id="Time"></div>
							</div>
						</div>
					</div>
					
					<div class="col-md-12 mt-3" id="content" style="margin-left: 0px!important;"></div>


				</div>
			</div>
			<div class="modal-footer">
				<button id="requestCloseBtn" type="button" class="btn btndefault">닫기</button>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript" src="/resources/js/sitreply.js"></script>

<script>
	$(document).ready(function() {

		$(".detailBtn").on("click", function(e) {
			var pet = $(this).data("pet");
			var payment = $(this).data("payment");
			var img = $(this).data("img");
			var content = $(this).data("content");
			var writer = $(this).data("writer");

			$("#requestModal").find("#petImg").attr("src", img);
			$("#requestModal").find("#requester").text(writer);
			$("#requestModal").find("#content").text(content);
			$("#requestModal").find("#petType").text(pet);
			$("#requestModal").find("#payment").text(payment);

			$("#requestModal").modal("show");
		});

		$("#requestCloseBtn").on("click", function(e) {
			$("#requestModal").modal("hide");
		});
	});
</script>
<script>
	$("#mypoint").on("click", function() {
		self.location = "/charge/myPoint"
	});
	$("#completed").on("click", function() {
		self.location = "/completed"
	});
	$("#managed").on("click", function() {
		self.location = "/managed"
	});
</script>

<%@ include file="includes/footer.jsp"%>
