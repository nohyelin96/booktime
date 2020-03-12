<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 등록</title>

<!-- Custom fonts for this template-->
<link href="${pageContext.request.contextPath}/resources/vendor/fontawesome-free/css/all.min.css"
	rel="stylesheet" type="text/css">

<!-- Custom styles for this template-->
<link href="${pageContext.request.contextPath}/resources/css/sb-admin.css"
	rel="stylesheet">

<script src="<c:url value='https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js'/>" ></script>
	
	<!-- Bootstrap core JavaScript-->
	<script src="<c:url value='/resources/vendor/jquery/jquery.min.js' />"></script>
	<script src="<c:url value='/resources/vendor/bootstrap/js/bootstrap.bundle.min.js' />"></script>

	<!-- Core plugin JavaScript-->
	<script src="<c:url value='/resources/vendor/jquery-easing/jquery.easing.min.js' />"></script>

<script src="<c:url value='https://code.jquery.com/jquery-3.4.1.js'/>" ></script>
<script type="text/javascript">
	function sample4_execDaumPostcode() {
		new daum.Postcode(
				{
					oncomplete : function(data) {
						// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

						// 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
						// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
						var roadAddr = data.roadAddress; // 도로명 주소 변수
						var extraRoadAddr = ''; // 참고 항목 변수

						// 법정동명이 있을 경우 추가한다. (법정리는 제외)
						// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
						if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
							extraRoadAddr += data.bname;
						}
						// 건물명이 있고, 공동주택일 경우 추가한다.
						if (data.buildingName !== '' && data.apartment === 'Y') {
							extraRoadAddr += (extraRoadAddr !== '' ? ', '
									+ data.buildingName : data.buildingName);
						}
						// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
						if (extraRoadAddr !== '') {
							extraRoadAddr = ' (' + extraRoadAddr + ')';
						}

						// 우편번호와 주소 정보를 해당 필드에 넣는다.
						document.getElementById('zipcode').value = data.zonecode;
						document.getElementById("newaddress").value = roadAddr;
						document.getElementById("parseladdress").value = data.jibunAddress;

						// 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
						if (roadAddr !== '') {
							document.getElementById("extraAddress").value = extraRoadAddr;
						} else {
							document.getElementById("extraAddress").value = '';
						}

						var guideTextBox = document.getElementById("guide");
						// 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
						if (data.autoRoadAddress) {
							var expRoadAddr = data.autoRoadAddress
									+ extraRoadAddr;
							guideTextBox.innerHTML = '(예상 도로명 주소 : '
									+ expRoadAddr + ')';
							guideTextBox.style.display = 'block';

						} else if (data.autoJibunAddress) {
							var expJibunAddr = data.autoJibunAddress;
							guideTextBox.innerHTML = '(예상 지번 주소 : '
									+ expJibunAddr + ')';
							guideTextBox.style.display = 'none';
						} else {
							guideTextBox.innerHTML = '';
							guideTextBox.style.display = 'none';
						}
					}
				}).open()
	}
</script>
<script>
	$(function() {
		$("#userid").bind("change keyup input", function() {
			if ($(this).val().length >= 3) {
				//ajax로 아이디 중복확인 처리
				$.ajax({
					url : "<c:url value='/admin/ajaxCheckId.do' />",
					type : "post",
					//dataType : "json",
					data : {
						"userid" : $(this).val()
					},
					success : function(res) {
						//alert(res);
						var str = "";
						if (res) {
							str = "사용가능한 아이디입니다";
							$("#chkId").val("Y");
						} else {
							str = "이미 등록된 아이디입니다";
							$("#chkId").val("N");
						}
						$("#error").html(str);
						$("#error").show();
					},
					error : function(xhr, status, error) {
						alert("Error:" + status + "=>" + error);
					}
				});
			} else {
				$("#error").html("아이디는 영문 혹은 숫자 3글자 이상으로 만들어 주세요.");
				$("#error").show();
				$("#chkId").val("N");
			}
		});

		$('#pwd2').blur("change keyup input", function() {
			
			if(pwd2!=""){
				if ($('#pwd1').val() != $('#pwd2').val()) {
					$("#error2").html("비밀번호 확인란이 비밀번호와 일치하지 않습니다");
					$("#error2").show();
				}else{
					$("#error2").html("비밀번호 확인 완료");
					$("#error2").show();
				}
			}
		});
	
		$("#email2").change(function(){
			if($(this).val()=='etc'){
				$("#email3").val("");
				$("#email3").css("visibility","visible");
				$("#email3").focus();				
			}else{
				$("#email3").css("visibility","hidden");
			}
		});
		
	});
</script>

<style type="text/css">
#error,#error2 {
	color: #17a2b8;
	display: none;
}
</style>

</head>

<body class="bg-dark">

	<div class="container">
		<div class="card card-register mx-auto mt-5">
			<div class="card-header">관리자 등록하기</div>
			<div class="card-body">

				<form name="loginForm" method="post" action="<c:url value='/admin/adminJoin.do'/>">
					<div class="form-group">
						<input type="hidden" id="grade" name="grade" class="form-control"
							value="A">
						<div class="form-label-group">
							<input type="text" id="userid" name="userid" class="form-control"
								placeholder="아이디" required="required"> <label
								for="userid">관리자 아이디</label> <span id="error"></span> <input
								type="hidden" name="chkId" id="chkId">
						</div>
					</div>

					<div class="form-group">
						<div class="form-row">
							<div class="col-md-6">
								<div class="form-label-group">
									<input type="password" id="pwd1" name="pwd1"
										class="form-control" placeholder="Password"
										required="required"> <label for="pwd1">비밀번호</label>
								</div>
							</div>
							<div class="col-md-6">
								<div class="form-label-group">
									<input type="password" id="pwd2" name="pwd2"
										class="form-control" placeholder="비밀번호 확인" required="required">
									<label for="pwd2">비밀번호 확인</label>
								</div>
							</div>
							<span id="error2"></span>
						</div>
					</div>

					<div class="form-group">
						<div class="form-label-group">
							<input type="text" id="name" class="form-control" name="name"
								placeholder="이름" required="required"> <label for="name">이름</label>
						</div>
					</div>

					<div class="form-group">
						<div class="form-row">
							<div class="col-md-5">

								<input type="text" id="email1" name="email1"
									class="form-control" placeholder="이메일" required="required">

							</div>
							@
							<div class="col-md-6">
								<div class="form-label-group">
									<select name="email2" id="email2" name="email2"
										class="form-control" required>
										<option value="naver.com" >naver.com</option>
										<option value="gmail.com">gmail.com</option>
										<option value="daum.net">daum.net</option>
										<option value="nate.com">nate.com</option>
										<option value="etc">직접입력</option>
									</select>
								</div>
								<input type="text" id="email3" name="email3"
									class="form-control" placeholder="이메일 직접입력" style="visibility:hidden">
							</div>
						</div>
					</div>

					<div class="form-group">
						<div class="form-label-group">
							<input class="form-control" type="date" value="2020-01-01"
								id="birthCal" name="birth"> <label
								for="example-date-input">생년월일</label>
						</div>
					</div>

					<div class="form-group">
						성별을 선택하세요 :
						<div class="form-check form-check-inline">
							<input class="form-check-input" type="radio" name="gender" id="inlineRadio1" value="F"> <label class="form-check-label" for="inlineRadio1">여성</label>
						</div>
						<div class="form-check form-check-inline">
							<input class="form-check-input" type="radio" name="gender"
								id="inlineRadio2" value="M"> <label
								class="form-check-label" for="inlineRadio2">남성</label>
						</div>
					</div>

					<div class="form-group">
						<div class="form-row">
							<div class="col-md-3">

								<select name="hp1" id="phone1" class="form-control"
									required="required">
									<option selected value="010">010</option>
									<option value="011">011</option>
									<option value="016">016</option>
									<option value="017">017</option>
									<option value="018">018</option>
									<option value="019">019</option>
								</select>

							</div>
							-
							<div class="col-md-3">

								<input type="text" name="hp2" id="phone2" class="form-control"
									required="required">

							</div>
							-
							<div class="col-md-3">

								<input type="text" name="hp3" id="phone3" class="form-control"
									required="required">

							</div>
						</div>
					</div>

					<div class="form-group">
						<div class="form-row">
							<div class="col-md-5">

								<input type="text" id="zipcode" name="zipcode"
									class="form-control" placeholder="우편번호" required="required">

							</div>

							<div class="col-md-3">

								<button type="button" class="btn btn-info"
									onclick="sample4_execDaumPostcode()">우편번호 찾기</button>

							</div>
						</div>
					</div>

					<div class="form-group">

						<input name="newaddress" type="text" class="form-control"
							id="newaddress" placeholder="도로명 주소" required>

					</div>

					<div class="form-group">

						<input name="parseladdress" type="text" class="form-control"
							id="parseladdress" placeholder="지번 주소" required> <span
							id="addressError" style="color: red; font-size: 0.8em;"></span> <span
							id="guide" style="color: #999; display: none"></span>

					</div>

					<div class="form-group">

						<input name="addressdetail" type="text" class="form-control"
							id="addressdetail" placeholder="상세주소" required> <input
							type="text" id="extraAddress" style="display: none;">

					</div>

					<button type="submit" class="btn btn-primary btn-block"
						name="submit" id="btn_Join">관리자 등록하기</button>
				</form>
				<div class="text-center">
					<a class="d-block small mt-3"
						href="${pageContext.request.contextPath}/admin/adminLogin.do">로그인으로
						이동</a> <a class="d-block small"
						href="${pageContext.request.contextPath}/admin/adminPassword.do">비밀번호를
						잊었나요?</a>
				</div>
			</div>
		</div>
	</div>


</body>
</html>