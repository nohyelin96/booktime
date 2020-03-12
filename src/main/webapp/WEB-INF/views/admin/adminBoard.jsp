<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="inc/top.jsp" %>

        <!-- Breadcrumbs-->
        <ol class="breadcrumb">
          <li class="breadcrumb-item">
            <a href="<c:url value='/admin/adminMain.do'/>">관리 홈</a>
          </li>
          <li class="breadcrumb-item active">게시글 관리</li>
        </ol>

        <!-- DataTables Example -->
        <div class="card mb-3">
          <div class="card-header">
            <i class="fas fa-table"></i>
            게시판 목록</div>
          <div class="card-body">
            <div class="table-responsive">
              <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                <thead>
                  <tr>
                    <th>글번호</th>
                    <th>아이디</th>
                    <th>카테고리</th>
                    <th>제목</th>
                    <th>작성일</th>
                    <th>상세</th>
                    <th>삭제</th>
                  </tr>
                </thead>
                <tfoot>
                  <tr>
                    <th>글번호</th>
                    <th>아이디</th>
                    <th>카테고리</th>
                    <th>제목</th>
                    <th>작성일</th>
                    <th>상세</th>
                    <th>삭제</th>
                  </tr>
                </tfoot>
                <tbody>
                  <!-- 반복문 시작 -->
					<c:if test="${!empty list}">
						<c:forEach var="vo" items="${list }">
							<tr>
								<td>${vo.boardNo }</td>
								<td>${vo.userid }</td>
								<td>${vo.category }</td>
								<td>${vo.title }</td>
								<td><fmt:formatDate value="${vo.regdate }" pattern="yyyy-MM-dd HH:mm:ss" /></td>
					<td>
                    <a class="btn btn-info"
					href="${pageContext.request.contextPath}/freeBoard/Detail.do?boardNo=${vo.boardNo }"
					role="button">상세</a>
					</td>
					<td>
					<c:if test="${empty vo.deleteDate}">
                    <a class="btn btn-danger delete"
					role="button">
					<input type="hidden" name="boardNo" id="boardNo" value="${vo.boardNo }">
					삭제</a>
					</c:if>
					<c:if test="${!empty vo.deleteDate}">
					삭제된 글
					</c:if>
					</td>		
							</tr>
						</c:forEach>
					</c:if>
					<!-- 반복문 끝 -->
                </tbody>
              </table>
            </div>
            <div class="col text-center">
            <a class="btn btn-info"
					href="${pageContext.request.contextPath}/admin/Write.do"
					role="button">새 글 작성하기</a>
        <!--
        <a class="btn btn-info"
					href="#"
					role="button">엑셀 파일로 저장하기</a>
					-->
        </div>
          </div>
          <div class="card-footer small text-muted">마지막 업데이트 11:59 PM</div>
        </div>

      </div>
      <!-- /.container-fluid -->
      
       <!-- 글 삭제 모달창 --> 
<script>
$(function(){
	$("#dataTable tbody").on("click", ".delete", function(){
		var checkBtn = $(this);
        
        var i=checkBtn.parent();
        var no=i.find("input[name='boardNo']").val();

        //alert(no);

		if(confirm("정말로 삭제하시겠습니까?"))
		 {
	  		location.href="/booktime/admin/Delete.do?boardNo="+no;
	 	}
	});
});
</script>

     <%@ include file="inc/bottom.jsp" %>