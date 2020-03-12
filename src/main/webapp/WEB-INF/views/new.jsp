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
	            <p class="card-title">
	              <a href='<c:url value="/book/bookDetail.do?ItemId=${map['isbn13'] }"/>'>
	              ${map['title'] }
	              </a>
	            </p>
	           
	            <p class="card-text">
	            ${fn:substring(map["author"], 0, fn:indexOf(map["author"], "("))}
					지음 | ${MAP['publisher'] } <br> <span style="color: red;">
						${map['priceSales'] }</span>원 (<span style="color: red">10</span>% 할인)/ <img
						class="wonImage" src='<c:url value="/resources/images/m.gif"/>'
						align="absmiddle">
					<fmt:formatNumber value="${map['priceStandard']/100*5}" />
					원
	            </p>
	             
	         </div>
        </div>
      </div>

</c:forEach>