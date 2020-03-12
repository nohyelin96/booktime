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
			}else if(attr=="cart"){
				
			}
			
		});
	});
</script>
<div class="container">
	<div class="page-header my-4 p-2"
		style="border: 2px solid lightGray;">
		<h3>즐겨찾기</h3>
		<small>당장 구입할 예정은 없지만 읽고싶은 책들을 담아두세요.</small>
	</div>
	
	<div class="table-responsive">
		<form name="frmFavorite" method="post"
					action='<c:url value="/favorite/delete.do"/>'>
					
			<table class="table" title="즐겨찾기 목록">
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
							<div class="py-2">삭제</div>
						</th>
					</tr>
				</thead>
				
				<tbody>
					<!-- 반복 시작 -->
					<tr>
						<th scope="row">
							<div class="p-2">
								<input type="checkbox" id="ck1" name="favoriteNo" val="" class="align-middle mr-3">
								<label for="ck1"><!-- 번호매기기 -->
									<img
										src="https://res.cloudinary.com/mhmd/image/upload/v1556670479/product-1_zrifhn.jpg"
										alt="" width="70" class="img-fluid rounded shadow-sm">
								</label>
								
								<div class="ml-3 d-inline-block align-middle">
									<h5 class="mb-0">
										<a href="<c:url value='/book/bookDetail.do?isbn='/>" 
											class="text-dark d-inline-block align-middle"><b>상품명</b></abbr></a>
									</h5>
									<a href="#"><small class="text-muted font-italic d-block">카테고리 : 도서</small></a>
								</div>
								
							</div>
						</th>
						<td class="align-middle text-center"><strong>79.000 원</strong></td>
						<td class="align-middle text-center"><strong>3</strong></td>
						<td class="align-middle text-center">
							<a href="#" class="text-dark"><i class="fa fa-trash"></i></a>
						</td>
					</tr>
					<!-- 반복 끝 -->
					
					<!-- dummy 삭제하기 -->
					<tr>
						<th scope="row">
							<div class="p-2">
								<input type="checkbox" id="ck2" name="favoriteNo" val="" class="align-middle mr-3">
								<label for="ck2"><!-- 번호매기기 -->
									<img
										src="https://res.cloudinary.com/mhmd/image/upload/v1556670479/product-1_zrifhn.jpg"
										alt="" width="70" class="img-fluid rounded shadow-sm">
								</label>
								
								<div class="ml-3 d-inline-block align-middle">
									<h5 class="mb-0">
										<a href="#" class="text-dark d-inline-block align-middle"><b>상품명</b></abbr></a>
									</h5>
									<a href="#"><small class="text-muted font-italic d-block">카테고리 : 도서</small></a>
								</div>
								
							</div>
						</th>
						<td class="align-middle text-center"><strong>79.000 원</strong></td>
						<td class="align-middle text-center"><strong>3</strong></td>
						<td class="align-middle text-center">
							<a href="#" class="text-dark"><i class="fa fa-trash"></i></a>
						</td>
					</tr>
					<tr>
						<th scope="row">
							<div class="p-2">
								<input type="checkbox" id="ck3" name="favoriteNo" val="" class="align-middle mr-3">
								<label for="ck3"><!-- 번호매기기 -->
									<img
										src="https://res.cloudinary.com/mhmd/image/upload/v1556670479/product-1_zrifhn.jpg"
										alt="" width="70" class="img-fluid rounded shadow-sm">
								</label>
								
								<div class="ml-3 d-inline-block align-middle">
									<h5 class="mb-0">
										<a href="#" class="text-dark d-inline-block align-middle"><b>상품명</b></abbr></a>
									</h5>
									<a href="#"><small class="text-muted font-italic d-block">카테고리 : 도서</small></a>
								</div>
								
							</div>
						</th>
						<td class="align-middle text-center"><strong>79.000 원</strong></td>
						<td class="align-middle text-center"><strong>3</strong></td>
						<td class="align-middle text-center">
							<a href="#" class="text-dark"><i class="fa fa-trash"></i></a>
						</td>
					</tr>
					
				</tbody>
			</table>
			<hr>
			
			<div class="text-center mb-5">
					<input type="button" id="selAll" value="전체선택" class="btn btn-primary">
					<input type="button" id="selOff" value="선택 해제" class="btn btn-light" style="border: 1px solid lightGray;">
					<input type="submit" value="선택한 상품 삭제" class="btn btn-light" style="border: 1px solid lightGray;">
					<input type="button" id="cart" value="선택한 상품 장바구니에 담기" class="btn btn-primary">
			</div>
			
		</form>
	</div>
</div>
<%@include file="../inc/bottom.jsp"%>