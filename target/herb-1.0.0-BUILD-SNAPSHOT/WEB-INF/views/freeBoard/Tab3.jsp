<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
		<div class="tab-content">

			<table class="table table-striped" id="dataTable3" width="100%" cellspacing="0">
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
						<td colspan="4">게시판에 작성된 글이 없습니다.</td>
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
		</div>