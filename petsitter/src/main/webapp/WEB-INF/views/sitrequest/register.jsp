<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>


<%@ include file="../includes/header.jsp"%>

<style>
textarea{
	resize: none;
}
</style>

<form role="form" action="/sitrequest/register?${_csrf.parameterName}=${_csrf.token}" method="post"
	enctype="multipart/form-data">
	
	<div class="mb-3">
		<label for="exampleFormControlInput1" class="form-label">제목 </label> <input
			type="text" class="form-control" id="exampleFormControlInput1"
			name='title' placeholder="제목을 입력하셔요">
	</div>

	<div class="mb-3">
		<label for="exampleFormControlInput1" class="form-label">작성자 </label>
		<input type="text" class="form-control" id="exampleFormControlInput1"
			name='writer' value='<sec:authentication property="principal.username"/>' readonly="readonly">
	</div>

	<div class="mb-3">
		<label for="exampleFormControlTextarea1" class="form-label">
			내용</label>
		<textarea class="form-control" id="exampleFormControlTextarea1"
			rows="3" placeholder="매니저 자기소개" name='content'></textarea>

		<div class="mb-3">
			<label for="exampleFormControlInput1" class="form-label">
			돌봄가능한 동물 </label> <input type="text" class="form-control"
				id="exampleFormControlInput1" name='pet'
				placeholder="ex)강아지,고양이,이구아나,악어">
		</div>
	</div>
	<div class="local">
		<input type="button" onclick="Daum_Address()" value="주소 찾기"><br>
		<input type="text" name="address" id="address" placeholder="주소" required><br>
		<input type="text" name="detailAddress" id="detailAddress" placeholder="상세주소">
		<input type="text" name="extraAddress" id="extraAddress" placeholder="참고항목">
	</div>

	<div class="mb-3">
		<label for="formFileSm" class="form-label">이미지</label> <input
			class="form-control form-control-sm" id="formFileSm" type="file"
			name="file" />
		<div class="select_img">
			<img src="" />
		</div>
	</div>

	<button type="submit" class="btn btn-primary btn-sm">등록</button>
	<button type="reset" class="btn btn-secondary btn-sm">취소</button>
</form>



<script src="/resources/js/mdtimepicker.js"></script>
<script src="/resources/js/jquery.datetimepicker.full.min.js"></script>

<script src="/resources/js/datepicker.js"></script>
<script>
	$("#formFileSm").change(
			function() {
				if (this.files && this.files[0]) {
					var reader = new FileReader;
					reader.onload = function(data) {
						$(".select_img img").attr("src", data.target.result)
								.width(300);
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

<%=request.getRealPath("/")%>

<%@ include file="../includes/footer.jsp"%>

