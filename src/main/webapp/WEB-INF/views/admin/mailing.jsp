<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메일작성</title>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"
	integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh"
	crossorigin="anonymous">
<style type="text/css">
	.page{
		border-radius: 10px;
		margin: 5% 0;
	}
	.mailInput{
		width: 250px;
    	position: absolute;
    	margin: 3px;
    	display: none;
	}
	.email{
		overflow: auto;
		width: 100%;
	}
</style>
<script src="<c:url value='/resources/vendor/jquery/jquery.min.js'/>"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript">
	$(function(){
		$(".all").click(function(){
			$(".agree option").prop("selected", $(this).prop("checked"));
		});
		
/* 		$("input[name=addEmail]").autocomplete({
			source : ${arr},	// source 는 자동 완성 대상
			select : function(event, ui) {	//아이템 선택시
				console.log(ui.item);
			},
			focus : function(event, ui) {	//포커스 가면
				return false;//한글 에러 잡기용도로 사용됨
			},
			minLength: 1,// 최소 글자수
			autoFocus: true, //첫번째 항목 자동 포커스 기본값 false
			classes: {	//잘 모르겠음
			    "ui-autocomplete": "highlight"
			},
			delay: 500,	//검색창에 글자 써지고 나서 autocomplete 창 뜰 때 까지 딜레이 시간(ms)
//			disabled: true, //자동완성 기능 끄기
			position: { my : "right top", at: "right bottom" },	//잘 모르겠음
			close : function(event){	//자동완성창 닫아질때 호출
				console.log(event);
			}

		});
 */	});
</script>
</head>
<body class="bg-info">
	<div class="container">
		<div class="container page" style="width: 100%;background-color: white;">
			<div class="page-header pt-2">
				<h2>메일작성</h2>
				<c:if test="${!empty list }">
						<div>
							<strong class="text-primary">이메일 수신동의</strong>
							<label style="float: right;"><input type="checkbox" class="all">모두 선택</label>
						</div>
						<select name="email" class="email agree form-control" multiple="multiple">
							<c:forEach var="map" items="${list }">
								<option value="${map['email'] }">${map['email'] }</option>
							</c:forEach>
						</select>
				</c:if>
				<strong>직접작성</strong>
				<input type="text" name="addEmail" class="form-control">
				<hr>
			</div>
			
			<div class="form-group align-middle pb-3">
				<form name="frmRefund" method="post">
					<label style="width: 100%"> 제목 :
						<input type="text" name="title" class="form-control">
					</label>
					<label style="width: 100%"> 내용 :
						<textarea name="content" class="form-control" 
							style="width: 100%;resize: none;"></textarea>
					</label>
					<div class="text-center mt-2">
						<a href="#" class="btn btn-danger">닫기</a>
						<a href="#" class="btn btn-info">제출</a>
					</div>
				</form>
			</div>
		</div>
	</div>
</body>
</html>