<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>교환/환불 신청</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<style type="text/css">
	.page{
		border-radius: 10px;
		margin: 5% 0;
	}
</style>
<script src="<c:url value='/resources/vendor/jquery/jquery.min.js'/>"></script>
<script type="text/javascript">
	$(function(){
		if($("input[name=payNo]").val().length<1){
			alert("잘못된 접근입니다.");
			self.close();
		}
		if(${param.progress=='결제완료'}){
			$("input[name=reason]").prop("checked", true);
		}
		
		$("a.btn").click(function(){
			if($(this).text()=='닫기'){
				self.close();
			}else if($(this).text()=='제출'){
				var ck = $("input[name=reason]:checked");
				
				if(ck.length<1){
					alert("신청 사유를 선택해 주세요.");
					$("inpu[name=reason]").focus();
					return;
				}
				if(confirm("제출하시겠습니까?")){
					var ta = $("textarea[name=message]");
					ta.val("/"+ck.val()+" 사유 : "+ta.val()+"/");
					
					if(ck.val()=="교환"){
						$("input[name=progress]").val("교환 신청중");
					}else if(ck.val()=="환불"){
						$("input[name=progress]").val("환불 신청중");
					}
				
					var frmData = $("form[name=frmRefund]").serialize();
					$.ajax({
						url:"<c:url value='/payment/refundForm.do'/>",
						data: frmData,
						dataType:"text",
						type:"POST",
						success:function(res){
							if(res){
								$("textarea").val("");
								alert(ck.val()+" 신청 되었습니다.");
								opener.location.reload();
								self.close();
							}
						},
						error:function(xhr, status, error){
							alert("ERROR!.."+status+".."+error);
						}
					});
				}
				
			}
		});
	});
</script>
</head>
<body class="bg-info">
	<div class="container">
		<div class="container page" style="width: 100%;background-color: white;">
			<div class="page-header pt-2">
				<h2><c:if test="${param.progress!='결제완료' }">교환/</c:if>환불 신청서 작성</h2>
				<small><b>주문번호 : ${param.payNo}</b></small><br>
				<small class="text-danger">▶ 정당한 이유없이 <c:if test="${param.progress!='결제완료' }">교환/</c:if>환불 신청시 거절될 수 있습니다.</small><br>
				<c:if test="${param.progress!='결제완료' }">
					<small class="text-danger"><b>▶ 아래의 주소로 교환이나 환불을 받으실 물품을 보내주세요.</b></small><br>
					<small class="text-danger" style="font-size: 0.9em;"><b>▶ 주소 :서울시 강남구 역삼동 123-4 책읽시 물류팀</b></small><br>
					<small class="text-danger"><b>▶ 동봉된 봉투안의 상세 신청서를 작성하시고 반송배송비와 함께 보내주세요.</b></small><br>
					<small class="text-danger">▶ 반송배송비는 <b>교환시 왕복 4,500원, 환불시 2,500원</b> 입니다.</small><br>
				</c:if>
				<hr>
			</div>
			
			<div class="form-group align-middle pb-3">
				<b>신청 사유 : </b>&nbsp;
				<c:if test="${param.progress!='결제완료' }">
					<label class="radio-inline">
						<input type="radio" name="reason" value="교환"> 교환
					</label>
				</c:if>
				<label class="radio-inline">
					<input type="radio" name="reason" value="환불">환불
				</label>
				
				<form name="frmRefund" method="post">
					<textarea name="message" class="form-control" 
						rows="<c:if test='${param.progress=="결제완료"}'>14</c:if>
						<c:if test='${param.progress!="결제완료" }'>10</c:if>"
						style="width: 100%;resize: none;"></textarea>
					<div class="text-center mt-2">
						<a href="#" class="btn btn-danger">닫기</a>
						<a href="#" class="btn btn-info">제출</a>
					</div>
					<input type="hidden" name="payNo" value="${param.payNo}">
					<input type="hidden" name="progress" value="교환/환불 신청중">
				</form>
			</div>
		</div>
	</div>
</body>
</html>