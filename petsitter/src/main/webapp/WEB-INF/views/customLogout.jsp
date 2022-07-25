<%-- <%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="includes/header.jsp"%>
<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<h1>로그아웃 처리</h1>
			<h2>${error}</h2>
			<h2>${logout }</h2>
			<div class="panel-body">
				<form id="logoutForm" role="form" method="post" action="/customLogout">
					<fieldset>
						<!-- 관련 요소를 묶는 역할, -->
						<a href="index.html" class="btn btn-lg btn-success btn-block">
							로그아웃 </a>
					</fieldset>
					<input type="hidden" name="${_csrf.parameterName }"
						value="${_csrf.token}" />
				</form>
				<!-- 겟 방식으로 로그아웃 페이지에 접근하고,
				로그아웃 버튼을 누르면 포스트 방식으로 처리  -->
			</div>
		</div>
	</div>
</div>

<script>
	$(".btn-success").on("click", function(e) {
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


<%@ include file="includes/footer.jsp"%>




 --%>