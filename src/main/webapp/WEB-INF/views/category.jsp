<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="inc/top.jsp" %>
<style>
.btn-blog {
    color: #ffffff;
    background-color: #37d980;
    border-color: #37d980;
    border-radius:0;
    margin-bottom:10px;
    margin-top:10px;
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
 .margin10{margin-bottom:10px; margin-right:10px;
 }
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
			<c:import url="/inc/categoryBar.do"></c:import>	
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