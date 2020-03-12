<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="inc/top.jsp"%>

<script>
	var j_ctxPath = "/booktime";

	$(function() {
		$("#btAdd").click(function() {
			window.open(j_ctxPath+ "/admin/adminRecomand.do",
						"recomand",
						"width=700,height=800,left=0,top=0,location=yes,resizable=yes");
						});

		$("#checkbox0").click(function() {
			//만약 전체 선택 체크박스가 체크된상태일경우
			if ($("#checkbox0").prop("checked")) {
				//해당화면에 전체 checkbox들을 체크해준다
				$("input[type=checkbox]").prop("checked", true);
				// 전체선택 체크박스가 해제된 경우
			} else {
				//해당화면에 모든 checkbox들의 체크를해제시킨다.
				$("input[type=checkbox]").prop("checked", false);
			}
		});
		
		$("#bt_delete").click(function(){
			var checked = $("input[type=checkbox]:checked");
			if(checked.length<1){
				alert("선택된 항목이 없습니다.");
				return;
			}

			var recombookNo = "";
			checked.each(function(idx,item){
				recombookNo = recombookNo + $(this).val();
				
				if(idx!=checked.length-1){
					recombookNo = recombookNo+"&";
				}
			});
			
			deleteRecommend(recombookNo);
	
		});
		
		$(".bt_detail").click(function(){
			var checkBtn = $(this);
	          
	        var i=checkBtn.parent();
	        var isbn=i.find("input[name='detail']").val();
	          
	        //alert(isbn);
	        location.href="/booktime/book/bookDetail.do?ItemId="+isbn;
		});

	});

	function deleteRecommend(recombookNo) {
		$.ajax({
			url: "<c:url value='/admin/deleteRecommend.do'/>",
			data : {
				recombookNoList :  recombookNo,
			},
			dataType:"text",
			type:"POST",
			success:function(res){
				alert("추천도서를 삭제하였습니다.");
				location.reload();
			},
			error:function(xhr, status, error){
				alert("ERROR.."+status+".."+error);
			}
		});
	}
</script>

<style>
body {
	margin: 0;
	font-size: 0.88rem;
	font-weight: 400;
	line-height: 1.5;
	color: #495057;
	text-align: left;
}

i {
	font-style: italic
}

img {
	margin-right: 50px;
}

.container {
	margin-top: 100px
}

.card {
	box-shadow: 0 0.46875rem 2.1875rem rgba(4, 9, 20, 0.03), 0 0.9375rem
		1.40625rem rgba(4, 9, 20, 0.03), 0 0.25rem 0.53125rem
		rgba(4, 9, 20, 0.05), 0 0.125rem 0.1875rem rgba(4, 9, 20, 0.03);
	border-width: 0;
	transition: all .2s
}

.card-header:first-child {
	border-radius: calc(0.25rem - 1px) calc(0.25rem - 1px) 0 0
}

.card-header {
	display: flex;
	align-items: center;
	border-bottom-width: 1px;
	padding-top: 0;
	padding-bottom: 0;
	padding-right: 0.625rem;
	height: 3.5rem;
	background-color: #fff
}

.widget-subheading {
	color: #858a8e;
}

.card-header.card-header-tab .card-header-title {
	display: flex;
	align-items: center;
	white-space: nowrap
}

.card-header .header-icon {
	font-size: 1.65rem;
	margin-right: 0.625rem
}

.card-header.card-header-tab .card-header-title {
	display: flex;
	align-items: center;
	white-space: nowrap
}

.btn-actions-pane-right {
	margin-left: auto;
	white-space: nowrap
}

.text-capitalize {
	text-transform: capitalize !important
}

.scroll-area-sm {
	height: 288px;
	overflow-x: hidden
}

.list-group-item {
	position: relative;
	display: block;
	padding: 0.75rem 1.25rem;
	margin-bottom: -1px;
	background-color: #fff;
	border: 1px solid rgba(0, 0, 0, 0.125)
}

.list-group {
	display: flex;
	flex-direction: column;
	padding-left: 0;
	margin-bottom: 0
}

.todo-indicator {
	position: absolute;
	width: 4px;
	height: 60%;
	border-radius: 0.3rem;
	left: 0.625rem;
	top: 20%;
	opacity: .6;
	transition: opacity .2s
}

.bg-warning {
	background-color: #f7b924 !important
}

.widget-content {
	padding: 1rem;
	flex-direction: row;
	align-items: center
}

.widget-content .widget-content-wrapper {
	display: flex;
	flex: 1;
	position: relative;
	align-items: center
}

.widget-content .widget-content-right.widget-content-actions {
	visibility: hidden;
	opacity: 0;
	transition: opacity .2s
}

.widget-content .widget-content-right {
	margin-left: auto
}

.btn:not(:disabled):not(.disabled){
	cursor:pointer
}
.btn {
	position: relative;
	transition: color 0.15s, background-color 0.15s, border-color 0.15s,
		box-shadow 0.15s
}

.btn-outline-success {
	color: #3ac47d;
	border-color: #3ac47d
}

.btn-outline-success:hover {
	color: #fff;
	background-color: #3ac47d;
	border-color: #3ac47d
}

.btn-outline-success:hover {
	color: #fff;
	background-color: #3ac47d;
	border-color: #3ac47d
}

.btn-primary {
	color: #fff;
	background-color: #3f6ad8;
	border-color: #3f6ad8
}

.btn {
	position: relative;
	transition: color 0.15s, background-color 0.15s, border-color 0.15s,
		box-shadow 0.15s;
	outline: none !important
}

.card-footer {
	background-color: #fff
}
</style>

<!-- Breadcrumbs-->
<ol class="breadcrumb">
	<li class="breadcrumb-item"><a href="<c:url value='/admin/adminMain.do'/>">관리 홈</a></li>
	<li class="breadcrumb-item active">노출관리</li>
</ol>

<!-- https://bbbootstrap.com/snippets/todo-task-list-badges-71324362-->
<div class="card mb-3">
	<div class="card-header">
		<i class="fa fa-tasks"></i>&nbsp;추천도서 목록
	</div>
	<div class="card-body">
		<div class="table-responsive">
			<ul class=" list-group list-group-flush">
				<c:if test="${!empty list }">
					<li class="list-group-item">
						<div class="widget-content p-0">
							<div class="widget-content-wrapper">
								<div class="widget-content-left mr-2">
									<div class="custom-checkbox custom-control">
										<input class="form-check-input" id="checkbox0"
											type="checkbox" value="0"><label class="form-check-label"
											for="checkbox0">&nbsp;</label>
									</div>
								</div>
								<div class="widget-content-left flex4"></div>
								<div class="widget-content-right">
									<button class="btn btn-outline-danger"
									id="bt_delete">
										선택삭제</button>
								</div>
	
							</div>
						</div>
					</li>
				</c:if>
				<!-- 반복문 시작 -->
				<c:if test="${empty list }">
					<li>추천도서가 없습니다.</li>
				</c:if>

				<c:if test="${!empty list }">
				<c:set var="i" value="1"/>
					<c:forEach var="vo" items="${list }">
					
						<li class="list-group-item">
							<div class="widget-content p-0">
								<div class="widget-content-wrapper">
									<div class="widget-content-left mr-2">
										<div class="custom-checkbox custom-control">
											<input class="form-check-input" id="checkbox${i} "
												type="checkbox" value="${vo.recombookNo }"><label class="form-check-label"
												for="checkbox${i}">&nbsp;</label>
										</div>
									</div>
									<div class="widget-content-left" style="width:1000px">
										<div class="widget-content">
											<img align="left" style="width:100px"
												src="${vo.cover }">
											<div class="widget-heading">${vo.bookName }</div>
											<div class="widget-subheading">${vo.writer }</div>
											<br>
											<p>
												ISBN 13 : ${vo.isbn }<br>
												가격 : ${vo.price }<br>
												출판사 : ${vo.publisher }<br>
												추천인 : ${vo.managerId }<br>
												
											</p>
										</div>

									</div>
									<div class="widget-content-right">
										<input type="hidden" name="detail" value="${vo.isbn }">
										<button
											class="border-0 btn-transition btn btn-outline-success bt_detail">
											상세보기</button>
									</div>
								</div>
							</div>
						</li>
						<c:set var="i" value="${i+1}"/>
					</c:forEach>
				</c:if>
				<!-- 반복문 끝 -->
			</ul>
		</div>
	</div>
	<div class="d-block text-right card-footer">
		<a href="${pageContext.request.contextPath}/index.do">메인보기</a>
		<button class="btn btn-primary" id="btAdd" title="새창열림">추천도서
			추가하기</button>
	</div>
</div>
<%@ include file="inc/bottom.jsp"%>