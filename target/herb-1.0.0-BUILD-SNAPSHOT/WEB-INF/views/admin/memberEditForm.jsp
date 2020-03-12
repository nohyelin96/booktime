<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 정보 수정</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"
	integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh"
	crossorigin="anonymous">
<style type="text/css">
.page {
	border-radius: 10px;
	margin: 5% 0;
}
</style>
<script src="<c:url value='https://code.jquery.com/jquery-3.4.1.js'/>"></script>

<script
	src="<c:url value='https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js'/>"></script>
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
		if("reload"=='${param.mode}'){
			opener.location.reload();
		}
		
		if(${empty userVo}){
			window.resizeTo(550,220);
		}
		
		$("#close").click(function(){
			self.close();		
		});

		$("#email2").change(function() {
			if ($(this).val() == 'etc') {
				$("#email3").val("");
				$("#email3").css("visibility", "visible");
				$("#email3").focus();
			} else {
				$("#email3").css("visibility", "hidden");
			}
		});

		
		$("form[name=loginForm]").submit(function(){
			if($("#mileage").val()!=0 && !$("input[name=reason]").val()){
				alert("마일리지 변경시, 변경사유를 입력해야 합니다.");
				$("input[name=reason]").focus();
				return false;
			}
		});
	});
</script>

<style type="text/css">
#error, #error2 {
	color: #17a2b8;
	display: none;
}
</style>

</head>

<body class="bg-dark">
	<c:if test="${empty userVo }">
		<form action="<c:url value='/admin/memberReturn.do'/>" method="post" name="frmRe">
			<input type="hidden" name="userid" value="${param.userid }">
			<div class="text-center m-3 p-3" style="background-color: white;border-radius: 10px;">
				<h2 class="text-danger">탈퇴한 회원 입니다.</h2>
				<input type="submit" class="btn btn-danger" value="탈퇴 취소">
			</div>
		</form>
	</c:if>

	<c:if test="${!empty userVo }">
		<div class="container">
			<div class="card card-register mx-auto mt-5">
				<div class="card-body">
	
					<form name="loginForm" method="post"
						action="<c:url value='/admin/memberEditForm.do'/>">
						<div class="form-group">
							<input type="hidden" id="grade" name="grade" class="form-control"
								value="A">
							<input type="hidden" id="pwd" name="pwd" class="form-control"
								value="${userVo.pwd }">	
							<div class="form-label-group">
								<label for="userid">회원 아이디</label> <input type="text" id="userid"
									name="userid" class="form-control" placeholder="아이디"
									value="${param.userid}" readonly>
							</div>
						</div>
	
						<div class="form-group">
							<div class="form-label-group">
								<label for="name">이름</label> <input type="text" id="name"
									class="form-control" name="name" value="${userVo.name }"
									readonly>
							</div>
						</div>
	
						<div class="form-row">
							<div class="form-group col-auto">
								<label for="email1">이메일</label> <input type="text" id="email1"
									name="email1" class="form-control" placeholder="이메일"
									required="required" value="${userVo.email1 }">
	
							</div>
	
							<div class="form-group col-auto">
								<label for="email2">&nbsp;</label> <select name="email2"
									id="email2" name="email2" class="form-control" required>
									<!-- if select -->
									<option value="naver.com"
									<c:if test="${vo.email2=='naver.com'}">
	            					selected
	            					</c:if>
									>naver.com</option>
									<option value="gmail.com"
									<c:if test="${vo.email2=='gmail.com'}">
	            					selected
	            					</c:if>
									>gmail.com</option>
									<option value="daum.net"
									<c:if test="${vo.email2=='daum.net'}">
	            					selected
	            					</c:if>
									>daum.net</option>
									<option value="nate.com"
									<c:if test="${vo.email2=='nate.com'}">
	            					selected
	            					</c:if>
									>nate.com</option>
									<option value="etc">직접입력</option>
								</select> <input type="text" id="email3" name="email3"
									class="form-control" placeholder="이메일 직접입력"
									style="visibility: hidden">
							</div>
						</div>
	
						<div class="form-group">
							<div class="form-label-group">
								<label for="birthCal">생년월일</label> <input class="form-control"
									type="date" value="${userVo.birth }" id="birthCal" name="birth"
									readonly>
							</div>
						</div>
	
	
						<div class="form-row">
							<div class="form-group col">
								<label for="phone">연락처</label> 
								<input type="text" name="phone" id="phone"
									class="form-control" required="required" value="${userVo.phone }">
							</div>
							
							<div class="form-group col">
								<label for="mileage">마일리지 변경(${userVo.mileage }P 보유)</label><br>
								<input type="number" id="mileage" name="mileage" class="form-control" step="100"
									value="0" style="width: 40%;display: inline-block;">
								<input type="text" name="reason" class="form-control" placeholder="변경 사유"
									style="width: 55%;display: inline-block;">
							</div>
						</div>
	
						<div class="form-group">
							<div class="form-row">
								<div class="col-md-5">
									<label for="zipcode">주소</label> <input type="text" id="zipcode"
										name="zipcode" class="form-control" placeholder="우편번호"
										required="required" value="${userVo.zipcode}">
	
								</div>
	
								<div class="col-md-3">
	
									<button type="button" class="btn btn-info"
										onclick="sample4_execDaumPostcode()">우편번호 찾기</button>
	
								</div>
							</div>
						</div>
	
						<div class="form-group">
	
							<input name="newaddress" type="text" class="form-control"
								id="newaddress" placeholder="도로명 주소"
								value="${userVo.newaddress }" required>
	
						</div>
	
						<div class="form-group">
	
							<input name="parseladdress" type="text" class="form-control"
								id="parseladdress" placeholder="지번 주소"
								value="${userVo.parseladdress }" required> <span
								id="addressError" style="color: red; font-size: 0.8em;"></span> <span
								id="guide" style="color: #999; display: none"></span>
	
						</div>
	
						<div class="form-group">
	
							<input name="addressdetail" type="text" class="form-control"
								id="addressdetail" placeholder="상세주소"
								value="${userVo.addressdetail }" required> <input
								type="text" id="extraAddress" style="display: none;">
	
						</div>
	
						<div class="text-center mt-2">
							<a href="#" class="btn btn-danger" id="close">취소</a>
							<button class="btn btn-info" name="submit" type="submit"
							id="edit">수정</a>
						</div>
					</form>
				</div>
			</div>
		</div>
	</c:if>
</body>
</html>