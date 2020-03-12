<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../../inc/top.jsp"%>
<%@include file="../includeMy.jsp" %>

<style type="text/css">
	.table td, .table th{
		text-align: center;
	}
	
	td:nth-of-type(odd) {
		background-color: #e9ecef45;
	}
</style>
<script>
$(function(){		
	$("form[name=frm1]").submit(function(){
		if($("#startDay").val().length<1){
			alert("시작일을 입력하세요");
			$("#startDay").focus();
			event.preventDefault();
		}else if($("#endDay").val().length<1){
			alert("종료일을 입력하세요");
			$("#endDay").focus();
			event.preventDefault();
		}
	});
		
});

function pageFunc(curPage){
	$("input[name=currentPage]").val(curPage);
	$("form[name=frmPage]").submit();
}
</script>

<div class="col">
	<h1>마일리지</h1>
	<table style="border: 1px solid #bcbcbc;width: 100%;" class="mb-3">
		<tr>
			<td>
			<p style="margin:20px;">
			[도움말]<br>
<br> ▶ 주문하신 상품의 구매가 확정된 후, 마일리지가 누적됩니다.
<br> ▶ 마일리지는 누적일로부터 12개월 이후 소멸됩니다.
<br> ▶ 마일리지 포인트는 현금성 결제수단으로 10원 이상이면 결제 시 사용가능합니다.
<br> ▶ 마일리지는 현금으로 환급받을 수 없습니다.
			</p>
			</td>
		</tr>
	</table>
	<!-- 페이징 처리 관련 form -->
	<form action="<c:url value='/mypage/Mileage/Mileage.do'/>" name="frmPage"
		method="post">
		<input type="hidden" name="startDay" value="${dateSearchVO.startDay }">
	<input type="hidden" name="endDay" value="${dateSearchVO.endDay }">
	<input type="hidden" name="currentPage">
	</form>
	
	<form name="frm1" method="post"
		action="<c:url value='/mypage/Mileage/Mileage.do'/>">
		<!-- 조회기간 include -->
		<%@include file="dateTerm.jsp"%>

		<input type="submit" value="조회">
	</form>
	<br>

	<table class="table" id="mileageList">
		<thead class="thead-light">
			<tr>
				<th scope="col">변동일</th>
				<th scope="col">적립 포인트</th>
				<th scope="col">결제 번호</th>
				<th scope="col">차감 포인트</th>
				<th scope="col">만료일 </th>
				<th scope="col">변동사유</th>
			</tr>
		</thead>
		<tbody>
			<c:if test="${empty list}">
				<tr><td class="text-center align-middle" colspan="6">
				<div>마일리지 조회 결과가 없습니다</div>
							<img alt="coin" src="<c:url value='/resources/images/icons/coin.png'/>" height="300px;">
				
				</td></tr>
			</c:if>

			<!-- 자유게시판 반복문 시작 -->
			<c:if test="${!empty list}">
				<c:forEach var="vo" items="${list }">

					<tr>
						<td><fmt:formatDate value="${vo.savingDate }"
								pattern="yyyy-MM-dd" /></td>
						<td>${vo.savingPoint }</td>
						<td>${vo.payNo }</td>
						<td>${vo.usePoint }</td>
						<td><fmt:formatDate value="${vo.endDate }"
								pattern="yyyy-MM-dd" /></td>
						<td>${fn:replace(vo.reason,'set','') }</td>
					</tr>
				</c:forEach>
			</c:if>
			<!-- 자유게시판 반복문 끝 -->
		</tbody>
	</table>

	<br>
	
	<div class="text-right">
	<span>보유한 마일리지 총액 : </span>
	<span style="color:orange;font-weight:bold;font-size:3em;"><fmt:formatNumber value="${vo.mileage }" pattern="#,###"/>P</span>
	</div>
	<br>
	<div class="row justify-content-center" id="paging">
		<nav aria-label="Page navigation example">
			<ul class="pagination">

				<!-- 이전블럭으로 이동 -->
				<c:if test="${pagingInfo.firstPage>1 }">
					<li class="page-item"><a class="page-link" href="#"
						onclick="pageFunc(${pagingInfo.firstPage-1})"
						aria-label="Previous">&laquo;<span class="sr-only">Previous</span>
					</a></li>
				</c:if>


				<!-- 페이지 번호 추가 -->
				<!-- bootstrap pagination -->
				<c:forEach var="i" begin="${pagingInfo.firstPage }"
					end="${pagingInfo.lastPage }">
					<c:if test="${i==pagingInfo.currentPage }">
						<li class="page-item active"><a class="page-link" href="#">${i}<span
								class="sr-only">(current)</span></a></li>
					</c:if>
					<c:if test="${i!=pagingInfo.currentPage }">
						<li class="page-item"><a class="page-link" href="#"
							onclick="pageFunc(${i})"> ${i}</a></li>
					</c:if>
				</c:forEach>
				<!--  페이지 번호 끝 -->

				<!-- 다음블럭으로 이동 -->
				<c:if test="${pagingInfo.lastPage<pagingInfo.totalPage }">
					<li class="page-item"><a class="page-link" href="#"
						onclick="pageFunc(${pagingInfo.lastPage+1})" aria-label="Next">
							&raquo; <span class="sr-only">Next</span>
					</a></li>
				</c:if>
			</ul>
		</nav>
	</div>
</div>

<br>
</div>
</div>
<%@include file="../../inc/bottom.jsp"%>