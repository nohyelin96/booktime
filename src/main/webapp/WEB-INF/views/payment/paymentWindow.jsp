<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>   
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>  
 
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<style type="text/css">
	.bookImg{
		min-width: 250px;
	}
	table{
		border-top: 2px solid lightGray;
		border-bottom: 2px solid lightGray;
	}
</style>
	<input type="hidden" id="mode" value="${param.mode}">
	<table title="주문내역" class="table mb-0">
			
		<colgroup>
			<c:if test="${empty vo }">
				<col width="100%">
			</c:if>
			<c:if test="${!empty vo }">
				<col width="10%">
				<col width="40%">
				<col width="10%">
				<col width="20%">
				<col width="20%">
			</c:if>
		</colgroup>
		
		<tr>
			<th scope="col" class="text-center bg-light py-1">주문번호</th>
			<c:if test="${!empty vo }">
				<th scope="col" class="text-center bg-light py-1">도서정보</th>
				<th scope="col" class="text-center bg-light py-1">수량</th>
				<th scope="col" class="text-center bg-light py-1">결제금액</th>
				<th scope="col" class="text-center bg-light py-1">상태</th>
			</c:if>
		</tr>
		
		<c:if test="${empty vo }">
			<tr><td class="text-center">조회할 수 있는 주문내역이 없습니다.<td></tr>
		</c:if>
		
		<c:if test="${!empty vo }">
			<c:set var="idx" value="0"/>
			<c:set var="idxD" value="0"/>
			
			<tr>
				<td class="text-center align-middle">
					<b>
					<c:if test="${vo.nonMember=='0'}">
						${vo.payNo }
					</c:if>
					<c:if test="${vo.nonMember!='0'}">
						${vo.nonMember }
					</c:if>
					</b><br>
					<small><fmt:formatDate value="${vo.payDate}" 
						pattern="yyyy년 MM월 dd일"/></small>
				</td>
				
				<td class="text-left align-middle p-0">
					<c:forEach var="dVo" items="${vo.details}">
						<c:set var="bookName" value="${dVo.bookName }"/>
						<c:if test="${fn:length(bookName)>15 }">
							<c:set var="bookName" value="${fn:substring(bookName, 0, 15) }..."/>
						</c:if>
						
						<div style="min-height: 80px;line-height: 4.8em;" class="align-middle">
							<c:if test="${param.mode!='mail' }">
							<a href="<c:url value="/book/bookDetail.do?ItemId=${dVo.isbn }"/>" class="bookImg">
								<img alt="${dVo.bookName }" src="${dList[idxD]['cover']}" width="50px;">
								${idx+1 }.${bookName}
							</a>
							</c:if>
							<c:if test="${param.mode=='mail' }">
								<img alt="${dVo.bookName }" src="${dList[idxD]['cover']}" width="50px;">
								${idx+1 }.${bookName}
							</c:if>
							
							<c:set var="idx" value="${idx+1}"/>
							<c:set var="idxD" value="${idxD+1}"/>
						</div>
					</c:forEach>
					
					<c:set var="idx" value="${idx-(fn:length(vo.details))}"/>
					<c:set var="idxD" value="${idxD-(fn:length(vo.details))}"/>
				</td>
				<td class="text-center">
					<c:forEach var="dVo" items="${vo.details}">
						<div style="line-height: 80px;">${dVo.qty }</div>
					</c:forEach>
				</td>
				
				<td class="text-center align-middle">
					<fmt:formatNumber value="${vo.price}" pattern="#,###"/>원
					
					<c:set var="savingPoint" value="0"/>
					<c:forEach var="dVo" items="${vo.details}">
						<c:set var="savingPoint" value="${savingPoint+(dList[idxD]['mileage']*dVo.qty) }"/>
												
						<c:set var="idx" value="${idx+1}"/>
						<c:set var="idxD" value="${idxD+1}"/>
					</c:forEach>
					
					<c:if test="${vo.progress=='구매확정'}">
						<c:set var="idx" value="${idx-(fn:length(vo.details))}"/>
						<c:set var="idxD" value="${idxD-(fn:length(vo.details))}"/>
					</c:if>
					
					<c:if test="${savingPoint>0 
						&& vo.progress!='환불 신청중' && vo.progress!='환불 처리됨'
						&& vo.progress!='구매확정'}">
						<br><small class="text-danger">
							<span class="savePoint"><fmt:formatNumber value="${savingPoint }" pattern="#,###"/></span>점 적립예정
						</small>
					</c:if>
					
				</td>
				<td class="text-center align-middle prog">
					${vo.progress }
				</td>
			</tr>
		</c:if>
	</table>
