<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../inc/top.jsp" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<style type="text/css">
	p{
		margin-bottom: 20px;
	}
</style>
</head>
<script type="text/javascript" src="<c:url value='/resources/vendor/jquery/jquery.min.js'/>"></script>
<script type="text/javascript">
	$(function(){
		var name=frm1.name.value;
		var email=frm1.email.value;
		
		$("#btnId").click(function(){
			if($("#name").val().length<1){
				alert("이름을 입력해주세요.");
				event.preventDefault();
				$("#name").focus();
			}else if($("#email").val().length<1){
				alert("이메일을 입력해주세요");
				event.preventDefault();
				$("#email").focus();
			}
		});
	});
	
</script>
<body>
	<div class="limiter">
		<div class="container-login100">
			<div class="wrap-login100 p-t-50 p-b-90">
				<form class="login100-form validate-form flex-sb flex-w" method="post"
					action="<c:url value='/login/getId.do'/>">
				<span class="login100-form-title p-b-51">
						아이디 찾기
					</span>
					<p style="font-size: 0.8em; color: green;">
					- 이름과 E-mail 주소를 입력 후 "가입 여부 확인하기" 버튼을 클릭해주시면 가입 여부를 알려드립니다.</p>
					<div class="wrap-input100 validate-input m-b-16" data-validate = "Username is required">
						<input id="email" class="input100" type="text" name="email" placeholder="가입하신 E-mail 주소를 입력해주세요" required value="${email }">
						<span class="focus-input100"></span>
					</div>
					<div class="wrap-input100 validate-sinput m-b-16" data-validate = "Username is required">
						<input id="name" class="input100" type="text" name="name" placeholder="이름을 입력하세요" required value="${name }">
						<span class="focus-input100"></span>
					</div>
					
					<div class="wrap-input100 validate-input m-b-16" data-validate = "Username is required" required>
						<button type="submit" class="login100-form-btn" id="btnId" onclick="myfunction()">
							가입 여부 확인
						</button>
					</div>
						<div>
							<a href="<c:url value='/login/searchPWD.do'/>" class="txt1">
								비밀번호 찾기
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