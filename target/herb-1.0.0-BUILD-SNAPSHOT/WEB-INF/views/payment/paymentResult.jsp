<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../inc/top.jsp"%>
<script type="text/javascript">
	$(function(){
		if($("#payNo").text()=="0"){
			alert("잘못된 접근 입니다.");
			history.back();
		}
	});
</script>
<div class="container mt-4">
	<div class="page-header text-center">
		<h2>구매해주셔서 감사합니다!</h2>
		<small class="text-danger">주문번호 : 
		<span id="payNo"><c:if test="${!empty sessionScope.userid }">${vo.payNo}</c:if><c:if test="${empty sessionScope.userid }">${vo.nonMember }</c:if></span>
		</small><hr class="mb-0">
	</div>
	<table class="table mb-0" title="주문 결과">
		<thead>
			<tr>
				<th scope="col" class="border-0 bg-light">
					<div class="p-2 px-3">도서정보</div>
				</th>
				<th scope="col" class="border-0 bg-light text-center">
					<div class="py-2">가격</div>
				</th>
				<th scope="col" class="border-0 bg-light text-center">
					<div class="py-2">수량</div>
				</th>
				<th scope="col" class="border-0 bg-light text-center">
					<div class="py-2">합계</div>
				</th>
			</tr>
		</thead>
		
		<tbody>
			<c:set var="sum" value="0"/>
			<c:if test="${!empty vo.details }">
				<!-- 반복 시작 -->
				<c:forEach var="i" begin="0" end="${fn:length(vo.details)-1}">
				<tr>
					<th scope="row">
						<div class="p-2">
							<label for="ck1"  style="display: initial;"><!-- 번호매기기 -->
								<img
									src="${infoList[i]['cover'] }"
									alt="${vo.details[i].bookName}" width="70" class="img-fluid rounded shadow-sm">
							</label>
							
							<div class="ml-3 d-inline-block align-middle">
								<h5 class="mb-0">
									<c:set var="bookName" value="${vo.details[i].bookName }"/>
									<c:if test="${fn:length(bookName)>30 }">
										<c:set var="bookName" value="${fn:substring(bookName, 0, 30)}<br>${fn:substring(bookName, 30,fn:length(bookName))}"/>
									</c:if>
									
									<a href="<c:url value='/book/bookDetail.do?ItemId=${vo.details[i].isbn }'/>" 
											class="text-dark d-inline-block align-middle"><b class="bookName">${bookName }</b></a>
								</h5>
								<a href="<c:url value="/book/bookList.do?cateNo=${infoList[i]['cateCode']}"/>">
										<small class="text-muted font-italic d-block">
											카테고리 : ${infoList[i]['cateName']}
										</small>
								</a>
							</div>
							
						</div>
					</th>
					<td class="align-middle text-center">
						<strong><fmt:formatNumber value="${vo.details[i].price }" pattern="#,###"/>원</strong>
					</td>
					<td class="align-middle text-center"><strong>${vo.details[i].qty }</strong></td>
					<td class="align-middle text-center">
						<strong><fmt:formatNumber value="${vo.details[i].price*vo.details[i].qty }" pattern="#,###"/> 원</strong>
						<c:set var="sum" value="${sum+(vo.details[i].price*vo.details[i].qty) }"/>
						<c:if test="${!empty sessionScope.userid }">
							<br><small class="text-danger">${infoList[i]['mileage']*vo.details[i].qty }p 적립예정</small>
						</c:if>
					</td>
				</tr>
				</c:forEach>
				<!-- 반복 끝 -->
			</c:if>
			
			<tr>
				<td colspan="3" class="text-right">
					<b>총 상품 금액 :<br>
					+ 배송비 :<br>
					<c:if test="${!empty sessionScope.userid }">
						<span class="text-danger limit">- 사용 포인트 : </span><br>
					</c:if>
					<span style="font-size: 1.5em;">총 결제 금액 :</span>
					</b>
					
				</td>
				<td class="text-center">
					<b class="text-right d-inline-block">
						<fmt:formatNumber value="${sum}" pattern="#,###"/>원<br>
						<c:if test="${sum>=30000 }">무료</c:if>
						<c:if test="${sum<30000 }">2,500원
							<c:set var="sum" value="${sum+2500}"/>
						</c:if>
						<br>
						<c:if test="${!empty sessionScope.userid }">
							<span class="text-danger"><fmt:formatNumber value="${vo.usePoint }" pattern="#,###"/>원</span><br>
						</c:if>
						<span style="font-size: 1.5em;" id="sum">
							<fmt:formatNumber value="${vo.price}" pattern="#,###"/>원
						</span>
					</b>
				</td>
			</tr>
		</tbody>
	</table>
</div>
<hr>
<div class="text-center">
	<a class="btn btn-lg btn-info" style="color: white;"
		href="<c:url value='/book/bookList.do?cateNo=${infoList[0]["cateCode"]}'/>">
		'${infoList[0]['cateName']}'더 보기
	</a>
	<a class="btn btn-lg btn-info" style="color: white;"
		href="<c:url value="/payment/paymentList.do"/>">
		주문내역으로
	</a>
</div>

<%@include file="../inc/bottom.jsp"%>