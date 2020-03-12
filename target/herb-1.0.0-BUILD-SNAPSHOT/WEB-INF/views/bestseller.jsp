<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>	

<c:forEach var="map" items="${list }">
<div class="col-lg-3 col-sm-6 portfolio-item">
        <div class="card">
          <a href='<c:url value="/book/bookDetail.do?ItemId=${map['isbn13'] }"/>'>
          <img class="card-img-top" src="${map['cover'] }" alt="bookcover"></a>
        	<div class="card-body">
        	<p style="font-family:'Black Han Sans', sans-serif; font-size:2em; font-style: italic; color: #d3d3d3;">
${map['bestRank'] }
</p>
	            <p class="card-title">
	              <a href='<c:url value="/book/bookDetail.do?ItemId=${map['isbn13'] }"/>'>
	              <!-- 제목이 긴 경우 일부만 보여주기-->
	              <c:set var="bookname" value="${map['title'] }" />
							<c:if test="${fn:length(bookname)>25}">
								${fn:substring(bookname, 0,25)}...
							</c:if>
							<c:if test="${fn:length(bookname)<=25}">
								${map['title'] }
							</c:if>	
	              </a>
	            </p>
 
	         </div>
        </div>
      </div>

</c:forEach>