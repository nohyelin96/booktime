<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../inc/top.jsp" %> 
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    
<style type="text/css">

.ss_book_box {
    margin-bottom: 10px;
    padding-bottom: 10px;
}
ul.book {
    list-style: none;
}
.button_search_cart_new {
    display: inline-block;
  /*   *zoom: 1;
    *display: inline; */
    padding: 0;
    vertical-align: middle;
    border: 1px solid;
    border-color: #c82370;
    text-align: center;
    overflow: hidden;
    text-decoration: none!important;
    cursor: pointer;
    /* -webkit-border-radius: 3px;
    -moz-border-radius: 3px; */
    border-radius: 3px;
    background: #df307f;
    margin-bottom: 5px;
    height: 32px;
    width: 60px;
    padding-top: 6px;
}
.button_search_buyitnow_new {
    display: inline-block;
    *zoom: 1;
    *display: inline;
    padding: 0;
    vertical-align: middle;
    border: 1px solid;
    border-color: #cd394d;
    text-align: center;
    overflow: hidden;
    text-decoration: none!important;
    cursor: pointer;
    -webkit-border-radius: 3px;
    -moz-border-radius: 3px;
    border-radius: 3px;
    background: #e24457;
    margin-bottom: 5px;
    height: 32px;
    width: 60px;
    padding-top: 6px;
}
.button_search_storage {
    display: inline-block;
    *zoom: 1;
    *display: inline;
    padding: 0;
    vertical-align: middle;
    border: 1px solid;
    border-color: #7ab4da;
    text-align: center;
    overflow: hidden;
    text-decoration: none!important;
    cursor: pointer;
    -webkit-border-radius: 3px;
    -moz-border-radius: 3px;
    border-radius: 3px;
    background: #FFF;
 	height: 32px;
    width: 60px;
    padding-top: 6px;
}
.br2010_subt{
	font-size: 17px;
    padding-right: 525px;
}
.ss_line4 {
    margin-bottom: 15px;
    padding-right: 290px;
    margin-top: 15px;
}
.ss_book_table{
	margin-bottom: 20px;
	width: 1000px;
}
img.img_all {
    resize: both;
    max-width: 54.5px;
    position: relative;
    top: -4px;
}
input#txtBrowse-Search-Category {
    padding: -40px -4px;
    height: 25px;
    width: 174px;
    margin-bottom: 15px;
    margin-right: 9px;
}
img#btnBrowse-Search-Category {
    position: relative;
    top: -9px;
}
img.image_circle {
    position: relative;
    top: -2px;
}

.bookBestSection {
    width: 928px;
}
.bookBestTable {
    float: left;
}
.divPage {
    margin-bottom: 10px;
    text-align: center;
    margin-top: 10px;
    margin-right: 165px;
}
.search_t_g{
	margin-top: 10px;
}
a.bk66 {
    font-size: 13.2px;
}
span.author {
    font-size: 13px;
}
td.bookBestContent {
    font-size: 13px;
}
.br2010_p2 {
	font-size:13px;
}
.book .bo3{
	font-size:16px;
}
.book li{
	font-size:13px;
}
a{
	color:black;
} 
.button_search_cart_new{
	text-decoration:none;
}
#cover{
	display: none;
	background-color: rgba(100, 100, 100, 0.3);
	width: 100%;
	height: 100%;
	position: fixed;
	z-index: 10;
}

img.img_bt_previous {
    width: 25px;
    height: 25px;
    margin-bottom: 2px;
}

img.img_bt_next {
    width: 25px;
    height: 25px;
    margin-bottom: 2px;
}

td.td_line {
    padding-bottom: 30px;
}

input[type="checkbox"] {
    box-sizing: border-box;
    margin-bottom: 202px;
}

.ss_book_list {
    /* margin-bottom: 65px; */
    margin-left: -27px;
    margin-top: -98px;
    
}

li.li_deli {
    margin-top: 14px;
}

input.button_search_cart_new.btCart {
    float: left;
    margin-right: -60px;
}

input.button_search_buyitnow_new {
    float: left;
    margin-top: 34px;
    margin-right: 0px;
}

input.button_search_storage.btFavorite {
    /* margin-top: 68px; */
    margin-right: 0px;
    margin-bottom: 95px;
}

td.td_bt {
    width: 10px;
    float: left;
    margin-left: 266px;
}

td.td_line.td_info {
    width: 398px;
    float: left;
    padding-top: 98px;
}

input.button_search_storage.btFavorite {
    font-size: 13px;
    padding-bottom: 25px;
    width: 61px;
}

input.button_search_cart_new.btCart {
    padding-bottom: 24px;
}

input.button_search_buyitnow_new {
    padding-bottom: 24px;
}

td.td_cover {
    width: 180px;
}

div#FavoriteOk {
    width: 352px;
    margin-left: 587px;
    margin-top: 230px;
}

.widget.sticky {
    width: 126px;
    float: right;
    margin-right: 93px;
    text-align: center;
    background-color:white;
}

.bookList {
    max-width: 1500px;
}

table.header_new {
    float: left;
}

p.recTitle {
    font-size: 14px;
    font-family: inherit;
    font-weight: bold;
    color: white;
    text-align: center;
    background-color: cornflowerblue;
}

.recTitleList {
    font-size: 12px;
    margin-left: 5px;
    font-family: fantasy;
    font-weight: 600;
    color:gray;
}

p {
    margin-top: 0;
    margin-bottom: 10px;
}

.mb-4, .my-4 {
    margin-bottom: 1.5rem !important;
    margin-top: 10px;
}

a.moveTop {
    position: fixed;
    bottom: 20px;
    right: 25px;
    color:gray;
    
    /* text-shadow: -1px 0 litegray, 0 1px litegray, 1px 0 litegray, 0 -1px litegray;
 	-moz-text-shadow: -1px 0 litegray, 0 1px litegray, 1px 0 litegray, 0 -1px litegray;
 	webkit-text-shadow: -1px 0 litegray 0 1px litegray, 1px 0 gray, 0 -1px gray; */
}

.sideLayout {
    float: right;
}

img.bannerImage {
    margin-top: 10px;
}

img.bottomBanner {
    margin-top: 22px;
    margin-left: 129px;
}

.bottmBannerArea{
	height: 0px;
}
</style>

<script type="text/javascript">
	$(function(){
		//
		$("thead input[type=checkbox]").click(function(){
			$("tbody input[type=checkbox]")
				.prop("checked", this.checked);
		});
		
		//제목별 검색
		$("#btnBrowse-Search-Category").click(function(){
			location.href=
				"<c:url value='/book/bookList.do?cateNo=${param.cateNo}&searchKeyword="+$("#txtBrowse-Search-Category").val()+"'/>";
		});
		
		//체크박스 전체 선택
		$(".img_all").click(function(){
			if($(".ss_book_table .checkbox").is(":checked") == false){
				$(".ss_book_table .checkbox").prop("checked", true);
			}else if($(".ss_book_table .checkbox").is(":checked") == true){
				$(".ss_book_table .checkbox").prop("checked", false);
			}
		});
		
		//개별로 장바구니에 넣기
		$(".button_search_cart_new").click(function(){
			var isbn = $(this).attr("data-isbn");
			var frm = $("input[name=isbn_data]").val(isbn);
			var p_data = {"isbn": isbn};
			
	        $.ajax({
	   	    	url:"<c:url value='/book/addBookCart.do'/>",
	        	type:"post",
	        	data:p_data,
	        	success:function(res){
	        		if(res){
	        			$("#cover").siblings().css("filter", "blur(10px)");
						$("#cover").fadeIn();
						
						$(".addResult").text("장바구니");
						$(".btn-goFavorite").attr("href"
								, "<c:url value='/favorite/cart.do'/>");
	        		}
	        	},
	        	error:function(xhr, status, error){
					alert("ERROR : "+status+", "+error);
					alert(xhr.status+"#"+xhr.response);
				}
	        	
	        }); 
	       
	    });
		
		//개별로 찜목록에 넣기
		$(".btFavorite").click(function(){
			var isbn = $(this).attr("data-isbn");
			var frm = $("input[name=isbn_data]").val(isbn);
			var p_data = {"isbn": isbn};
			
	        $.ajax({
	   	    	url:"<c:url value='/book/addBookFavo.do'/>",
	        	type:"post",
	        	data:p_data,
	        	success:function(res){
	        		if(res){
	        			$("#cover").siblings().css("filter", "blur(10px)");
						$("#cover").fadeIn();
						
						$(".addResult").text("찜 목록");
	        		}
	        	},
	        	error:function(xhr, status, error){
					alert("ERROR : "+status+", "+error);
					alert(xhr.status+"#"+xhr.response);
				}
	        	
	        }); 
	       
	    });
		
		$("#hide").click(function(){
			$("#cover").fadeOut();
			$("#cover").siblings().css("filter", "blur(0px)");
		});
		
		//체크박스 선택 후 한꺼번에 장바구니에 넣기
		$(".all_Cart").click(function(){
			var checkArray=new Array();
			
			$("input[type=checkbox]:checked").each(function(index, item){
				checkArray.push($(this).attr("data-isbn"));
			});
			
			/* alert(checkArray); */
				
			$.ajax({
		   	   	url:"<c:url value='/book/addBookAllCart.do'/>",
		       	type:"post",
		       	data:{"checkArray": checkArray},
		       	success:function(res){
		       		if(res){
		       			$("#cover").siblings().css("filter", "blur(10px)");
						$("#cover").fadeIn();
						
						$(".addResult").text("장바구니");
						$(".btn-goFavorite").attr("href"
								, "<c:url value='/favorite/cart.do'/>");
		       		}
		       	},
		       	error:function(xhr, status, error){
					/* alert("ERROR : "+status+", "+error); */
					alert("장바구니에 등록할 상품을 선택해주세요.");
				}
		    }); 	
		});
		
		//체크박스 선택 후 한꺼번에 찜목록에 넣기
		$(".all_Favorite").click(function(){
			var checkArray=new Array();
			
			$("input[type=checkbox]:checked").each(function(index, item){
				checkArray.push($(this).attr("data-isbn"));
			});
			
			//alert(checkArray);
				
			$.ajax({
		   	   	url:"<c:url value='/book/addBookAllFavo.do'/>",
		       	type:"post",
		       	data:{"checkArray": checkArray},
		       	success:function(res){
		       		if(res){
		       			$("#cover").siblings().css("filter", "blur(10px)");
						$("#cover").fadeIn();
						
						$(".addResult").text("찜 목록");
		       		}
		       	},
		       	error:function(xhr, status, error){
					/* alert("ERROR : "+status+", "+error); */
					alert("찜 목록에 등록할 상품을 선택해주세요.");
				}
		    }); 	
		});
		
		//개별 상품 바로구매
		$(".button_search_buyitnow_new").click(function(){
			var isbn = $(this).attr("data-isbn");
			var p_data = {"isbn": isbn};
			
	        $.ajax({
	   	    	url:"<c:url value='/book/directPayments.do'/>",
	        	type:"post",
	        	data:p_data,
	        	success:function(res){
	        		if(res>0){
	        			console.log("바로 구매 작동 성공");
	        			
	        			location.href=
	        				"<c:url value='/payment/paymentSheet.do'/>"
	        		}
	        	},
	        	error:function(xhr, status, error){
					alert("ERROR : "+status+", "+error);
					alert(xhr.status+"#"+xhr.response);
				}
	        	
	        }); 
	       
	    });
		
		// 기존 css에서 플로팅 배너 위치(top)값을 가져와 저장한다.
		   var floatPosition = parseInt($("div#moveTop").css('top'));
		   // 250px 이런식으로 가져오므로 여기서 숫자만 가져온다. parseInt( 값 );

		   $(window).scroll(function() {
		      // 현재 스크롤 위치를 가져온다.
		      var scrollTop = $(window).scrollTop();
		      var newPosition = scrollTop + floatPosition + "px";

		      // 애니메이션 없이 바로 따라감
		      $("div#moveTop").css('top', newPosition);

		      $("div#moveTop").stop().animate({
		         "top" : newPosition
		      }, 500);

		   }).scroll();		
	});
	
	//페이징 처리 폼 넘기기
	function pageFunc(curPage){		
		$("input[name=start]").val(curPage);
		$("form[name=frmPage]").submit();
	}
	
</script>	



<!-- 페이징 처리 관련 form -->
<form action="<c:url value='/book/bookList.do'/>" 
	name="frmPage" method="post">
	<input type="hidden" name="cateNo"
		value="${param.cateNo}">
	<input type="hidden" name="searchKeyword" 
		value="${param.searchKeyword }">
	<input type="hidden" name="author" value="${param.author }">
	<input type="hidden" name="publisher" value="${param.publisher }">
		
	<!-- 한 페이지당 게시글 수  -->
	<input type= "hidden" name="MaxResults" value="20">
	<!-- 한 블럭당 페이지 수 -->
	<input type="hidden" name="blockSize" value="10">
	<!-- 전체 개수 -->
	<input type="hidden" name="totalResults" value="${pagingInfo.totalRecord }">
	<input type="hidden" name="start" value="${pagingInfo.currentPage }">
	<input type="hidden" value="${pagingInfo.firstPage }">
	<input type="hidden" value="${pagingInfo.lastPage }">
</form>

<form name="frmData_isbn">
	<input type="hidden" name="isbn_data" value="isbn">
</form>

<div id="cover">
	<div id="FavoriteOk" class="card border-primary" >
		<div class="card-header bg-primary text-center"><b><span class="addResult"></span>에 추가했습니다</b></div>
		<div class="card-body text-center">
			<a href="<c:url value="/favorite/favorite.do"/>" 
				class="btn btn-info btn-goFavorite"><span class="addResult"></span> 확인</a>
			<a href="#" id="hide"
				class="btn btn-info">더 둘러보기</a>
		</div>
	</div>
</div>

<!-- Page Content -->
<div class="container bookList" id="container_div">

	<!-- Content Row -->
	<div class="row">

		<!-- side Bar -->	
		<c:import url="/inc/categoryBar.do"></c:import>	
	      	
    	<!-- Content Column -->
    	<div class="col-lg-10 mt-3">
	    	<div class="top_div">
				<table class="header_new" align="right" cellpadding="0" >
				    <tbody>
				    	<tr>
					        <td>
					        	<h1 class="br2010_subt">
					        		<img class="image_circle" 
					        			src="<c:url value='/resources/images/blet_rec2.gif'/>" 
					        			width="17" height="15">
					        		이 분야 신간 베스트</h1>
					        </td>
        					<td>
        						<input id="txtBrowse-Search-Category" 
        							type="text" name="searchKeyword"
        							class="br2010_fbox watermark"
        							placeholder="분야 내 제목 검색"
        							value=${param.searchKeyword }>
        					</td>
        					<td>
        						<img id="btnBrowse-Search-Category" 
        						src="//image.aladin.co.kr/img/browse/2010/bu_search.gif"
        						class="searchBt"
        						alt="검색" style="cursor: pointer;">
        					</td>
    					</tr>
					</tbody>
				</table>
				
				<!-- 신간베스트 -->
				<div class="bookBestSection">
					<c:import url="/book/bookBestList.do?cateNo=${param.cateNo }"></c:import>	
				</div>
			<!-- 테이블 -->
				<div class="ss_line5" style="padding-top: 10px;">
					<table width="100%">
						<tbody>
							<tr>
								<td height="19">
									<div class="search_t_g" style="float: left;">
										이 분야에 <strong style="color: red;">
										${pagingInfo.totalRecord }
										</strong>개의 상품이 있습니다.
									</div> 
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<div class="divPage">
					<!-- 1page로 이동 -->
					<c:if test="${pagingInfo.firstPage>1 }">
						<a href="#" onclick="pageFunc(1)">
							<i class="fas fa-angle-double-left"></i>
						</a>
					<!-- 이전블럭으로 이동 -->	
						<a href="#" onclick="pageFunc(${pagingInfo.firstPage-1})">
							<i class="fas fa-angle-left"></i>
						</a>
					</c:if>
					<!-- 페이지 번호 추가 -->						
					<!-- [1][2][3][4][5][6][7][8][9][10] -->
					<c:forEach var="i" begin="${pagingInfo.firstPage }" 
						end="${pagingInfo.lastPage }">		
						<c:if test="${i==pagingInfo.currentPage }">
							<span style="color:blue;font-weight: bold">${i}</span>
						</c:if>
						<c:if test="${i!=pagingInfo.currentPage }">
							<a href="#" onclick="pageFunc(${i})">
								[${i}]</a>
						</c:if>
					</c:forEach>
					<!--  페이지 번호 끝 -->
					
					<!-- 다음블럭으로 이동 -->
					<c:if test="${pagingInfo.lastPage<pagingInfo.totalPage }">
						<a href="#" onclick="pageFunc(${pagingInfo.lastPage+1})">	
							<i class="fas fa-angle-right"></i>
						</a>
					</c:if>	
					<!-- 마지막페이지로 이동 -->
					<c:if test="${pagingInfo.lastPage<pagingInfo.totalPage }">
						<a href="#" onclick="pageFunc(${pagingInfo.totalPage})">	
							<i class="fas fa-angle-double-right"></i>
						</a>
					</c:if>	
				</div>
				<div class="ss_line4">
					<div style="height: 21px; float: right;">
						<table>
							<tbody>
								<tr>
									<td style="padding: 0px 0px 0px 5px;">
										<img class="img_all" src="<c:url value='/resources/images/button/btn_all.jpg'/>"
										alt="체크박스 전체 선택"
										style="cursor: pointer;"></td>
	
									<td style="padding: 0px 0px 0px 5px;"><input id="btCart"
										class="all_Cart"
										type="image" alt="체크한 도서를 모두 장바구니에 담습니다."
										src="//image.aladin.co.kr/img/search/btn_basket_2.jpg"
										border="0" name="Submit.AddBookAll"></td>
									
									<c:if test="${!empty sessionScope.userid }">
										<td style="padding: 0px 0px 0px 5px;"><input type="image"
											class="all_Favorite" 
											name="submit.AddMyListAll" id="btFavorite"
											alt="체크한 상품을 찜 목록에 등록합니다."
											src="<c:url value='/resources/images/button/btn_mylist_s.jpg'/>"
											border="0"></td>
									</c:if>
								</tr>
							</tbody>
						</table>
					</div>
					<br style="clear: both;">
				</div>
	
				<!-- 책종류 테이블 -->
				<form name="bookList">
					<div class="ss_book_box">
						<table width="100%" class="ss_book_table">
							<tbody>
								<c:forEach var="i" begin="0" end="${fn:length(list)-1}" varStatus="status">
									<c:set var="map" value="${list[i] }"/>
									<tr class="tb_row" data-value="${status.count }">
										<td class="td_line checkboxLine">
											<input name="checkbox" type="checkbox" class="checkbox"
											data-isbn=${map['isbn13'] }>
										</td>
										<td class="td_line td_cover">
											<a href='<c:url value="/book/bookDetail.do?ItemId=${map['isbn13'] }"/>' id="book_a">
													<img src="${map['cover'] }" width="150" border="0" class="i_cover">
											</a>
										</td>
										<td class="td_line td_info">
											<div class="ss_book_list">
												<ul class="book">
													<li><a href=
														'<c:url value="/book/bookDetail.do?ItemId=${map['isbn13'] }"/>' 
															class="bo3" style="color:#3399FF" data-title="${map['title']}" >
															<b>${map['title'] }</b>
														</a>&nbsp;</li>
													<li id="author"><a href=
														"<c:url value='/book/bookList.do?cateNo=${param.cateNo}&
															author=${fn:substring(map["author"], 0, fn:indexOf(map["author"], "("))}
														'/>">
															${map['author'] }</a> 
															| 
														<a href=
															"<c:url value='/book/bookList.do?cateNo=${param.cateNo}&
															publisher=${map["publisher"] }'/>">
															${map['publisher'] }</a>
															| ${map['pubDate'] }</li>
													<li><span class="">
														<fmt:formatNumber value="${map['priceStandard'] }" 
															pattern="#,###"/></span>원 → <span
															class="ss_p2"><b>
															<span style="color:red; font-size:17px">
																<fmt:formatNumber value="${map['priceSales'] }" 
																pattern="#,###"/>
															</span>원</b></span>
															(<span class="ss_p">10%</span>할인), 마일리지 <span
																class="ss_p">
															<fmt:formatNumber value="${map['priceStandard']/100*5}"/>
															</span>원 
															(<span class="ss_p" style="color:red">5</span>
															% 적립)</li>
													<li class="li_deli">
														지금 <strong>택배</strong>로 주문하면 <strong>내일</strong>
														수령
													</li>		
												</ul>
											</div>
										</td>
										<td class="td_line td_bt">
											<c:if test="${empty map['stockstatus'] }">
												<!-- 재고가 있으면 -->
												<input type="button" class="button_search_cart_new btCart" 
													value="장바구니" style="font-size: 13px; color:#fff;"
													data-isbn=${map['isbn13'] }>
												
												<input type="button" class="button_search_buyitnow_new" 
													value="바로구매" style="font-size: 13px; color:#fff;"
													data-isbn=${map['isbn13'] }>
											</c:if>
											<c:if test="${!empty sessionScope.userid }">
												<input type="button" class="button_search_storage btFavorite" 
													value="찜 등록" style="color:#3399FF" 
													data-isbn=${map['isbn13'] }>
											</c:if>
											<c:if test="${!empty map['stockstatus'] }">
												<!-- 재고가 없으면 -->
												<input type="submit" class="btn col" 
													value="지금은 구매할 수 없습니다." style="width: 50%;"
													disabled="disabled">
											</c:if>
											
											<input type="hidden" class="val" name="isbn" value="${map['isbn13'] }">
										</td>					
									</tr>
								</c:forEach>
							</tbody>
								<!-- 추천 리스트 -->
								<c:import url="/book/bookRecommandList.do"></c:import>
						</table>
					</div>
				</form>
				
				<div class="divPage">
					<!-- 1page로 이동 -->
					<c:if test="${pagingInfo.firstPage>1 }">
						<a href="#" onclick="pageFunc(1)">
							<i class="fas fa-angle-double-left"></i>
						</a>
					<!-- 이전블럭으로 이동 -->	
						<a href="#" onclick="pageFunc(${pagingInfo.firstPage-1})">
							<i class="fas fa-angle-left"></i>
						</a>
					</c:if>
					<!-- 페이지 번호 추가 -->						
					<!-- [1][2][3][4][5][6][7][8][9][10] -->
					<c:forEach var="i" begin="${pagingInfo.firstPage }" 
						end="${pagingInfo.lastPage }">		
						<c:if test="${i==pagingInfo.currentPage }">
							<span style="color:blue;font-weight: bold">${i}</span>
						</c:if>
						<c:if test="${i!=pagingInfo.currentPage }">
							<a href="#" onclick="pageFunc(${i})">
								[${i}]</a>
						</c:if>
					</c:forEach>
					<!--  페이지 번호 끝 -->
					
					<!-- 다음블럭으로 이동 -->
					<c:if test="${pagingInfo.lastPage<pagingInfo.totalPage }">
						<a href="#" onclick="pageFunc(${pagingInfo.lastPage+1})">	
							<i class="fas fa-angle-right"></i>
						</a>
					</c:if>	
					<!-- 마지막페이지로 이동 -->
					<c:if test="${pagingInfo.lastPage<pagingInfo.totalPage }">
						<a href="#" onclick="pageFunc(${pagingInfo.totalPage})">	
							<i class="fas fa-angle-double-right"></i>
						</a>
					</c:if>	
				</div>
				<div class="ss_line4">
					<div style="height: 21px; float: right;">
						<table>
							<tbody>
								<tr>
									<td style="padding: 0px 0px 0px 5px;">
										<img class="img_all" src="<c:url value='/resources/images/button/btn_all.jpg'/>"
										alt="체크박스 전체 선택"
										style="cursor: pointer;"></td>
	
									<td style="padding: 0px 0px 0px 5px;"><input id="btCart"
										class="all_Cart"
										type="image" alt="체크한 도서를 모두 장바구니에 담습니다."
										src="//image.aladin.co.kr/img/search/btn_basket_2.jpg"
										border="0" name="Submit.AddBookAll"></td>
									
									<c:if test="${!empty sessionScope.userid }">
										<td style="padding: 0px 0px 0px 5px;"><input type="image"
											class="all_Favorite" 
											name="submit.AddMyListAll" id="btFavorite"
											alt="체크한 상품을 찜 목록에 등록합니다."
											src="<c:url value='/resources/images/button/btn_mylist_s.jpg'/>"
											border="0"></td>
									</c:if>
								</tr>
							</tbody>
						</table>
					</div>
					<div class="bottmBannerArea">
						<a href="<c:url value='/book/bookList.do?cateNo=2551&author=조금산'/>">
						<img src="<c:url value='/resources/images/banner/bn_event_753x100.jpg'/>"
						class="bottomBanner">
						</a>
					</div>
					<br style="clear: both;">
				</div>
				<a href="#" class="moveTop">
					<i class="fa fa-caret-up">
					맨 위로
					</i>
				</a>
			</div>
		</div>
	</div>
</div>		
<%@include file="../inc/bottom.jsp" %>