<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style type="text/css">
	#foot{
		margin-top: 150px;
	}
</style>
<body>
	<footer id="foot" class="py-5 bg-info">
		<div class="container">
		<p class="m-0 text-center text-white">
		대표:이도서 사업자정보 : 123-45-67890 
		통신판매업 신고업번호 : 서울 제1호-책읽기좋은시간 <a href="#">[사업자정보확인]</a> </br> 
		주소 : 서울시 강남구 역삼동 123-4 ABC타워 3층 101호 TEL : 02-1234-5678 
		fax : 02-1234-5678 </br> 
		개인정보관리책임자 :	이도서 (admin@booktime.com) </br>
		</p>
			<p class="m-0 text-center text-white">Copyright &copy; Your
				Website 2019</p>
				<br><br>
			<div class="text-center">
				<button class="btn btn-primary btn-lg align-middle" type="button" 
				onclick="location.href='${pageContext.request.contextPath}/faq.do'">자주 묻는 질문</button>
			</div>
		</div>
		<!-- /.container -->
	</footer>
</body>
</html>