<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../inc/top.jsp"%>
<script
	src="${pageContext.request.contextPath}/resources/ckeditor/ckeditor.js">
</script>

<script type="text/javascript">
	$(document).ready(function(){
		$("form[name=frmWrite]").submit(function(){
			if($("#title").val()==''){
				alert("제목을 입력하세요");
				$("#title").focus();
				event.preventDefault();
			}else if($("#name").val().length<1){
				alert("이름을 입력하세요");
				$("#name").focus();
				event.preventDefault();
			}
		});
	});
</script>

<div class="container">
	<br>
	<form name="frmWrite" method="post" 
	action="<c:url value='/freeBoard/Edit.do'/>" >
		<input class="form-control" id="boardNo" name="boardNo" type="hidden" value="${boardVo.boardNo }" />
		<div class="form-group">
			<!-- Name field -->
			<label class="control-label " for="name">작성자</label> <input
				class="form-control" id="name" name="name" type="text" value="${boardVo.name }" readonly />
		</div>


		<div class="form-group">

			<!-- category field -->
			<label class="control-label" for="category">카테고리</label> 
			<select class="form-control" id="category" name="category">
				<option value="공지">공지사항</option>
				<option value="이벤트">이벤트</option>
				<option value="자유">자유게시판</option>
			</select>
		</div>

		<div class="form-group">
			<!-- Subject field -->
			<label class="control-label " for="title">제목</label> <input
				class="form-control" id="title" name="title" type="text" value="${boardVo.title }"/>
		</div>

		<div class="form-group">
			<!-- Message field -->
			<label class="control-label " for="content">내용</label>
			<textarea class="form-control" cols="40" id="content" name="content"
				rows="10">${boardVo.content }</textarea>
			<script>
				$(function() {

					CKEDITOR.replace('content', {//해당 이름으로 된 textarea에 에디터를 적용
						width : '100%',
						height : '400px',
						filebrowserImageUploadUrl : '${pageContext.request.contextPath }/freeBoard/imageUpload.do' //여기 경로로 파일을 전달하여 업로드 시킨다.
					});

					CKEDITOR.on('dialogDefinition', function(ev) {
						var dialogName = ev.data.name;
						var dialogDefinition = ev.data.definition;

						switch (dialogName) {
						case 'image': //Image Properties dialog
							//dialogDefinition.removeContents('info');
							dialogDefinition.removeContents('Link');
							dialogDefinition.removeContents('advanced');
							break;
						}
					});

				});
			</script>

			<script type='text/javascript'>
   window.parent.CKEDITOR.tools.callFunction(callback + 
      ",'" + fileUrl + "','이미지를 업로드 하였습니다.'")
			</script>
			
		</div>

		<div class="form-group">
			<button class="btn btn-primary " name="submit" type="submit"
				id="btn_write">글 수정하기</button>
			<button class="btn btn-primary " name="btn" type="button"
				id="btn_cancel">취소</button>
		</div>

	</form>
</div>
<%@include file="../inc/bottom.jsp"%>