<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />
<style type="text/css">
	.cmt{
		width: 45%;
		border: 3px solid lightGray;
		border-radius: 5px;
		margin: 0 5px;
		padding: 10px;
		height: 200px;
		overflow: auto;
	}
	.dateInfo{
		/* position: absolute;
	    bottom: 10px;
	    right: 10px; */
	    float: right;
	    color: lightGray;
	}
</style>
<script type="text/javascript">
	$(function(){
		$("form[name=reviewFrm]").submit(function(){
			if(!$("input[name=title]").val()){
				alert("제목을 입력해주세요!");
				$("input[name=title]").focus();
				return false;
			}else if($("input[name=title]").val().length>20){
				alert("제목은 20자내로 작성해주세요");
				$("input[name=title]").focus();
				return false;
			}else if($("textarea[name=content]").val().length<10){
				alert("내용을 10자이상 입력해주세요!");
				$("textarea[name=content]").focus();
				return false;
			}
		});
	});
	
	function pageFunc(idx){
		$("input[name=currentPage]").val(idx);
		
	}
</script>

<h3 id="review">회원 리뷰(${pagingInfo.totalRecord }건)</h3>
	상품을 구매하신 후 리뷰를 작성해주세요!
	<br>우수리뷰를 작성해주시는 회원분들께 마일리지 10000원을 드립니다.
	
	<c:if test="${!empty sessionScope.userid && myPaymentCount<1}">	<!-- 구입내역 없으면  -->
		<div class="my-4"></div>
	</c:if>
	
	<c:if test="${!empty sessionScope.userid && myPaymentCount>0 && myReviewCount<1}">	<!-- 구입내역 있고, 리뷰를 처음 작성할 때  -->
		<div class="card my-4">
			<h5 class="card-header">구매자 리뷰</h5>
			<div class="card-body">
			
				<form name="reviewFrm" action="<c:url value="/review/review.do"/>" 
					method="post" enctype="multipart/form-data">
					<div class="form-group row">
						<div class="col">
							<input type="text" name="title" class="form-control" placeholder="제목을 입력하세요">
						</div>
						<div class="col text-center" style="max-width: 225px;">
							<c:import url="/book/bookGradePicker.do"/>
						</div>
					</div>
					<div class="form-group">
						<div class="container">
							<div class="row">
			   					<div id="dummy" class="col text-center">
				   					<label for="imgInput" style="line-height: 150px;">
				   						<img id="image_section" alt="미리보기" style="width: 150px;height: 150px;display:none;"/>
				   						<span>이미지 업로드</span>
				   					</label>
			   					</div>
			   					<div class="col" style="padding-right: 0;">
									<textarea placeholder="내용을 입력하세요" name="content" style="width: 100%;height: 160px;" translate="no" class=" form-control"></textarea>
								</div>
							</div>
						</div>
						<input type='file' id="imgInput" name="upImage" style="visibility: hidden;"
							accept="image/*"/>
					</div>
					<input type="submit" value="등록" class="btn btn-info">
					
					<input type="hidden" name="isbn" value="${param.ItemId }">
					<input type="hidden" name="category" value="${param.ItemId }">
					<input type="hidden" name="currentPage" value="${pagingInfo.currentPage }">
				</form>
			</div>
		</div>
	</c:if>
	<c:if test="${!empty list }">
		<div class="ml-2 my-2">
			<c:if test='${empty param.searchCondition || param.searchCondition=="newer" }'>
				<span class="btn btn-primary btn-sm active">최신순</span>
			</c:if>
			<c:if test='${!empty param.searchCondition && param.searchCondition!="newer" }'>
				<a href="<c:url value='/book/bookDetail.do?ItemId=${param.ItemId}&mode=paging&searchCondition=newer'/>" class="btn btn-primary btn-sm">최신순</a>
			</c:if>
			| 
			<c:if test='${param.searchCondition=="older" }'>
				<span class="btn btn-primary btn-sm active">오래된순</span>
			</c:if>
			<c:if test='${empty param.searchCondition || param.searchCondition!="older" }'>
				<a href="<c:url value='/book/bookDetail.do?ItemId=${param.ItemId}&mode=paging&searchCondition=older'/>" class="btn btn-primary btn-sm">오래된순</a><br>
			</c:if>
		</div>
	</c:if>
	<div class="container" >
		<c:if test="${empty list }">
			<div class="media cmt" style="width: 100%;line-height: 10em;">
				<div class="media-body text-center align-middle">
					등록된 리뷰가 아직 없습니다.
				</div>
			</div>
		</c:if>
				
		<c:if test="${!empty list }">
		<!-- 반복 시작 -->
			<c:forEach var="i" begin="0" end="${fn:length(list)-1}" step="2">
				<div class="row zone" style="margin-bottom: 10px;">
					
					<!-- row 1개당 2개씩 -->
					<c:if test="${empty list[i+1]}">
						<c:set var="idx" value="${i}"/>
					</c:if>
					<c:if test="${!empty list[i+1]}">
						<c:set var="idx" value="${i+1}"/>
					</c:if>
					
					<c:forEach var="v" begin="${i}" end="${idx}">
						<div class="media col cmt">
							<c:if test="${empty list[v].filename }">
								<img class="d-flex mr-3 " src="<c:url value='/resources/images/bookTimeSquare.png'/>" alt="review" width="150px" height="150px">
							</c:if>
							<c:if test="${!empty list[v].filename }">
								<img class="d-flex mr-3 " src="<c:url value='/resources/img/reviewImg/${list[v].filename}'/>" alt="review" width="150px" height="150px">
							</c:if>
							<div class="media-body" style="height: 95%;">
								<h5 class="mt-0">${list[v].title}</h5>
								<div style="position: absolute;top: 165px;left: 10px;">
									<c:import url="/book/bookGrade.do?userid=${list[v].userid}"></c:import>
								</div>
								<small>작성자 : ${list[v].name}</small><br>
								<%pageContext.setAttribute("enter", "\r\n");%>
								<c:set var="content" value="${fn:replace(list[v].content, enter, '<br>')}"/>
								<div style="margin-bottom: 10px;min-height: 90px;">${content }</div>
								<div class="dateInfo text-right">
									<small>
										<fmt:formatDate value="${list[v].regdate }" pattern="yyyy년 MM월 dd일"/>
										<fmt:formatDate value="${list[v].regdate }" pattern="a hh시 mm분"/>
									</small>
								</div>
							</div>
						</div>
					</c:forEach>
		
				</div>
			</c:forEach>
		<!-- 반복 끝-->
			
		<!-- 페이징 -->
		<div class="paging text-center">
		<c:if test="${pagingInfo.firstPage!=1 }">
			<a href='<c:url value="/book/bookDetail.do?currentPage=${pagingInfo.firstPage-1}&ItemId=${param.ItemId}&mode=paging&searchCondition=${param.searchCondition }"/>' 
				class="btn" >
				<i class="text-info fa fa-angle-left"></i>
			</a>
		</c:if>
		
		<c:forEach var="i" begin="${pagingInfo.firstPage}" 
			end="${pagingInfo.lastPage}">
			<c:if test="${pagingInfo.currentPage==i}">
				<div class="btn btn-info active">${i}</div>
			</c:if>
			<c:if test="${pagingInfo.currentPage!=i}">
 				<a href="<c:url value='/book/bookDetail.do?currentPage=${i}&ItemId=${param.ItemId}&mode=paging&searchCondition=${param.searchCondition }'/>" class="btn btn-info">${i}</a>
			</c:if>
			
		</c:forEach>
		
		<c:if test="${pagingInfo.lastPage!=pagingInfo.totalPage }">
			<a href='<c:url value="/book/bookDetail.do?currentPage=${pagingInfo.lastPage+1}&ItemId=${param.ItemId}&mode=paging&searchCondition=${param.searchCondition }"/>'
				class="btn">
				<i class="text-info fa fa-angle-right"></i>
			</a>
		</c:if>
	</div>
		
		</c:if>
	</div>