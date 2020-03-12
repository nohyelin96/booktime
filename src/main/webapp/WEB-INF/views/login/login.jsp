<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="../inc/top.jsp" %> 
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
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script type="text/javascript">
	$(function(){
		$("#btn").click(function(){
			if($("#userid").val().length<1){
				alert("아이디를 입력하세요");
				event.preventDefault();
				$("#userid").focus();
			}else if($("#pwd").val().length<1){
				alert("비밀번호를 입력하세요");
				event.preventDefault();
				$("#pwd").focus();
			}
		});
	});
	
	$(document).ready(function(){
		if($("#userid").val().length>0){
			$("input[type=checkbox]").attr("checked", true);
		}
	});
</script>
</head>
<body>
	
	<div class="limiter">
		<div class="container-login100">
			<div class="wrap-login100 p-t-50 p-b-90">
				<form class="login100-form validate-form flex-sb flex-w" method="post"
					action="<c:url value='/login/login.do'/>">
					<span class="login100-form-title p-b-51">
						로그인
					</span>
						<div class="flex-sb-m w-full p-t-3 p-b-24">
						<div class="contact100-form-checkbox"></div>
						<div>
							<a href="<c:url value='/login/nonLogin.do'/>" class="txt1">
								비회원 주문조회
							</a>
						</div>
						</div>
					
					<div class="wrap-input100 validate-input m-b-16" data-validate = "Username is required">
						<input id="userid" class="input100" type="text" name="userid" placeholder="아이디"
							value="${cookie.ck_userid.value }">
						<span class="focus-input100"></span>
					</div>
					
					
					<div class="wrap-input100 validate-input m-b-16" data-validate = "Password is required">
						<input id="pwd" class="input100" type="password" name="pwd" placeholder="비밀번호">
						<span class="focus-input100"></span>
					</div>
					
					<div class="flex-sb-m w-full p-t-3 p-b-24">
						<div class="form-group form-check">
						    <input name="idSave" type="checkbox" class="form-check-input" id="idSave"
						    	<c:if test="${!empty cookie.c_userid }">
						    		checked
						    	</c:if>>
						    <label class="form-check-label" for="idSave">아이디 저장하기</label>
						 </div>

						<div>
							<a href="<c:url value='/login/searchID.do'/>" class="txt1">
								아이디
							</a>
							<a href="<c:url value='/login/searchPWD.do'/>" class="txt1">
								/ 비밀번호 찾기
							</a>
						</div>
					</div>

					<div class="container-login100-form-btn m-t-17">
						<button id="btn" class="login100-form-btn">
							로그인
						</button>
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