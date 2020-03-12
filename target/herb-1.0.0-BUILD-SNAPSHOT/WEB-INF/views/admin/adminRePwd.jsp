<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 비밀번호 변경</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<script src="<c:url value='/resources/vendor/jquery/jquery.min.js'/>"></script>
<script type="text/javascript">
	$(function(){
		$(".smit").click(function(){
			if(!$("#currPwd").val()){
				alert("현재 비밀번호를 입력해주세요");
				$("#currPwd").focus();
				return;
			}else if(!$("#newPwd").val()){
				alert("변경할 비밀번호를 입력해주세요");
				$("#newPwd").focus();
				return;
			}else if($("#newPwd").val()!=$("#newPwdCk").val()){
				alert("변경할 비밀번호가 일치하지 않습니다.");
				$("#newPwdCk").focus();
				return;
			}
			
			var d = $("form[name=frm]").serialize();
			
			$.ajax({
				url:"<c:url value='/admin/adminRePwdP.do'/>",
				data: d,
				dataType: "text",
				type:"POST",
				success:function(res){
					if(res=='변경하였습니다.'){
						alert(res);
						
						opener.location.reload();
						self.close();
					}else{
						alert(res);
					}
				},
				error:function(xhr, status, error){
					alert("ERROR!"+xhr.status);
				}
			});
		});
	});
</script>
</head>
<body>
	<div class="container text-center">
		<form name="frm">
			<div class="form-label-group">
				<label for="currPwd"><b>현재 비밀번호</b></label>
				<input type="password" id="currPwd" name="currPwd" placeholder="현재 비밀번호"
					required="required" class="form-control" autofocus="autofocus">
			</div>
			<div class="form-label-group">
				<label for="newPwd" class="text-danger mt-2">변경할 비밀번호</label>
				<input type="password" id="newPwd" name="newPwd" placeholder="변경할 비밀번호"
					required="required" class="form-control">
			</div>
			<div class="form-label-group">
				<label for="newPwdCk" class="text-danger mt-2">변경할 비밀번호 확인</label>
				<input type="password" id="newPwdCk" name="newPwdCk" placeholder="변경할 비밀번호 확인"
					required="required" class="form-control">
			</div>
		</form>		
		<a class="btn btn-info mt-2 smit" href="#">변경</a>
	</div>
</body>
</html>