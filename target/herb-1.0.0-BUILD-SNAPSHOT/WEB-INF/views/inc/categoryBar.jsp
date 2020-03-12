<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="col-lg-2 mb-4 mt-4">
	<div class="list-group">
		<c:forEach var="bookCategoryVo" items="${list }">
			<a href=
			"<c:url value='/book/bookList.do?cateNo=${bookCategoryVo.cateCode }'/>" 
			class="list-group-item">${bookCategoryVo.cateName }</a> 
		</c:forEach>
	</div>
</div>
