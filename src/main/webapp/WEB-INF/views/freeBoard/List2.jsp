<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../inc/top.jsp"%>
<script>
function pageFunc(curPage){
	document.frmPage.currentPage.value=curPage;
	
	document.frmPage.submit();
}
</script>

<div class="container">
	<br>
	<h1>게시판</h1>
		<!-- 페이징 처리 관련 form -->
		<form action="<c:url value='/freeBoard/List.do'/>" name="frmPage"
			method="post">
			<input type="hidden" name="searchCondition"
				value="${param.searchCondition}"> <input type="hidden"
				name="searchKeyword" value="${param.searchKeyword}"> <input
				type="hidden" name="currentPage">
		</form>


			<table class="table table-striped" id="freeBoard">
				<thead>
					<tr>
						<th scope="col">#</th>
						<th scope="col">작성자</th>
						<th scope="col">제목</th>
						<th scope="col">작성일</th>
					</tr>
				</thead>
				<tbody>
					<c:if test="${empty list}">
						<td colspan="4">자유게시판에 작성된 글이 없습니다.</td>
					</c:if>

					<!-- 자유게시판 반복문 시작 -->
					<c:if test="${!empty list}">
						<c:forEach var="vo" items="${list }">
							<tr>
								<th scope="row">${vo.boardNo }</th>
								<td>${vo.name }</td>
								<td><a href="Detail.do?boardNo=${vo.boardNo }">
										${vo.title } </a></td>
								<td><fmt:formatDate value="${vo.regdate }"
										pattern="yyyy-MM-dd" /></td>
							</tr>
						</c:forEach>
					</c:if>
					<!-- 자유게시판 반복문 끝 -->
				</tbody>
			</table>
			<br>
			<div class="row justify-content-end">
				<a class="btn btn-info"
					href="${pageContext.request.contextPath}/freeBoard/chkUser.do"
					role="button">글쓰기</a>
			</div>
			<br>

			<div class="row justify-content-center" id="paging">
			<nav aria-label="Page navigation example">
				<ul class="pagination">

					<!-- 이전블럭으로 이동 -->
					<c:if test="${pagingInfo.firstPage>1 }">
							<li class="page-item">
							<a class="page-link" href="#"
								onclick="pageFunc(${pagingInfo.firstPage-1})"
								aria-label="Previous">&laquo;<span
								class="sr-only">Previous</span>
							</a>
							</li>
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
							<li class="page-item">
							<a class="page-link" href="#"
								onclick="pageFunc(${pagingInfo.lastPage+1})" aria-label="Next">
								&raquo; <span class="sr-only">Next</span>
							</a>
							</li>
						</c:if>
				</ul>
	</nav>
			</div>
		</div>

<!-- Navbar Search -->
<div class="container">
	<form name="frmSearch" method="post"
		action='<c:url value="/freeBoard/List.do"/>'>
		<div class="form-row justify-content-around">
			<div class="col-mb4">

				<select name="searchCondition" class="form-control">
					<option value="title"
						<c:if test="${param.searchCondition=='title' }">
            		selected="selected"
            	</c:if>>제목</option>
					<option value="content"
						<c:if test="${param.searchCondition=='content' }">
            		selected="selected"
            	</c:if>>내용</option>
					<option value="name"
						<c:if test="${param.searchCondition=='name' }">
            		selected="selected"
            	</c:if>>작성자</option>
				</select>
			</div>

			<div class="col">
				<div class="input-group">
					<input type="text" class="form-control" name="searchKeyword"
						title="검색어 입력" value="${param.searchKeyword}">
					<div class="input-group-append">
						<input type="submit" class="btn btn-primary" value="검색">
					</div>
				</div>
			</div>
		</div>

	</form>
</div>
<!-- 컬럼 -->

<br>
<%@include file="../inc/bottom.jsp"%>