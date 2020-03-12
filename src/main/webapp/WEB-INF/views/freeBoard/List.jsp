<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../inc/top.jsp"%>
<style>
 h2{
 font-family:'Black Han Sans', sans-serif;
 color:#00bcd5;
 }
 li.freeboard a{
 color:white;
 	background-color: #00bcd5;
 }
 li.freeboard a:hover{
 	color:white;
 	font-weight:bold;
 	background-color: #264b6f;
 	transition:0.5s;
 }
 a{
 	color:#264b6f;
 }
</style>

<script>
$(function() {
    $('a[data-toggle="tab"]').on('click', function(e) {
        window.localStorage.setItem('activeTab', $(e.target).attr('href'));
    });
    var activeTab = window.localStorage.getItem('activeTab');
    if (activeTab) {
        $('#myTab a[href="' + activeTab + '"]').tab('show');
        window.localStorage.removeItem("activeTab");
    }
});
</script>

<div class="container">
	<br>
	<h2>&nbsp;<i class="far fa-clipboard" style="color: #d3d3d3 "></i>&nbsp;게시판</h2>	
	<br>

		<ul class="nav nav-tabs" id="myTab">
		<li class="nav-item freeboard" id="list1"><a class="nav-link active" data-toggle="tab"
			href="#qwe">공지사항</a></li>
		<li class="nav-item freeboard" id="list2"><a class="nav-link" data-toggle="tab"
			href="#asd">이벤트</a></li>
		<li class="nav-item freeboard" id="list3"><a class="nav-link" data-toggle="tab"
			href="#zxc">자유게시판</a></li>
		</ul>
		
		<div class="tab-content">
		<div class="tab-pane fade show active" id="qwe">
		<br>
			<c:import url="/freeBoard/Tab1.do"></c:import>	

		</div>
		<div class="tab-pane fade" id="asd">
		<br>
			<c:import url="/freeBoard/Tab2.do"></c:import>	
		</div>
		<div class="tab-pane fade" id="zxc">
		<br>
			<c:import url="/freeBoard/Tab3.do"></c:import>	
			<br>
			<div class="row justify-content-end">
				<a class="btn btn-info"
					href="${pageContext.request.contextPath}/freeBoard/chkUser.do"
					role="button">글쓰기</a>
			</div>
			<br>
		</div>
	</div>	
<!-- 컬럼 -->
</div>

<br>

<!-- Page level plugin JavaScript-->
  <script src="<c:url value='/resources/vendor/chart.js/Chart.min.js' />"></script>
  <script src="<c:url value='/resources/vendor/datatables/jquery.dataTables.js' />"></script>
  <script src="<c:url value='/resources/vendor/datatables/dataTables.bootstrap4.js' />"></script>

<!-- Demo scripts for this page-->
  <script src="<c:url value='/resources/js/demo/datatables-demo.js' />"></script>
    
<%@include file="../inc/bottom.jsp"%>