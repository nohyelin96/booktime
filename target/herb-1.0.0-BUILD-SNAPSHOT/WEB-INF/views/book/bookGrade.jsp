<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<style type="text/css">
	img.star{
		width: 25px;
	}
	.bk-grade *{
		vertical-align: bottom;
	}
</style>
<script type="text/javascript">
	$(function(){
		$("#toReview").click(function(){
			var position = $("#review").offset().top;
			$("*").not(".cmt").animate({
				scrollTop: position
			},500);
		});
	})
</script>
<fmt:parseNumber var="end" value="${grade}" integerOnly="true"/>


<div class="bk-grade text-right">
	<c:if test="${end>0 }">
		<c:forEach var="i" begin="1" end="${end }">
			<img class="star" alt="star" src='<c:url value="/resources/images/icons/starFull.png"/>'>
		</c:forEach>
		
		<c:if test="${((grade*10)/5)%2!=0 }"><!-- *.5점 처리 -->
			<img class="star" alt="star" src='<c:url value="/resources/images/icons/starHalf.png"/>'>
			<c:forEach var="i" begin="1" end="${5-end-1}">
				<img class="star" alt="star" src='<c:url value="/resources/images/icons/starEmpty.png"/>'>
			</c:forEach>
		</c:if>
		
		<c:if test="${((grade*10)/5)%2==0 }"><!-- *.5점 처리 -->
			<c:forEach var="i" begin="1" end="${5-end}">
				<img class="star" alt="star" src='<c:url value="/resources/images/icons/starEmpty.png"/>'>
			</c:forEach>
		</c:if>
	</c:if>
	<c:if test="${!empty param.total }">
		<c:if test="${end>0 }">
			<b>${grade}</b>
			<b>|</b>
		</c:if>
		<a href="#" id="toReview">회원리뷰(${param.total }건)</a>
	</c:if>
</div>