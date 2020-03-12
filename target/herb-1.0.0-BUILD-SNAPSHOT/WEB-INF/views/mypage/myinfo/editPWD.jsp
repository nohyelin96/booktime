<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		//$("#editPWD2 span").hide();
	});

	$(function(){
		$("#btn2").click(function(){
			if($("#originPwd").val().length>0 && $("#newPwd").val().length>0 && $("#newPwdOk").val().length>0){
				if($("#newPwd").val()!=$("#newPwdOk").val()){
					alert("새로운 비밀번호를 확인해주세요!");
					event.preventDefault();
					$("#newPwd").focus();
				}
			}
			/*
			if($("#newPwd").val().length<8){ //비밀번호 8자리 미만일경우 에러 문구 보여주기
				$("#editPWD2 span").show();
				event.preventDefault();
				$("#newPwd").focus();
			}else{
				$("#editPWD2 span").hide();
			}*/ 
			
			//비밀번호 길이 테스트 중에는 주석처리하겠습니다.
		});
	});
</script>
</head>
<body>
<form class="frmpwd" name="frmpwd" method="post" action="<c:url value='/mypage/myinfo/editPwd.do'/>">
	<div id="editform">
		<div class="pwdChk">
			<p id="p2">비밀번호 수정</p>
			<fieldset id="editPWD1">
				<label><img src="<c:url value='/resources/images/icons/check.png'/>">기존 비밀번호</label>
				<input type="password" id="originPwd" name="originPwd" required>
			</fieldset>
			
			<fieldset id="editPWD2">
				<label><img src="<c:url value='/resources/images/icons/check.png'/>">새 비밀번호</label>
				<input type="password" id="newPwd" name="newPwd" required>
				<span>비밀번호는 영문자와 숫자를 포함해야 합니다.</span>
			</fieldset>
			
			<fieldset id="editPWD3">
				<label><img src="<c:url value='/resources/images/icons/check.png'/>">새 비밀번호 확인</label>
				<input type="password" id="newPwdOk" required>
			</fieldset>
			<fieldset id="causion">
				<p id="sub"><strong>주의하세요!</strong>
			아이디와 같은 비밀번호나 주민등록번호, 생일, 학번, 전화번호 등 개인정보와 관련된 숫자나 연속된 숫자,
			통일 반복된 숫자 등 다른 사람이 쉽게 알아 낼 수 있는 비밀번호는 사용하지 않도록 주의하여 주시기 바랍니다.</p>
			</fieldset>
			<button type="submit" id="btn2">비밀번호 변경</button>
		</div>
	</div>
</form>
</body>
</html>