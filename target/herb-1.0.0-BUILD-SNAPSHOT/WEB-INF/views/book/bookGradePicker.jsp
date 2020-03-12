<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style type="text/css">
	img.selStar{
		width: 30px;
		cursor: pointer;
	}
	.bk-grade *{
		/* vertical-align: bottom; */
		max-width: 20%;
	}
</style>
<script type="text/javascript">
	$(function(){
		$("img.selStar").mouseenter(function(){
			var idx = $(this).attr("alt").substring(4)-1;
			
			$("img.selStar").eq(idx).prevAll().addBack()
				.attr("src", "<c:url value='/resources/images/icons/starFull.png'/>");
			$("img.selStar").eq(idx).nextAll()
				.attr("src", "<c:url value='/resources/images/icons/starEmpty.png'/>");
			$("#selGrade").html((idx+1)+".0");
			$("#bookGrade").val((idx+1));
		});
	});
</script>
<div class="bk-grade">
	<c:forEach var="i" begin="1" end="5">
		<img class="selStar" alt="star${i}" src='<c:url value="/resources/images/icons/starFull.png"/>'>
	</c:forEach>
	<b id="selGrade">5.0</b>
	<input type="hidden" name="bookGrade" id="bookGrade" value="5">
</div>