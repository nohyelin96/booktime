<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../inc/top.jsp"%>
<script type="text/javascript">
	$(function(){
		$("input[type=button]").click(function(){
			var attr = $(this).attr("id");
			if(attr=="selAll"){
				$("input[type=checkbox]").prop("checked",true);
			}else if(attr=="selOff"){
				$("input[type=checkbox]").prop("checked",false);
			}
			
		});
		
		$("#selDel").click(function(){
			var checked = $("input[type=checkbox]:checked");

			var favoriteNo = "";
			checked.each(function(idx,item){
				favoriteNo = favoriteNo + $(this).val();
				
				if(idx!=checked.length-1){
					favoriteNo = favoriteNo+"&";
				}
			});
			
			deleteFavorite(favoriteNo);
			
			
		});
		
		$("#selPayment").click(function(){
			if($("input[type=checkbox]:checked").length<1){
				alert("하나 이상 상품을 선택해주세요!");
				return;
			}
			
			$(".editOnly").val("0");
			$("input[type=checkbox]").not(":checked").val("0");
			
			$("form[name=frmQty]")
			.attr("action", "<c:url value='/payment/paymentSheetSend.do'/>").submit();
		});
		
		$("#allPayment").click(function(){
			
			$("form[name=frmQty]")
			.attr("action", "<c:url value='/payment/paymentSheet.do'/>").submit();
		});
		
	});
	
	function deleteFavorite(favoriteNo) {
		$.ajax({
			url: "<c:url value='/favorite/deleteFavorite.do'/>",
			data : {
				favoriteNoList : favoriteNo,
				group : "CART"
			},
			dataType:"text",
			type:"POST",
			success:function(res){
				alert(res+"개를 장바구니에서 삭제하였습니다.");
				location.reload();
			},
			error:function(xhr, status, error){
				alert("ERROR.."+status+".."+error);
			}
		});
	}
</script>
<style type="text/css">
	table{
		border-top: 3px solid gray;
		border-bottom: 3px solid gray;
	}
	td img{
		filter: invert(0.3);
	}
</style>
<c:if test="${!empty sessionScope.userid }">
	<%@include file="../mypage/includeMy.jsp" %>
</c:if>

<div class="container 
	<c:if test="${!empty sessionScope.userid }">col-lg-9</c:if>">
	
	<div class="table-responsive">
			<c:if test="${empty sessionScope.userid }">
				<div class="page-header my-4 p-3"
					style="border: 2px solid lightGray;">
					<h3><i class="fa fa-shopping-cart"></i> 장바구니</h3>
					<small>로그인하거나 브라우저 종료시 장바구니 내역이 사라집니다.</small>
				</div>		
			</c:if>
					
			<table class="table" title="즐겨찾기 목록">
				<thead>
					<tr>
						<th scope="col" class="border-0 bg-light py-0">
							<div class="p-2">
							<c:if test="${!empty sessionScope.userid }">
								<i class="fa fa-shopping-cart"></i> <b>장바구니</b>
								(30일간 보관됩니다)
							</c:if>
							<c:if test="${empty sessionScope.userid }">
								도서정보
							</c:if>
							
							</div>
						</th>
						<c:if test="${!empty list }">
							<th scope="col" class="border-0 bg-light text-center py-0">
								<div class="py-2">가격</div>
							</th>
							<th scope="col" class="border-0 bg-light text-center py-0">
								<div class="py-2">수량</div>
							</th>
							<th scope="col" class="border-0 bg-light text-center py-0">
								<div class="py-2">합계</div>
							</th>
							<th scope="col" class="border-0 bg-light text-center py-0">
								<div class="py-2">삭제</div>
							</th>
						</c:if>
					</tr>
				</thead>
				
				<tbody>
					<c:if test="${empty list }">
						<tr><td class="text-center align-middle">
							<img alt="cart이미지" src="<c:url value='/resources/images/icons/cart.png'/>" height="395px;">
							</td></tr>
					</c:if>
					<c:if test="${!empty list }">
<form name="frmQty" method="post"
		action="<c:url value='/favorite/updateCart.do'/>">
						<!-- 반복 시작 -->
						<c:forEach var="i" begin="0" end="${fn:length(list)-1}">
							<tr>
								<th scope="row">
									<div class="p-2">
										<input type="checkbox" id="ck${i}" name="voList[${i}].favoriteNo" value="${list[i].favoriteNo }" class="align-middle mr-3">
										<input type="hidden" name="voList[${i }].group" value="${list[i].group }">
										<input type="hidden" name="voList[${i }].isbn" value="${list[i].isbn }">
										<input type="hidden" name="voList[${i }].bookName" value="${list[i].bookName }">
										<input type="hidden" name="voList[${i }].price" value="${list[i].price }">
										
										<label for="ck${i}"><!-- 번호매기기 -->
											<img
												src="${infoList[i]['cover']}"
												alt="${list[i].bookName}" width="70" class="img-fluid rounded shadow-sm">
										</label>
										
										<div class="ml-3 d-inline-block align-middle">
											<h5 class="mb-0">
												<c:set var="bookName" value="${list[i].bookName }"/>
												
												<c:if test="${fn:length(bookName)>15 }">
													<c:set var="bookName" value="${fn:substring(bookName, 0, 15)}..."/>
												</c:if>
												<a href="<c:url value='/book/bookDetail.do?ItemId=${list[i].isbn }'/>" 
													class="text-dark d-inline-block align-middle"><b>${bookName }</b></a>
											</h5>
											<a href='<c:url value="/book/bookList.do?cateNo=${infoList[i]['cateCode']}"/>'>
												<small class="text-muted font-italic d-block">
													카테고리 : ${infoList[i]['cateName']}
												</small>
											</a>
										</div>
										
									</div>
								</th>
								<td class="align-middle text-center">
									<strong>
										<fmt:formatNumber value="${list[i].price}"
											pattern="#,###"/>원
									</strong>
								</td>
								
								<td class="align-middle text-center">
									
										<input type="hidden" name="voList[${i}].favoriteNo" class="editOnly" value="${list[i].favoriteNo }">
										<div class="input-group">
											<input type="number" min="1" name="voList[${i}].qty"
												value="${list[i].qty }" class="text-right" style="width: 50px;">
											&nbsp;<input type="submit" value="수정" class="btn btn-info btn-sm">
										</div>
								</td>
								
								<td class="align-middle text-center">
									<strong>
										<fmt:formatNumber value="${list[i].price*list[i].qty}"
											pattern="#,###"/>원
									</strong>
								</td>
								<td class="align-middle text-center">
									<a href="#" class="text-dark" onclick="deleteFavorite(${list[i].favoriteNo})"><i class="fa fa-trash"></i></a>
								</td>
							</tr>
						</c:forEach>
</form>
						<!-- 반복 끝 -->
					</c:if>
					
				</tbody>
			</table>
			<c:if test="${!empty list }">	
				<div class="text-center mb-5">
						<input type="button" id="selAll" value="전체선택" class="btn btn-info">
						<input type="button" id="selOff" value="선택 해제" class="btn btn-light" style="border: 1px solid lightGray;">
						<input type="button" id="selDel" value="선택한 상품 삭제" class="btn btn-light" style="border: 1px solid lightGray;">
						<input type="button" id="selPayment" value="선택한 상품  구매하기" class="btn btn-info">
						<input type="button" id="allPayment" value="상품  구매하기" class="btn btn-danger">
				</div>
			</c:if>
	</div>
</div>

</div>
</div>
<%@include file="../inc/bottom.jsp"%>