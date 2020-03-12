<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../inc/top.jsp"%>

<style type="text/css">
	*:not(#cover){
	}
	#cover{
		display: none;
	    background-color: rgba(100, 100, 100, 0.3);
	    width: 100%;
	    height: 100%;
	    position: fixed;
	    z-index: 10;
	}
	#FavoriteOk{
		width: 400px;
	    margin: 0 auto;
	    top: 25%;
	}
	#cover .card-header, #cover a{
		color: white;
		font-weight: bold;
	}
	#cover .details{
		transition-duration: 1s;
	}
	table{
		border-top: 3px solid gray;
		border-bottom: 3px solid gray;
	}
	
</style>

<script type="text/javascript">
	$(function(){
		$("input[type=button]").click(function(){
			var attr = $(this).attr("id");
			if(attr=="selAll"){
				$("input[type=checkbox]").prop("checked",true);
			}else if(attr=="selOff"){
				$("input[type=checkbox]").prop("checked",false);
			}else if(attr=="addcart"){
				var checked = $("input[type=checkbox]:checked");
				
				if(checked.length<1){
					alert("하나 이상 선택해주세요!");
					return;
				}
				
				var favoriteNo = "";
				checked.each(function(idx,item){
					favoriteNo = favoriteNo + $(this).val();
					
					if(idx!=checked.length-1){
						favoriteNo = favoriteNo+"&";
					}
				});
				
				$.ajax({
					url: "<c:url value='/favorite/moveFavorite.do'/>",
					data : {
						favoriteNoList : favoriteNo,
					},
					dataType:"text",
					type:"POST",
					success:function(res){
						$("#cover").siblings().css({"filter":"blur(10px)",
							"transition-duration": "1s"});
						$("#cover").fadeIn();
						$(".addResult").text(res);
					},
					error:function(xhr, status, error){
						alert("ERROR.."+status+".."+error);
					}
				});
			}
			
		});
		
		$("#hide").click(function(){
			$("#cover").siblings().css({"filter":"blur(0px)","transition-duration": ""});
			$("#cover").fadeOut(500);
			$("#cover").siblings().css("filter","blur(0px)");
			$("#cover").fadeOut(500,function(){
				$("#cover").siblings().css("transition-duration", "");
			});
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
		
		
	});
	
	function deleteFavorite(favoriteNo) {
		$.ajax({
			url: "<c:url value='/favorite/deleteFavorite.do'/>",
			data : {
				favoriteNoList : favoriteNo,
				group : "FAVORITE"
			},
			dataType:"text",
			type:"POST",
			success:function(res){
				alert(res+"개를 찜 목록에서 삭제하였습니다.");
				location.reload();
			},
			error:function(xhr, status, error){
				alert("ERROR.."+status+".."+error);
			}
		});
	}
</script>
<div id="cover">
	<div id="FavoriteOk" class="card border-primary" >
		<div class="card-header bg-primary text-center"><b><span class="addResult"></span>개 항목을 장바구니로 옮겼습니다.</b></div>
		<div class="card-body text-center">
			<a href="<c:url value='/favorite/cart.do'/>" 
				class="btn btn-info btn-goFavorite"><span></span>장바구니 확인</a>
			<a href="#" id="hide"
				class="btn btn-info">더 둘러보기</a>
		</div>
	</div>
</div>
<%@include file="../mypage/includeMy.jsp" %>

<div class="container favorites col-lg-9">

	<div class="table-responsive">
			<table class="table" title="찜 목록">
				<thead>
					
					<tr>
						<th scope="col" class="border-0 bg-light py-0">
							<div class="p-2"><i class="fa fa-heart"></i> <b>찜 목록</b></div>
						</th>
						<c:if test="${!empty list }">
							<th scope="col" class="border-0 bg-light text-center py-0">
								<div class="py-2">가격</div>
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
							<img alt="cart이미지" src="<c:url value='/resources/images/icons/box.png'/>" height="420px;">
							</td></tr>
					</c:if>
					
					<c:if test="${!empty list }">
						<!-- 반복 시작 -->
						<c:forEach var="i" begin="0" end="${fn:length(list)-1}">
							<tr>
								<th scope="row">
									<div class="p-2">
										<input type="checkbox" id="ck${i}" name="favoritNo" value="${list[i].favoriteNo }" class="align-middle mr-3">
										<label for="ck${i}"><!-- 번호매기기 -->
											<img
												src="${infoList[i]['cover']}"
												alt="" width="70" class="img-fluid rounded shadow-sm">
										</label>
										
										<div class="ml-3 d-inline-block align-middle">
											<h5 class="mb-0">
												<c:set var="bookName" value="${list[i].bookName }"/>
												
												<c:if test="${fn:length(bookName)>30 }">
													<c:set var="bookName" value="${fn:substring(bookName, 0, 30)}..."/>
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
									<a href="#" class="text-dark" onclick="deleteFavorite(${list[i].favoriteNo})"><i class="fa fa-trash"></i></a>
								</td>
							</tr>
						</c:forEach>
						<!-- 반복 끝 -->
					</c:if>
					
				</tbody>
			</table>
			<c:if test="${!empty list }">
				<div class="text-center mb-5">
						<input type="button" id="selAll" value="전체선택" class="btn btn-info">
						<input type="button" id="selOff" value="선택 해제" class="btn btn-light" style="border: 1px solid lightGray;">
						<input type="button" id="selDel" value="선택한 상품 삭제" class="btn btn-light" style="border: 1px solid lightGray;">
						<input type="button" id="addcart" value="선택한 상품  장바구니에 담기" class="btn btn-info">
				</div>
			</c:if>
			
	</div>
</div>

</div>
</div>

<%@include file="../inc/bottom.jsp"%>