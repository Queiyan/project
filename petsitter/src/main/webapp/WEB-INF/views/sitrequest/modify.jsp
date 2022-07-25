<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>


<%@ include file="../includes/header.jsp"%>

<link rel="stylesheet" href="/resources/css/modify.css">

<form role="form" action="/sitrequest/modify?${_csrf.parameterName}=${_csrf.token}" method="post"
   enctype="multipart/form-data">
   <div class="mb-3">

      <input type="hidden" name="sbno" value="${sitrequest.sbno}" /> 
      <input type="hidden" name="pageNum" value="${cri.pageNum }" /> 
      <input type="hidden" name="amount" value="${cri.amount }" />
      <input type="hidden" name="type" value="${cri.type }"> 
        <input type="hidden" name="keyword" value="${cri.keyword }">
      
      <label for="exampleFormControlInput1" class="form-label">제목 </label> 
      <input type="text" class="form-control" id="exampleFormControlInput1"
         name='title' value="<c:out value="${sitrequest.title }" />">
   </div>

   <div class="mb-3">
      <label for="exampleFormControlInput1" class="form-label">작성자 </label>
      <input type="text" class="form-control" id="exampleFormControlInput1"
         name='writer' value="<c:out value="${sitrequest.writer }" />">
   </div>

   <div class="mb-3">
      <label for="exampleFormControlTextarea1" class="form-label">
         내용</label>
      <textarea class="form-control" id="exampleFormControlTextarea1"
         rows="3" name='content'><c:out value="${sitrequest.content }" />
         </textarea>

      <div class="mb-3">
         <label for="exampleFormControlInput1" class="form-label">돌봄가능한 동물 </label> <input type="text" class="form-control"
            id="exampleFormControlInput1" name='pet'
            value="<c:out value="${sitrequest.pet }" />">
      </div>
   </div>

      <div class="local">
      <input type="button" onclick="Daum_Address()" value="주소 찾기" id="address-forget"><br>
      <input type="text" class="form-control" name="address" id="address" value="<c:out value="${sitrequest.address }" />"><br>
      <input type="text" class="form-control" name="detailAddress" id="detailAddress" value="<c:out value="${sitrequest.detailAddress }" />">
      <input type="text" class="form-control" name="extraAddress" id="extraAddress" value="<c:out value="${sitrequest.extraAddress }" />">
   </div>
   
   


   <div class="mb-3">
      <label for="formFileSm" class="form-label">이미지</label> 
      <input class="form-control form-control-sm" id="formFileSm" type="file" name="file" />
      <div class="select_img">
         <img src="<c:out value="${sitrequest.img }" />" />
         <input type="hidden" name="img" value="${sitrequest.img}" />
        <input type="hidden" name="thumImg" value="${sitrequest.thumImg}" /> 
      </div>
   </div>

   <sec:authentication property="principal" var="pinfo" />
   <sec:authorize access="isAuthenticated()">
   <c:if test="${pinfo.username eq sitrequest.writer }">

   <button type="submit" data-oper='modify' class="btn btn-success">글수정</button>
   <button type="submit" data-oper='remove' class="btn btn-danger">삭제</button>
   
   </c:if>
   </sec:authorize>
   <button type="submit" data-oper='list' class="btn btn-info" id="requestListBtn">목록</button>

</form>

<script src="/resources/js/jquery.datetimepicker.full.min.js"></script>
<script src="/resources/js/mdtimepicker.js"></script>



<script>
   $("#formFileSm").change(
         function() {
            if (this.files && this.files[0]) {
               var reader = new FileReader;
               reader.onload = function(data) {
                  $(".select_img img").attr("src", data.target.result)
                        .width(500);
               }
               reader.readAsDataURL(this.files[0]);
            }
         });
</script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script>
    function Daum_Address() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("extraAddress").value = '';
                }

                document.getElementById("address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("detailAddress").focus();
            }
        }).open();
    }
</script>
<script>
   $(document).ready(
         function() {


            var formObj = $("form");/* 문서중 form 요소를 찾아서 변수에 할당. */
            $('button').on(
                  "click",
                  function(e) {
                     /* 버튼이 클릭된다면 아래 함수 수행, e라는 이벤트 객체를
                     전달하면서 */
                     e.preventDefault();/* 기본 이벤트 동작 막기. */
                     var operation = $(this).data("oper");
                     

                     /* 버튼에서 oper 속성 읽어서 변수에 할당. */
                     console.log(operation);
                     /* 브라우저 로그로 oper값 출력. */
                     if (operation === 'remove') {
                        
                        if (confirm("정말 삭제하시겠습니까??") == true){    //확인

                           formObj.attr("action", "/sitrequest/remove?${_csrf.parameterName}=${_csrf.token}");

                        }else{   //취소

                            return false;

                        }
                        /* form에 액션 속성을 변경. */
                     } else if (operation === 'list') {

                        formObj.attr("action","/sitrequest/list")
                        .attr("method","get");
                        var pageNumTag=$("input[name='pageNum']");
                        var amountTag=$("input[name='amount']");
                        formObj.empty();//폼의 내용들 비우기.
                        formObj.append(pageNumTag);
                        formObj.append(amountTag);
                        }

                     formObj.submit();
                     /* 위의 조건이 아니라면 수정 처리. */
                  });
    
});
</script>


<%@ include file="../includes/footer.jsp"%>