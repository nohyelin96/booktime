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
	action="<c:url value='/freeBoard/Write.do'/>" >

		<div class="form-group">
			<!-- Name field -->
			<label class="control-label " for="name">작성자</label> <input
				class="form-control" id="name" name="name" type="text" value="${boardVo.name }"/>
		</div>

		<div class="form-group">
			<!-- Email field -->
			<label class="control-label" for="category">카테고리</label> 
			<select class="form-control" id="category" name="category">
				<option>자유게시판</option>
			</select>
		</div>

		<div class="form-group">
			<!-- Subject field -->
			<label class="control-label " for="title">제목</label> <input
				class="form-control" id="title" name="title" type="text" />
		</div>

		<div class="form-group">
			<!-- Message field -->
			<label class="control-label " for="content">내용</label>
			<textarea class="form-control" cols="40" id="content" name="content"
				rows="10"></textarea>
			<script>
				$(function() {

					CKEDITOR.replace('content', {//해당 이름으로 된 textarea에 에디터를 적용
						extraPlugins: 'imageresize,wordcount,notification',
						imageResize:{maxWidth:400,maxHeight:400},
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
			
		</div>

		<div class="form-group">
			<button class="btn btn-primary " name="submit" type="submit"
				id="btn_write">글 올리기</button>
			<button class="btn btn-primary " name="btn" type="button"
				id="btn_cancel">취소</button>
		</div>

	</form>
</div>
<%@include file="../inc/bottom.jsp"%>