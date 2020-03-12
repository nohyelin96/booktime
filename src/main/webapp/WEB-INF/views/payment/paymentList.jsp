<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../inc/top.jsp"%>
<style type="text/css">
	.bookImg{
		min-width: 250px;
	}
	table{
		border-top: 2px solid lightGray;
		border-bottom: 2px solid lightGray;
	}
	
	table tr:nth-of-type(odd) {
		background-color: #00000005;
	}
	.paging a{
		border: 1px solid #17a2b8;
	}
</style>
<script type="text/javascript">
	var idx = null;
	function getIdx(get){
		idx = get;
	}
	
	$(function(){
		var today = new Date();
		$("#endDay").val("${dateInfo.endDay}");
		$("#startDay").val("${dateInfo.startDay}");
		
		$("form[name=frmDate]").submit(function(){
			if(!ckDateFormat($("#startDay").val())){
				alert("조회시작날짜를 입력해주세요.")
				$("#startDay").focus();
				event.preventDefault();
				return false;
			}else if(!ckDateFormat($("#endDay").val())){
				alert("조회마침날짜를 입력해주세요.")
				$("#endDay").focus();
				event.preventDefault();
				return false;
			}
		});
		
		$(window).resize(function(){
			if(window.outerWidth<=1005){
				$(".table *").css("font-size", "0.95em");
				$(".table img").css("width", "30px");
			}else{
				$(".table *").css("font-size", "");
				$(".table img").css("width", "50px");
			}
		});
		
		var temp = null;
		$(".prog a").click(function(){
			if($(this).text()=='교환/환불 신청' || $(this).text()=='환불 신청'){
				var frmData = $("form[name=frmProgress"+idx+"]").serialize();
				
				if(temp!=null){
					temp.close();
				}
				win = window.open("<c:url value='/payment/refundForm.do?"+frmData+"'/>","refund","top=100,left=300,resizable=no,location=no,width=600,height=650");
				temp = win;
				win.focus();
			}else if($(this).text()=='구매확정'){
				if(confirm("상품을 모두 받으셨습니까?\r\n구매 확정 후에는 교환 및 환불이 불가능합니다.")){
					var frm = $("form[name=frmProgress"+idx+"]");
					frm.find("input[name=progress]").val("구매확정");
					
					$.ajax({
						url : "<c:url value='/payment/dealOk.do'/>",
						data : frm.serialize(),
						type : "POST",
						dataType : "text",
						success : function(res){
							if("${sessionScope.userid}"!=null && "${sessionScope.userid}"!=''){
								alert("구매가 확정되어 마일리지가 적립되었습니다.");
							}else{
								alert("구매가 확정되었습니다. 감사합니다.");
							}
							location.reload();
						},
						error : function(xhr, status, error){
							alert("ERROR!.."+status+".."+error);
						}
					});//ajax
					
				}//if
			}
		});
		
	});
	
	function ckDateFormat(str){
		var datePattern = /^(19|20)\d{2}-(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[0-1])$/;
		return datePattern.test(str);
	}
	
	function pageFunc(curPage){
		$("input[name=currentPage]").val(curPage);
		$("form[name=frmDate]").submit();
	}
	
	
</script>

<c:if test="${!empty sessionScope.userid }">
	<%@include file="../mypage/includeMy.jsp" %>
</c:if>

<div class="container
	<c:if test="${!empty sessionScope.userid }">target col-lg-9</c:if>">
	<c:if test="${!empty sessionScope.userid }">
		<div class="page-header">
			<h2>주문내역 조회</h2>
			<small>최근 주문내역을 조회합니다.</small>
		</div>
	</c:if>

	<c:if test="${!empty sessionScope.userid }">
		<form name="frmDate" method="post" class="my-1"
			action="<c:url value='/payment/paymentList.do'/>">
			<!-- 조회기간 include -->
			<%@include file="../mypage/Mileage/dateTerm.jsp"%>
			<input type="hidden" name="currentPage" value="1">
			<input type="submit" value="조회">
		</form>
	</c:if>
	
	<table title="주문내역" class="table">
		
		<c:if test="${empty sessionScope.userid }">
			<div class="page-header my-4 p-3"
				style="border: 2px solid lightGray;">
				<h3><i class="fa fa-shopping-cart"></i> 주문내역조회</h3>
				<small>주문번호로 조회한 결과입니다.</small>
			</div>		
		</c:if>
		
		<colgroup>
			<c:if test="${empty list }">
				<col width="100%">
			</c:if>
			<c:if test="${!empty list }">
				<col width="10%">
				<col width="40%">
				<col width="10%">
				<col width="20%">
				<col width="20%">
			</c:if>
		</colgroup>
		
		<tr>
			<th scope="col" class="text-center bg-light py-1">주문번호</th>
			<c:if test="${!empty list }">
				<th scope="col" class="text-center bg-light py-1">도서정보</th>
				<th scope="col" class="text-center bg-light py-1">수량</th>
				<th scope="col" class="text-center bg-light py-1">결제금액</th>
				<th scope="col" class="text-center bg-light py-1">상태</th>
			</c:if>
		</tr>
		
		<c:if test="${empty list }">
			<tr><td class="text-center">조회할 수 있는 주문내역이 없습니다.<td></tr>
		</c:if>
		
		<c:if test="${!empty list }">
			<c:set var="idx" value="0"/>
			<c:set var="idxD" value="0"/>
			<!-- 반복시작 -->
			<c:forEach var="i" begin="0" end="${fn:length(list)-1}">
				<tr>
					<td class="text-center align-middle">
						<b>
						<c:if test="${list[i].nonMember=='0'}">
							${list[i].payNo }
						</c:if>
						<c:if test="${list[i].nonMember!='0'}">
							${list[i].nonMember }
						</c:if>
						</b><br>
						<small><fmt:formatDate value="${list[i].payDate}" 
							pattern="yyyy년 MM월 dd일"/></small>
					</td>
					
					<td class="text-left align-middle p-0">
						<c:forEach var="dVo" items="${list[i].details}">
							<c:set var="bookName" value="${dVo.bookName }"/>
							<c:if test="${fn:length(bookName)>15 }">
								<c:set var="bookName" value="${fn:substring(bookName, 0, 15) }..."/>
							</c:if>
							
							<div style="min-height: 80px;line-height: 4.8em;" class="align-middle">
								<a href="<c:url value="/book/bookDetail.do?ItemId=${dVo.isbn }"/>" class="bookImg">
									<img alt="${dVo.bookName }" src="${dList[idxD]['cover']}" width="50px;">
									${idx+1 }.${bookName}
								</a>
								<c:set var="idx" value="${idx+1}"/>
								<c:set var="idxD" value="${idxD+1}"/>
							</div>
						</c:forEach>
						
						<c:set var="idx" value="${idx-(fn:length(list[i].details))}"/>
						<c:set var="idxD" value="${idxD-(fn:length(list[i].details))}"/>
					</td>
					<td class="text-center">
						<c:forEach var="dVo" items="${list[i].details}">
							<div style="line-height: 80px;">${dVo.qty }</div>
						</c:forEach>
					</td>
					
					<td class="text-center align-middle">
						<fmt:formatNumber value="${list[i].price}" pattern="#,###"/>원
						
						<c:set var="savingPoint" value="0"/>
						<c:forEach var="dVo" items="${list[i].details}">
							<c:set var="savingPoint" value="${savingPoint+(dList[idxD]['mileage']*dVo.qty) }"/>
													
							<c:set var="idx" value="${idx+1}"/>
							<c:set var="idxD" value="${idxD+1}"/>
						</c:forEach>
						
						<c:if test="${!empty sessionScope.userid && list[i].progress=='구매확정'}">
							<c:set var="idx" value="${idx-(fn:length(list[i].details))}"/>
							<c:set var="idxD" value="${idxD-(fn:length(list[i].details))}"/>
						</c:if>
						
						<form name="frmProgress${i}" method="post" action="<c:url value="/payment/dealOk.do"/>">
							<c:if test="${!empty sessionScope.userid && savingPoint>0 
								&& list[i].progress!='환불 신청중' && list[i].progress!='환불 처리됨'
								&& list[i].progress!='구매확정'}">
								<br><small class="text-danger">
									<fmt:formatNumber value="${savingPoint }" pattern="#,###"/>점 적립예정
								</small>
								<input type="hidden" name="savingPoint" value="${savingPoint}">
							</c:if>
							<input type="hidden" name="payNo" value="${list[i].payNo}">
							<input type="hidden" name="progress" value="${list[i].progress}">
						</form>
						
					</td>
					<td class="text-center align-middle prog">
						${list[i].progress }
						<br>
						<c:if test="${list[i].progress=='결제완료' }">
							<a href="#" class="btn btn-sm btn-danger" onclick="getIdx(${i})">환불 신청</a>
						</c:if>
						<c:if test="${list[i].progress=='교환 신청중' || list[i].progress=='환불 신청중'}">
						
						</c:if>
						<c:if test="${list[i].progress=='환불 처리됨'}">
							<a href="<c:url value="/book/bookDetail.do?ItemId=${list[i].details[0].isbn}"/>"
								class="btn btn-sm btn-info mb-4">다시 보러 가기</a>
						</c:if>
						<c:if test="${list[i].progress=='배송중' || list[i].progress=='배송완료'}">
							<a href="#" class="btn btn-sm btn-danger mb-1" onclick="getIdx(${i})">교환/환불 신청</a><br>
							<a href="#" class="btn btn-sm btn-info" onclick="getIdx(${i})">구매확정</a>
						</c:if>
						
						<c:if test="${!empty sessionScope.userid && list[i].progress=='구매확정'}">
							<c:forEach var="dVo" items="${list[i].details }">
								<c:if test="${dList[idxD]['reviewed'] }">
									<a href="<c:url value="/book/bookDetail.do?ItemId=${dVo.isbn}&mode=review"/>" 
									class="btn btn-sm btn-warning mb-4">
										<i class="fa fa-arrow-left">
										${idx+1 }.리뷰보기
										</i></a>
								</c:if>
								<c:if test="${!dList[idxD]['reviewed'] }">
									<a href="<c:url value="/book/bookDetail.do?ItemId=${dVo.isbn}&mode=review"/>" 
									class="btn btn-sm btn-info mb-4">
										<i class="fa fa-arrow-left">
										${idx+1 }.리뷰쓰기
										</i></a>
								</c:if>
								
								<c:set var="idx" value="${idx+1}"/>
								<c:set var="idxD" value="${idxD+1}"/>
							</c:forEach>
						</c:if>
						<c:set var="idx" value="${idx-(fn:length(list[i].details))}"/>
					</td>
				</tr>
			</c:forEach>
			<!-- 반복끝 -->
		</c:if>
	</table>
	
	<form name="pagingFrm" method="post"
		action="<c:url value="/payment/paymentList.do"/>">
		
	</form>
	
	<div class="paging text-center">
		<c:if test="${pagingInfo.firstPage!=1 }">
			<a href="#" class="btn" onclick="pageFunc(${pagingInfo.firstPage-1})">
				<i class="text-info fa fa-angle-left"></i>
			</a>
		</c:if>
		
		<c:forEach var="i" begin="${pagingInfo.firstPage}" 
			end="${pagingInfo.lastPage}">
			<c:if test="${dateInfo.currentPage==i}">
				<div class="btn btn-info active">${i}</div>
			</c:if>
			<c:if test="${dateInfo.currentPage!=i}">
				<a href="#" class="btn btn-info" onclick="pageFunc(${i})">${i}</a>
			</c:if>
			
		</c:forEach>
		
		<c:if test="${pagingInfo.lastPage!=pagingInfo.totalPage }">
			<a href="#" class="btn" onclick="pageFunc(${pagingInfo.lastPage+1})">
				<i class="text-info fa fa-angle-right"></i>
			</a>
		</c:if>
	</div>
</div>
</div>
</div>
<%@include file="../inc/bottom.jsp"%>