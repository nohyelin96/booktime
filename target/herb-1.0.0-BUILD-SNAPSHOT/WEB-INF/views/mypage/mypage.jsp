<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/mypage/mypage.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/mypage/mypageMain.css">
<style type="text/css">
	table{
		border-top: 2px solid lightGray;
		border-bottom: 2px solid lightGray;
	}
	
	table tr:nth-of-type(odd) {
		background-color: #00000005;
	}
	.bookImg{
		min-width: 250px;
	}
	#newOrderB{
		border-top: 3px solid gray;
	    border-bottom: 3px solid gray;
	    padding-top: 10px;
	    width: 800px;
	    height: 600px;
	    margin-bottom: 20px;
	    margin-left: 10px;
	    overflow: auto;
	}
	#newOrderB p:first-of-type {
		font-weight: bold;
		margin-left: 20px;
	}
</style>
<meta charset="UTF-8">
<%@include file="../inc/top.jsp" %>   
<%@include file="includeMy.jsp" %>

	  <!-- 주문내역 (올해 주문내역 최근 5건)-->
	  <div id="newOrder<c:if test="${!empty list }">B</c:if>">
	    <p>최근 주문내역</p>
	    <c:if test="${empty list }">
	    	<img alt="쇼핑백 이미지" src="<c:url value='/resources/images/icons/shopBag.png'/>">
		    <span>최근 주문내역이 없습니다!</span>
		    <button class="btn">추천 도서 보기 ></button>
	    </c:if>
	    
	    <c:if test="${!empty list }">
	    <table style="width: 100%;">
		    <colgroup>
					<col width="20%">
					<col width="40%">
					<col width="5%">
					<col width="10%">
					<col width="15%">
			</colgroup>
	    	<tr>
				<th scope="col" class="text-center bg-light py-1">주문번호</th>
				<th scope="col" class="text-center bg-light py-1">도서정보</th>
				<th scope="col" class="text-center bg-light py-1">수량</th>
				<th scope="col" class="text-center bg-light py-1">결제금액</th>
				<th scope="col" class="text-center bg-light py-1">상태</th>
			</tr>
	    
	    	<c:set var="idx" value="0"/>
	    	<c:forEach var="pVo" items="${list}">
	    		<tr class="text-center">
	    			<td>
	    				<b>${pVo.payNo}</b>
	    				<br><small><fmt:formatDate value="${pVo.payDate}" 
							pattern="yyyy년 MM월 dd일"/></small>
					</td>
							
					<td class="text-left align-middle p-0">
						<c:forEach var="dVo" items="${pVo.details}">
							<c:set var="bookName" value="${dVo.bookName }"/>
							<c:if test="${fn:length(bookName)>15 }">
								<c:set var="bookName" value="${fn:substring(bookName, 0, 15) }..."/>
							</c:if>
							
							<div style="min-height: 80px;line-height: 4.8em;" class="align-middle">
								<a href="<c:url value="/book/bookDetail.do?ItemId=${dVo.isbn }"/>" class="bookImg">
									<img alt="${dVo.bookName }" src="${dList[idx]['cover']}" width="50px;">
									${bookName}
								</a>
							</div>
							
						<c:set var="idx" value="${idx+1}"/>
						</c:forEach>
					</td>
					
					<td class="text-center">
						<c:forEach var="dVo" items="${pVo.details}">
							<div style="line-height: 80px;">${dVo.qty }</div>
						</c:forEach>
					</td>
					
					<td class="text-center align-middle">
						<fmt:formatNumber value="${pVo.price}" pattern="#,###"/>원
					</td>
					<td class="text-center align-middle">
						${pVo.progress}
					</td>
	    		</tr>
	    	</c:forEach>
	    </table>
	    </c:if>
	    
	  </div>
	 
	  <!-- 나의 현재 등급/마일리지 -->
	  <div id="mygroup">
		  <div id="mileage">
		  	<span><fmt:formatNumber value="${vo.mileage }" pattern="#,###"/>p</span>
		  	<p>마일리지</p>
		  </div>
	  </div>
   </div>
   </div>
<%@include file="../inc/bottom.jsp" %>