<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../inc/top.jsp" %> 
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- post방식으로 비밀번호 재설정 page로 보내기 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
<!--===============================================================================================-->	
	<link rel="icon" type="image/png" href="${pageContext.request.contextPath}/resources/images/icons/favicon.ico">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/vendor/bootstrap/css/bootstrap.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/vendor/animate/animate.css">
<!--===============================================================================================-->	
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/vendor/css-hamburgers/hamburgers.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/vendor/animsition/css/animsition.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/vendor/select2/select2.min.css">
<!--===============================================================================================-->	
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/vendor/daterangepicker/daterangepicker.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/util.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/main.css">
<!--===============================================================================================-->
</head>
<script type="text/javascript" src="<c:url value='/resources/vendor/jquery/jquery.min.js'/>"></script>
<script type="text/javascript">
	$(function(){
		$("#btnPWD").click(function(){
			var pwd=$("#pwd").val();
			var pwdOk=$("#pwdOk").val();
			
			if($("#pwd").val().length<8){
				alert("비밀번호는 영문 대소문자, 숫자, 특수문자를 포함한 8자리 이상이어야 합니다.");
				event.preventDefault();
				$("#pwd").focus();
			}else if(pwd!=pwdOk){
				alert("비밀번호가 다릅니다. 다시 확인해 주세요.");
				event.preventDefault();
				$("#pwdOk").focus();
			}else{
				return true;
			}			
		});
	});
</script>
<style type="text/css">
#chkId{
	font-size: 0.8em;
	color: red;
	display: none;
}
</style>
<body>
	
	<div class="limiter">
		<div class="container-login100">
			<div class="wrap-login100 p-t-50 p-b-90">
				<form name="frm" class="login100-form validate-form flex-sb flex-w" method="post" 
					action="<c:url value='/login/updatePwd.do'/>">
					<span class="login100-form-title p-b-51">
						비밀번호 변경하기
					</span>
					<input type="hidden" name="userid" value="${userid }">
					
					<div class="wrap-input100 validate-input m-b-16" data-validate = "Username is required">
						<input class="input100" type="password" name="pwd" placeholder="새로운 비밀번호를 입력해주세요" id="pwd">
						<span class="focus-input100"></span>
					</div>
					
					<div class="wrap-input100 validate-input m-b-16" data-validate = "Username is required">
						<input class="input100" type="password" id="pwdOk" name="pwdOk" placeholder="비밀번호를 한번 더 입력해 주세요">
						<span class="focus-input100"></span>
					</div>
					
					<div class="wrap-input100 validate-input m-b-16" data-validate = "Username is required">
						<button class="login100-form-btn" id="btnPWD">
							변경하기<img src="<c:url value='/resources/images/icons/NicePng_white-arrow-png-transparent_7587037.png'/>"
								style="width: 8px">
						</button>
					</div>
						<div>
							<a href="<c:url value='/login/searchID.do'/>" class="txt1">
								아이디 찾기
							</a>
							<a href="<c:url value='/login/login.do'/>" class="txt1">
								/ 로그인
							</a>
						</div>
				</form>
			</div>
		</div>
	</div>
	

	<div id="dropDownSelect1"></div>
	
<!--===============================================================================================-->
	<script src="vendor/jquery/jquery-3.2.1.min.js"></script>
<!--===============================================================================================-->
	<script src="vendor/animsition/js/animsition.min.js"></script>
<!--===============================================================================================-->
	<script src="vendor/bootstrap/js/popper.js"></script>
	<script src="vendor/bootstrap/js/bootstrap.min.js"></script>
<!--===============================================================================================-->
	<script src="vendor/select2/select2.min.js"></script>
<!--===============================================================================================-->
	<script src="vendor/daterangepicker/moment.min.js"></script>
	<script src="vendor/daterangepicker/daterangepicker.js"></script>
<!--===============================================================================================-->
	<script src="vendor/countdowntime/countdowntime.js"></script>
<!--===============================================================================================-->
	<script src="js/main.js"></script>

<%@include file="../inc/bottom.jsp" %>