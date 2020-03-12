<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../inc/top.jsp" %> 
<style>
div.sticky {
  position: -webkit-sticky;
  position: sticky;
  top: 0;
}
img {
  max-width: 100%;
  height: auto;
}
</style>
<script type="text/javascript" src="https://platform-api.sharethis.com/js/sharethis.js#property=5e3d940968a5cf00125e013f&product=inline-share-buttons" async="async"></script>
<script>

</script>
<!-- Page Content -->
  <div class="container">
	<input type="hidden" id="boardNo" name="boardNo" value="${boardVo.boardNo }" />
    <!-- Page Heading/Breadcrumbs -->
    <h1 class="mt-4 mb-3">&nbsp;<span style="color:#ffb600">│</span>&nbsp;${boardVo.title }</h1>


    <div class="row">

      <!-- Post Content Column -->
      <div class="col-lg-8">
 
                <br>
 <div class="sharethis-inline-share-buttons"></div>
        <br>    
        <hr>
         <div class="row">
        <div class="col align-self-center">  
<span style="color:gray;font-size:1.5em;">작성자 : ${boardVo.name }</span>
</div>
<div class="col align-self-center">      
    <div class="text-right">   
       작성일시 :
        <fmt:formatDate value="${boardVo.regdate }" pattern="yyyy-MM-dd HH:mm:ss" /> 
	</div>
	</div>
</div>	
        <hr>
       
       
        <!-- Post Content -->
        <div class="row">
		<div class="col offset-md-1">
		${boardVo.content }
		</div>
		</div>
        <hr>

        <!-- 본인 체크하고 본인에게만 수정/삭제 보여주기 -->
        <c:if test="${boardVo.category=='자유' && boardVo.userid == chkid}">
			<a class="btn btn-info"
						href="${pageContext.request.contextPath}/freeBoard/Edit.do?boardNo=${boardVo.boardNo }"
						role="button">수정하기</a>
			<a class="btn btn-info"
						onclick="next()"
						role="button">삭제하기</a>			
		</c:if>
        
        <%@include file="reply/replyWrite.jsp" %><!-- 댓글 작성란 -->

      </div>

      <!-- Sidebar Widgets Column -->
      <div class="col-md-4">

        <!-- Search Widget 
        <div class="card mb-4">
          <h5 class="card-header">Search</h5>
          <div class="card-body">
            <div class="input-group">
              <input type="text" class="form-control" placeholder="Search for...">
              <span class="input-group-btn">
                <button class="btn btn-secondary" type="button">Go!</button>
              </span>
            </div>
          </div>
        </div>-->
<div class="sticky">
        <!-- Categories Widget -->
        <div class="card my-4">
          <h5 class="card-header">게시글</h5>
          <div class="card-body">
            <div class="row">
              <div class="col-lg-6">
                <ul class="list-unstyled mb-0">
                  <li>
                    <a href="List.do">목록으로</a>
                    
                  </li>
                </ul>
              </div>
              <!-- <div class="col-lg-6">
                <ul class="list-unstyled mb-0">
                  <li>
                    <a href="#">JavaScript</a>
                  </li>
                  <li>
                    <a href="#">CSS</a>
                  </li>
                  <li>
                    <a href="#">Tutorials</a>
                  </li>
                </ul>
              </div> -->
            </div>
          </div>
        </div>

        <!-- Side Widget -->
        <div class="card my-4">
        <img class="card-img-top" src="<c:url value='/resources/img/newBookPromotion.png'/>" alt="promotion">
          <div class="card-body">
            2월 신간 도서를 구입하고 후기를 남기면 마일리지를 드립니다!
          </div>
        </div>

      </div>
	</div>
    </div>
    <!-- /.row -->

  </div>
  <!-- /.container -->
 
 <!-- 글 삭제 모달창 --> 
<script>
function next(){
	var no=document.getElementById("boardNo").getAttribute('value');
	
	if(confirm("정말로 삭제하시겠습니까?"))
	 {
  		location.href="/booktime/freeBoard/Delete.do?boardNo="+no;
 	}
}
</script>
  
  <%@include file="../inc/bottom.jsp" %>