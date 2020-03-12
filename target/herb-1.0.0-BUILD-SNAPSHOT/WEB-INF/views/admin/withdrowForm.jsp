<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 탈퇴 사유</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<style type="text/css">
	.page{
		border-radius: 10px;
		margin: 5% 0;
	}
</style>
<script src="<c:url value='/resources/vendor/jquery/jquery.min.js'/>"></script>
<script type="text/javascript">
$(function() {
	if('close'=='${param.mode}'){
		opener.location.reload();
		self.close();
	}
	
	$("#close").click(function(){
		opener.location.reload();
		self.close();		
	});
});	
</script>
</head>
<body class="bg-dark">
	<div class="container">
		<div class="container page" style="width: 100%; height:450px; background-color: white;">
			<div class="page-header pt-2">
				<h2>탈퇴 사유를 기입해 주세요</h2>
				<small><b>회원 아이디 : ${param.userid}</b></small><br>
				
				<hr>
			</div>
			
			<div class="form-group align-middle pb-3">
				<b>탈퇴 사유 : </b>&nbsp;
				
				<form name="frmRefund" method="post"
				action="<c:url value='/admin/withdrowForm.do'/>">
				<input type="hidden" id="userid" name="userid" value="${param.userid}">
					<textarea name="reason" class="form-control" id="reason" 
						rows="10" style="width: 100%;"></textarea>
					<div class="text-center mt-2">
						<a href="" class="btn btn-danger" id="close">닫기</a>
						<button class="btn btn-info" name="submit" type="submit"
						id="drow">탈퇴</a>
					</div>
				</form>
			</div>
		</div>
	</div>
</body>
</html>