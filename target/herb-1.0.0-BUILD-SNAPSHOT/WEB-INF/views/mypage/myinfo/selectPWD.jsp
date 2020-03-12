<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/mypage/selectPWD.css">
<%@include file="../../inc/top.jsp" %>  
<%@include file="../includeMy.jsp" %>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		$("#pwd").focus();
s	});
	
	$("submit").click(function(){
		if($("#pwd").val().length<1){
			alert("비밀번호를 입력하세요");
			event.preventDefault();
			$("#pwd").focus();
		}
	});
</script>

<form name="frm" method="post" action="<c:url value='/mypage/myinfo/userInfo.do'/>">
	<!-- 회원정보 수정 전 비밀번호 체크 -->
	<div id="memberInfo">
		<p class="info1">개인정보 열람</p>
		<hr><hr>
		<div class="info">
			<p>비밀번호 확인</p>
			<span>회원님의 정보를 안전하게 보호하기 위해 비밀번호를 다시 한 번 확인합니다.</span>
			<div id="ok">
			<label>비밀번호 </label>&nbsp;&nbsp; <input type="password" name="pwd" id="pwd">
			&nbsp;&nbsp;<input type="submit" value="확인">
			</div>
		</div>
		<div id="conf">
			<p>회원님의 개인정보를 신중히 취급하며, 회원님의 동의 없이는 기재하신 회원정보를 공개 및 변경하지 않습니다.</p>
		</div>
	</div>
</form>
</div>
</div>

<%@include file="../../inc/bottom.jsp" %>