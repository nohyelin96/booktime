<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 중복 확인</title>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/vendor/jquery/jquery.js"></script>
<script type="text/javascript">
	function send(frmChk){
		if(!frmChk.userid.value){
			alert("아이디를 입력해주세요");
			frmChk.userid.focus();
			return false;
		}else if($("#userid").val().length<8){
			alert("아이디는 8자리 이상 입력하셔야 합니다.");
			return false;
		}		
		return true;
	}
	
	function setUserid(){
		if($("#userid").val().length<8){
			alert("아이디는 8자리 이상 입력하셔야 합니다.");
			event.preventDefault();
			$("#userid").focus();
		}else{
			opener.frm1.userid.value=frmChk.userid.value;
			opener.frm1.chkid.value="Y"; //중복확인을 한경우
			self.close();
		}
	}
</script>
<style type="text/css">
form{
	margin-top: 30px;
}
label{
	color: rgb(0 153 174);
}
input[name=userid]{
	width: 150px;
	border-radius: 0.2em;
	border-style: groove; 
	height: 20px;
}
strong{
	color: rgb(0 153 174);
}
#use{
	color: red;
}
</style>
</head>
<body>
<form name="frmChk" method="post" 
action="<c:url value='/user/chkId.do'/>"
onsubmit="return send(this)">
	<label for="userid">아이디 중복 검사 : </label>
	<input type="text" name="userid" id="userid" 
	value="${param.userid }">
	<input type="submit" value="아이디 확인">
	<!-- 중복 검사 -->
	<c:if test="${result==false && param.userid!=null
	&& !empty param.userid }">
		<input type="button" value="사용하기" onclick="setUserid()">
			<p><strong>" ${param.userid } "</strong> 은(는) 사용가능한 아이디입니다. 
			사용하시려면 <label id="use">[사용하기]</label> 버튼을 눌러주세요</p>
	</c:if>
	<c:if test="${result==true }">
		<p>이미 사용중인 아이디입니다. 다른 아이디를 입력해주세요.</p>
	</c:if>
</form>
</body>
</html>