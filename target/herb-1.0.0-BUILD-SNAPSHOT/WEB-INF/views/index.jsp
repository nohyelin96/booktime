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
 h2{
 font-family:'Black Han Sans', sans-serif;
 color:#00bcd5;
 }
 .margin10{margin-bottom:10px; margin-right:10px;}
 .card-title a{
 font-family:'Nanum Myeongjo', serif;
 font-weight:bold;
 color:#374047;
 }
 .card-img-top{
 	height:300px;
 }
  .card-body{
 	height:150px;
 }
 .side{
 	background-color: #f5f5f5;
 	width:70px;
 	display: inline-block;
 	height: 100%;
 	vertical-align: top;
 	transform: perspective(750px) rotateY(35deg) translateZ(-50px) translateX(-11px);
 }
 .cover{
 	transform: perspective(750px) rotateY(-35deg) translateZ(-95px) translateX(-60px);
 	max-height: 100%;
 	min-height: 100%;
 	filter: contrast(0.9);
 }
 .selBar{
    margin-bottom: 10px;
    box-shadow: black 0 0 5px;
 }
 .bg_i{
 	background-position-y: -350px;
 }
 .bg_i:hover{
 	cursor: pointer;
 }
 
 .book{
 	filter: drop-shadow(5px 5px 5px #222);
 	backdrop-filter: blur(5px);
 }
 .banner{
 	color: white;
 	font-weight: bold;
 }
 .banner:hover{
 	color: white;
 	font-weight: bold;
 }
 
 a.moveTop {
    position: fixed;
    bottom: 20px;
    right: 25px;
    color:gray;
}
</style>  
<script type="text/javascript">
	$(function(){
		$(".bg_i").click(function(){
			var link = $(this).find(".banner").attr("href");
			location.href = link;
		});
		
		if(${!empty list2 && fn:length(list2)<=4}){
			$(".bestZone").css("top", "-920px");
		}else if(${!empty list2 && fn:length(list2)<=8}){
			$(".bestZone").css("top", "-520px");
		}
	});
</script>
  
  <header style="margin-top: 5px;">

	<div id="carouselExampleIndicators" class="carousel slide"
		data-ride="carousel">
		<ol class="carousel-indicators">
		
			<c:if test="${!empty list2 }">
				<c:set var="size" value="${fn:length(list2)-1 }"/>
				<c:if test="${size>3 }">
					<c:set var="size" value="2"/>
				</c:if>
				
				<c:forEach var="i" begin="0" end="${size}">
					<li class="selBar border-0 <c:if test='${i<1}'>active</c:if>" 
					data-target="#carouselExampleIndicators" data-slide-to="${i}"></li>
				</c:forEach>
			</c:if>
		</ol>
		<div class="carousel-inner" role="listbox">
			<!-- Slide One - Set the background image for this slide in the line below -->
			<c:if test="${empty list2 }">
				<div class="carousel-item active"
						style="background-image: url('<c:url value="/resources/images/MainBanner.png"/>');background-position-y: bottom;">
					</div>
			</c:if>
			
			<c:if test="${!empty list2 }">
				<c:forEach var="i" begin="0" end="${size}">
					<div class="carousel-item bg_i <c:if test='${i==0}'>active</c:if>"
						style="background-image: url('${list2[i].cover}'); ">
						<div style="width: 100%;height:100%;position: absolute;" class="text-center book">
							<img alt="cover" src="${list2[i].cover }" class="cover"><div class="side"></div>
							
						</div>
						<div class="carousel-caption d-none d-md-block">
							<h3 style="text-shadow: black 0 0 5px;">오늘의 추천도서</h3>
							<c:set var="bookName" value="${list2[i].bookName }"/>
							
							<c:if test="${fn:contains(bookName, '-')}">
								<c:set var="bookName" value="${fn:substring(bookName,0,fn:indexOf(bookName, '-')-1)}"/>
							</c:if>
							<c:if test="${fn:length(bookName)>30 }">
								<c:set var="bookName" value="${fn:substring(bookName,0,30)}"/>
							</c:if>
							
							<p style="text-shadow: black 0 0 5px;">
							<a class="banner" id="banner${i}" 
								href="<c:url value="/book/bookDetail.do?ItemId=${list2[i].isbn}"/>">
							${bookName }</a></p>
						</div>
					</div>
				</c:forEach>
			</c:if>
			
		</div>
		<c:if test="${!empty list2 }">
			<a class="carousel-control-prev" href="#carouselExampleIndicators"
				role="button" data-slide="prev"> <span
				class="carousel-control-prev-icon" aria-hidden="true"></span> <span
				class="sr-only">Previous</span>
			</a> <a class="carousel-control-next" href="#carouselExampleIndicators"
				role="button" data-slide="next"> <span
				class="carousel-control-next-icon" aria-hidden="true"></span> <span
				class="sr-only">Next</span>
			</a>
		</c:if>
	</div>
</header>

  <!-- Page Content -->
  <div class="container" id="mainView">
  <!-- Content Row -->
    <div class="row justify-content-end">
      <!-- Sidebar Column -->
      <c:import url="/inc/categoryBar.do"></c:import>
      <c:if test="${!empty list2}">
	      <!-- Content Column -->
	      <div class="col-lg-10 mb-4">
	      <br>
	      <h2>&nbsp; <i class="fas fa-book" style="color: #d3d3d3 "></i>&nbsp; 추천도서</h2>
	      <hr style="border: thin solid;color:#00bcd5;">
	      <br>
	      <div class="row justify-content-around">
	<%@include file="recomend.jsp" %>
	    </div>
	    </div><!-- row -->
	
	    <div class="col-lg-2 mb-4">
	        <div class="list-group">
	        &nbsp;
	        </div>
	    </div>
    </c:if>

    <!-- Content Column -->
      <div class="col-lg-10 mb-4 bestZone">
      <br>
      <h2>&nbsp;<i class="fas fa-book" style="color: #d3d3d3 "></i>&nbsp; 베스트 셀러</h2>
      <hr style="border: thin solid;color:#00bcd5;">
      <br>
      <div class="row justify-content-around">  
    	<%@include file="bestseller.jsp" %>
    </div><!-- row -->
	
	</div>
	</div>
	<a href="#" class="moveTop">
					<i class="fa fa-caret-up">
					맨 위로
					</i>
				</a>
  <!-- /.container -->
</div>
  <!-- Footer -->
  <%@include file="inc/bottom.jsp" %>