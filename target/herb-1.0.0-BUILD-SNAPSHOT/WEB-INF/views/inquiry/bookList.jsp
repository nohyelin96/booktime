<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../inc/top.jsp" %>
    
<style>

.item{

/* 상품들을 가로로 나열해주기 위한 css */

	width:400px; /* 이미지 사이즈 보단 살짝 크게 */

	float:left; 

	margin:0 13px;

	text-align:center;

}

</style>

<!-- Page Content -->
	  <div class="container">
	  <!-- Content Row -->
	    <div class="row">
	      <!-- Sidebar Column -->
	      <div class="col-lg-2 mb-4">
	        <div class="list-group">
	          <a href="#" class="list-group-item">소설</a> <!-- 100 -->
	          <a href="#" class="list-group-item">시/에세이</a> <!-- 110 -->
	          <a href="#" class="list-group-item">인문</a> <!-- 120 -->
	          <a href="#" class="list-group-item">가정/생활/요리</a> <!-- 130 -->
	          <a href="#" class="list-group-item">건강</a> <!-- 140 -->
	          <a href="#" class="list-group-item">취미/레저</a> <!-- 150 -->
	          <a href="#" class="list-group-item">경제/경영</a> <!-- 160 -->
	          <a href="#" class="list-group-item">자기계발</a> <!-- 170 -->
	          <a href="#" class="list-group-item">사회</a> <!-- 180 -->
	          <a href="#" class="list-group-item">역사/문화</a> <!-- 190 -->
	          <a href="#" class="list-group-item">종교</a> <!-- 200 -->
	          <a href="#" class="list-group-item">예술/대중문화</a> <!-- 210 -->
	          <a href="#" class="list-group-item">학습/참고서</a> <!-- 220 -->
	          <a href="#" class="list-group-item">국어/외국어</a> <!-- 230 -->
	          <a href="#" class="list-group-item">사전</a> <!-- 240 -->
	          <a href="#" class="list-group-item">과학/공학</a> <!-- 250 -->
	          <a href="#" class="list-group-item">취업/수험서</a> <!-- 260 -->
	          <a href="#" class="list-group-item">여행/지도</a> <!-- 270 -->
	          <a href="#" class="list-group-item">컴퓨터/IT</a> <!-- 280 -->
	          <a href="#" class="list-group-item">잡지</a> <!-- 290 -->
	          <a href="#" class="list-group-item">청소년</a> <!-- 300 -->
	          <a href="#" class="list-group-item">유아</a> <!-- 310 -->
	          <a href="#" class="list-group-item">어린이</a> <!-- 320 -->
	          <a href="#" class="list-group-item">만화</a> <!-- 330 -->
	          <a href="#" class="list-group-item">해외도서</a> <!-- 340 -->
        	</div>
      	</div>
      
      	<!-- Main head -->
		이 분야에 ${pagingInfo.totalRecord }개의 상품이 있습니다.
      
      
     </div>
    </div>