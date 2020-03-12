<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@	taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>



<style type="text/css">
	.list-group {
	    display: -ms-flexbox;
	    display: flex;
	    -ms-flex-direction: column;
	    flex-direction: column;
	    padding-left: 10px;
	    margin-bottom: 0;
	}
</style>

<div class="sideLayout">
	<!-- 썸네일 위젯 -->
	<div class="widget sticky" style="border: 3px solid cornflowerblue" id="floatMenu">
		<!-- 원하는 내용을 입력하세요. -->
		<p class="recTitle">MD추천리스트</p>
		<p class="recInfo">
			<c:forEach var="map" items="${recommandList }" end="9">
				<a href='<c:url value="/book/bookDetail.do?ItemId=${map['isbn13'] }"/>' class="cover">
					<img src="${map['cover'] }" />
				</a> 
				<p>
					<a href='<c:url value="/book/bookDetail.do?ItemId=${map['isbn13'] }"/>' 
						class="recTitleList" >
					<c:choose>
	           			<c:when test="${fn:length(map['title']) > 10}">
	            			<c:out value="${fn:substring(map['title'],0,9)}"/>....
	           			</c:when>
	           			<c:otherwise>
	            			<c:out value="${map['title'] }"/>
	           			</c:otherwise> 
	          		</c:choose>
					</a>
				</p>
			</c:forEach>
		<p>
	</div>
	<!-- banner 이미지 -->
	<div class="sideBanner">
		<a href="<c:url value='/book/bookDetail.do?ItemId=9791190174664'/>" >
			<img src="<c:url value='/resources/images/banner/sideBanner.jpg'/>"
			class="bannerImage">
		</a>
	</div>
</div>
