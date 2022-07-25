<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@ include file="../includes/header.jsp"%>

<link rel="stylesheet" href="/resources/css/mypage.css">


<h1>Admin</h1>



<div class="right-section">
   <div class="container">
      <section id="container">
            <table class="table table-hover">
               <thead>
                  <tr>
                     <th>아이디</th>
                     <th>이름</th>
                     <th>이메일</th>
                     <th>전화번호</th>
                     <th>성별</th>
                     <th>회원탈퇴</th>
                  </tr>
               </thead>
                <c:forEach items="${list}" var="list">
                
                  <tr>
                     
                     <td><c:out value="${list.userid}" /></td>
                     <td><c:out value="${list.userName}" /></td>
                     <td><c:out value="${list.email}" /></td>
                     <td><c:out value="${list.phone}" /></td>
                     <td><c:out value="${list.gender}" /></td>
                     <td>                
                     	<form role="form" method="post" action="/remove">
                     		<input type='hidden' name="userid" value="${list.userid}">
							<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token}" />
                     		<button type="submit" id="deleteBtn" class="detailBtn">회원탈퇴</button>
                     	</form>
                     </td>

                  </tr>
                  
                </c:forEach>

			</table>
		</section>
	</div>
</div>




<%@ include file="../includes/footer.jsp"%></html>