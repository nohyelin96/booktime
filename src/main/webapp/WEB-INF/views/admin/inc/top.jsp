<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>책읽시 관리자 메인</title>

<!-- Custom fonts for this template-->
<link
	href="${pageContext.request.contextPath}/resources/vendor/fontawesome-free/css/all.min.css"
	rel="stylesheet" type="text/css">

<!-- Page level plugin CSS-->
<link
	href="${pageContext.request.contextPath}/resources/vendor/datatables/dataTables.bootstrap4.css"
	rel="stylesheet">

<!-- Custom styles for this template-->
<link
	href="${pageContext.request.contextPath}/resources/css/sb-admin.css"
	rel="stylesheet">

<style>
@import
	url('https://fonts.googleapis.com/css?family=Nanum+Gothic&display=swap')
	;
</style>

<!-- chart.js source -->

<!-- chart.js CDN-->
<script
	src="<c:url value='https://cdn.jsdelivr.net/npm/chart.js@2.9.3/dist/Chart.min.js' />"></script>

<script async
	src="<c:url value='http://www.google-analytics.com/analytics.js' />"></script>
<script src="./Bar Chart_files/Chart.min.js.다운로드"></script>
<script src="<c:url value='/resources/js/utils.js' />"></script>
<style>
canvas {
	-moz-user-select: none;
	-webkit-user-select: none;
	-ms-user-select: none;
}
</style>
<!-- chart.js source -->

<!-- chart.js CDN-->
<script
	src="<c:url value='https://cdn.jsdelivr.net/npm/chart.js@2.9.3/dist/Chart.min.js' />"></script>

<script async
	src="<c:url value='http://www.google-analytics.com/analytics.js' />"></script>
<script src="./Bar Chart_files/Chart.min.js.다운로드"></script>
<script src="<c:url value='/resources/js/utils.js' />"></script>
<script src="<c:url value='/resources/vendor/jquery/jquery.min.js'/>"></script>
<script type="text/javascript">
	$(function(){
		$(".mailing").click(function(){
			window.open("<c:url value='/admin/mailing.do'/>", "mailing", "width=500px,height=650px,top=50px,left=100px,location=no,resizable=no");
			
		});
		
		$("#changePwd").click(function(){
			window.open("<c:url value='/admin/adminRePwd.do'/>", "newPwd", "width=500px,height=350px,top=100px,left=200px,location=no,resizable=no");
		});
	});
</script>

<style>
canvas {
	-moz-user-select: none;
	-webkit-user-select: none;
	-ms-user-select: none;
}
</style>
<style type="text/css">/* Chart.js */
@
keyframes chartjs-render-animation {
	from {opacity: .99
}

to {
	opacity: 1
}

}
.chartjs-render-monitor {
	animation: chartjs-render-animation 1ms
}

.chartjs-size-monitor, .chartjs-size-monitor-expand,
	.chartjs-size-monitor-shrink {
	position: absolute;
	direction: ltr;
	left: 0;
	top: 0;
	right: 0;
	bottom: 0;
	overflow: hidden;
	pointer-events: none;
	visibility: hidden;
	z-index: -1
}

.chartjs-size-monitor-expand>div {
	position: absolute;
	width: 1000000px;
	height: 1000000px;
	left: 0;
	top: 0
}

.chartjs-size-monitor-shrink>div {
	position: absolute;
	width: 200%;
	height: 200%;
	left: 0;
	top: 0
}
</style>


<!-- Bootstrap core JavaScript-->
<script src="<c:url value='/resources/vendor/jquery/jquery.min.js' />"></script>
<script
	src="<c:url value='/resources/vendor/bootstrap/js/bootstrap.bundle.min.js' />"></script>

<!-- Core plugin JavaScript-->
<script
	src="<c:url value='/resources/vendor/jquery-easing/jquery.easing.min.js' />"></script>

<!-- Page level plugin JavaScript-->
<script src="<c:url value='/resources/vendor/chart.js/Chart.min.js' />"></script>
<script
	src="<c:url value='/resources/vendor/datatables/jquery.dataTables.js' />"></script>
<script
	src="<c:url value='/resources/vendor/datatables/dataTables.bootstrap4.js' />"></script>

<!-- Custom scripts for all pages-->
<script src="<c:url value='/resources/js/sb-admin.min.js' />"></script>

<!-- Demo scripts for this page-->
<script src="<c:url value='/resources/js/demo/datatables-demo.js' />"></script>
<script src="<c:url value='/resources/js/demo/chart-area-demo.js' />"></script>

</head>
<body id="page-top">
	<nav class="navbar navbar-expand navbar-dark bg-dark static-top">

		<a class="navbar-brand"
			href="${pageContext.request.contextPath}/admin/adminMain.do"> <img
			src="<c:url value='/resources/images/logo.png' />">
		</a>

		<!-- <button class="btn btn-link btn-sm text-white order-1 order-sm-0"
			id="sidebarToggle" href="#">
			<i class="fas fa-bars"></i>
		</button>-->

		<!-- Navbar -->
		<div class="row" style="width: 1100px">
			<ul class="navbar-nav" style="width: 1100px">
				<div class="col offset-md-8"></div>

				<c:if test="${!empty sessionScope.useridA }">
					<li class="nav-item" style="width: 90px"><b class="nav-link">
							${sessionScope.useridA }님 </b></li>
				</c:if>

				<!-- <li class="nav-item" style="width: 90px"><a class="nav-link mailing"
					href="#"> 메일 쓰기 </a></li> -->

				<li class="nav-item dropdown no-arrow"><a
					class="nav-link dropdown-toggle" href="#" id="userDropdown"
					role="button" data-toggle="dropdown" aria-haspopup="true"
					aria-expanded="false"> 관리자 설정 </a>

					<div class="dropdown-menu dropdown-menu-right"
						aria-labelledby="userDropdown">

						<a class="dropdown-item"
							href="${pageContext.request.contextPath}/admin/adminJoin.do">
							새 관리자 등록</a>
						<a class="dropdown-item" href="#" id="changePwd">비밀번호 변경</a>
						<div class="dropdown-divider"></div>
						<a class="dropdown-item" href="#" data-toggle="modal"
							data-target="#logoutModal">로그아웃</a>
					</div></li>
			</ul>
		</div>

	</nav>

	<div id="wrapper">
		<div class="dropdown-menu dropdown-menu-right"
			aria-labelledby="alertsDropdown">
			<a class="dropdown-item" href="#">새 회원</a> <a class="dropdown-item"
				href="#">새 주문</a>
			<div class="dropdown-divider"></div>
			<a class="dropdown-item" href="#">새 글</a>
		</div>
	</div>

	<div id="wrapper">
		<!-- Sidebar -->
		<ul class="sidebar navbar-nav">

			<li class="nav-item"><a class="nav-link"
				href="${pageContext.request.contextPath}/admin/adminMember.do">
					<span>회원 관리</span>
			</a></li>
			<%-- <li class="nav-item"><a class="nav-link"
				href="${pageContext.request.contextPath}/admin/adminEvent.do"> <span>이벤트 관리</span></a>
			</li> --%>
			<li class="nav-item"><a class="nav-link"
				href="${pageContext.request.contextPath}/admin/adminRe.do"> <span>노출 관리</span></a>
			</li>
			<li class="nav-item"><a class="nav-link"
				href="${pageContext.request.contextPath}/admin/adminBoard.do"> <span>게시글
						관리</span></a></li>
			<li class="nav-item"><a class="nav-link"
				href="${pageContext.request.contextPath}/admin/adminCart.do"> <span>주문
						관리</span></a></li>
		</ul>

		<div id="content-wrapper">

			<div class="container-fluid">