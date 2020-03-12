<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/mypage/mypage.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/mypage/mypageMain.css">
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script type="text/javascript">
	$(function(){
		$("#load").click(function(){
			location.href="<c:url value='/mypage/mypage.do'/>";
		});	
	});
</script>
<body>
  <!-- Page Content -->
  <div class="container">

    <!-- my page로 이동-->
    <div id="load" style="display: inline-block;">
    <label id="main" class="mt-4 mb-3">${sessionScope.userid }</label>
    <span id="bt">'s BOOK TIME</span>
	</div>
	
    <!-- Content Row -->
    <div class="row">
	 <!-- Sidebar -->
	  <div class="col-lg-3 mb-4">
		<div class="list-group">
			<a id="a1" class="list-group-item list-group-item-action active"> 주문내역</a>
			<a id="h1" href="<c:url value="/payment/paymentList.do"/>" 
				class="list-group-item list-group-item-action">주문 조회/변경/취소</a>
			  
			<a id="a2" class="list-group-item list-group-item-action active"> 나의 포인트</a>
			<a href="<c:url value='/mypage/Mileage/Mileage.do'/>" class="list-group-item list-group-item-action">마일리지</a>
			  
			<a id="a3" class="list-group-item list-group-item-action active"> 관심상품</a>
			<a href="<c:url value='/favorite/favorite.do'/>" class="list-group-item list-group-item-action">찜 목록</a>
			<a href="<c:url value='/favorite/cart.do'/>" class="list-group-item list-group-item-action">장바구니</a>
			  
			<a id="a4" class="list-group-item list-group-item-action active"> 회원정보</a>
			<a href="<c:url value='/mypage/myinfo/selectPWD.do'/>" class="list-group-item list-group-item-action">회원정보 수정/조회</a>
			<a id="k4" href="<c:url value='/mypage/myinfo/userout.do'/>" class="list-group-item list-group-item-action">회원탈퇴</a>
		</div>
	  </div>