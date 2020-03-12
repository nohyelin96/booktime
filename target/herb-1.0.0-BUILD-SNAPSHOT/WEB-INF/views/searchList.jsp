<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="inc/top.jsp" %>
<style>
.btn-blog {
    color: #ffffff;
    background-color: #37d980;
    border-color: #37d980;
    border-radius:0;
    margin-bottom:10px
}
.btn-blog:hover,
.btn-blog:focus,
.btn-blog:active,
.btn-blog.active,
.open .dropdown-toggle.btn-blog {
    color: white;
    background-color:#34ca78;
    border-color: #34ca78;
}
 h2{color:#1c1c1c;}
 .margin10{margin-bottom:10px; margin-right:10px;}
</style>  
  
  <!--검색 Navbar-->
<nav class="navbar navbar-expand-lg">

  <!-- Collapsible content -->
  <div class="collapse navbar-collapse" id="navbarSupportedContent">
    <form class="form-inline mx-auto" action="">
      <input class="form-control-lg" type="text" placeholder="${param.searchKeyword }" aria-label="검색어를 입력하세요">
      <button class="btn btn-primary btn-lg" type="submit">검색</button>
    </form>

  </div>
  <!-- Collapsible content -->

</nav>
<!--/.Navbar-->
<div class="container">
<!-- Content Row -->
    <div class="row">
      <!-- Sidebar Column -->
      <div class="col-lg-2 mb-4">
        <div class="list-group">
          <a href="category.do?cateNo=1" class="list-group-item">소설/시</a> <!-- 1 -->
          <a href="category.do?cateNo=55889" class="list-group-item">에세이</a> <!-- 55889 -->
          <a href="category.do?cateNo=656" class="list-group-item">인문</a> <!-- 656 -->
          <a href="category.do?cateNo=1230" class="list-group-item">가정/생활/요리</a> <!-- 1230 -->
          <a href="category.do?cateNo=53556" class="list-group-item">건강</a> <!-- 53556 -->
          <a href="category.do?cateNo=55890" class="list-group-item">취미/레저</a> <!-- 55890 -->
          <a href="category.do?cateNo=170" class="list-group-item">경제/경영</a> <!-- 170 -->
          <a href="category.do?cateNo=336" class="list-group-item">자기계발</a> <!-- 336 -->
          <a href="category.do?cateNo=798" class="list-group-item">사회</a> <!-- 798 -->
          <a href="category.do?cateNo=74" class="list-group-item">역사/문화</a> <!-- 74 -->
          <a href="category.do?cateNo=1237" class="list-group-item">종교</a> <!-- 1237 -->
          <a href="category.do?cateNo=517" class="list-group-item">예술/대중문화</a> <!-- 517 -->
          <a href="category.do?cateNo=76001" class="list-group-item">학습/참고서</a> <!-- 76001 -->
          <a href="category.do?cateNo=1322" class="list-group-item">국어/외국어</a> <!-- 1322 -->
          <a href="category.do?cateNo=4395" class="list-group-item">사전</a> <!-- 4395 -->
          <a href="category.do?cateNo=987" class="list-group-item">과학/공학</a> <!-- 987 -->
          <a href="category.do?cateNo=1383" class="list-group-item">취업/수험서</a> <!-- 1383 -->
          <a href="category.do?cateNo=1196" class="list-group-item">여행/지도</a> <!-- 1196 -->
          <a href="category.do?cateNo=351" class="list-group-item">컴퓨터/IT</a> <!-- 351 -->
          <a href="category.do?cateNo=2913" class="list-group-item">잡지</a> <!-- 2913 -->
          <a href="category.do?cateNo=112011" class="list-group-item">장르소설</a> <!-- 112011 -->
          <a href="category.do?cateNo=13789" class="list-group-item">유아</a> <!-- 13789 -->
          <a href="category.do?cateNo=1108" class="list-group-item">어린이</a> <!-- 1108 -->
          <a href="category.do?cateNo=2551" class="list-group-item">만화</a> <!-- 2551 -->
          <a href="category.do?cateNo=90834" class="list-group-item">해외도서</a> <!-- 90834 -->
        </div>
      </div>
      
      <!-- Content Column -->
      <div class="col-lg-10 mb-4">
      <br>
      <br>

      	<c:if test="${empty list }">
	  		검색결과 없음
	  	</c:if>
	  	<c:if test="${!empty list }">
	  		<c:forEach var="map" items="${list }">
		    	<p>
		    	${map['title'] }
		    	</p>
		    	<br>
	    	</c:forEach>
	    </c:if>
    </div>
 
</div>

</div>
  <!-- Footer -->
  <%@include file="inc/bottom.jsp" %>