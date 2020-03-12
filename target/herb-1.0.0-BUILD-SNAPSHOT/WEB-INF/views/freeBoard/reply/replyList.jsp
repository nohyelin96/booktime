<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<c:if test="${empty list}">
	<hr>
	<div class="media mb-4">

		<div class="media-body">
			<div class=row>
				<div class="col text-center">아직 댓글이 없습니다</div>
			</div>
		</div>
	</div>
	<hr>
</c:if>
<!-- Single Comment -->
<c:if test="${!empty list}">
	<c:forEach var="replyVo" items="${list }">
		<div class="media mb-4">

			<div class="media-body">
				<div class=row>
					<div class="col text-left">
					<input type="hidden" id="replyNo" name="replyNo" value="${replyVo.replyNo }"/>
					<input type="hidden" id="replyNo" name="replyNo" value="${replyVo.groupNo }"/>
					<input type="hidden" id="replyNo" name="replyNo" value="${replyVo.sort }"/>
						<h5 class="mt-0">${replyVo.userid }</h5>
						<p>${replyVo.replyContent }</p>
						<p color="gray">${replyVo.replyRegdate }</p>
					</div>
					<div class="col text-right">
						<button class="border-0 btn-transition btn btn-outline-success">
							<i class="fas fa-pencil-alt"></i>
						</button>
						<button class="border-0 btn-transition btn btn-outline-danger">
							<i class="fas fa-times"></i>
						</button>
					</div>
				</div>
				<hr>
			</div>

		</div>
	</c:forEach>
</c:if>
