<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="../inc/top.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 약관</title>
</head>
<script type="text/javascript" 
src="${pageContext.request.contextPath }/resources/vendor/jquery/jquery.js"></script>
<script type="text/javascript"> 
	function send(frmAgree){ 
		if(!frmAgree.chkAgree.checked){ 
			alert("약관에 동의해주십시오"); 
			frmAgree.chkAgree.focus(); 
			return false; 
		}
		return true;
	} 
</script>
<style type="text/css">
	#frame{	text-align: center;	}
	h2{	margin-top: 80px;
		color: rgb(0 153 174);
	}
	#clause{
		margin-top: 30px;
		width: 1000px;
		height: 500px;
	}
	#sub,#res{
		width: 80px;
		border: none;
		background-color: gray;
		height: 30px;
		color: white;
		border-radius: 3px;
		font-size: 0.8em;
	}
	#frmAgree{
	margin-left: 650px;
	width: 900px;
	height: 300px;
	text-align: center;
	mar
	}
	#frmAgree label{
		font-size: 0.8em;
	}
	#frmAgree input[type=checkbox]{
		margin-left: 600px;
	}
	#btn{
		margin-right: 150px;
	}
</style>
<body>
<div id="frame">
	<h2>회원 약관</h2><br> 
	<iframe id="clause" src="<c:url value='/user/provision.do'/>" width="900px" height="300px" ></iframe> 
	<div style="width:700px"> 
		<form id="frmAgree" name="frmAgree" method="post" 
		action='<c:url value="/user/register.do"/>' 
		onsubmit="return send(this)"> 
			<div id="chkBox" style="text-align:right"> 
				<input type="checkbox" name="chkAgree" id="chkAgree"> 
				<label for="chkAgree">약관에 동의합니다.</label> 
			</div> 
			<div id="btn" style="text-align:center"> 
				<input id="sub" type="submit" value="확인" > 
				<input id="res" type="reset" value="취소">
			</div>
		</form>
	</div>
</div>
</body>
</html>
<%@include file="../inc/bottom.jsp" %>