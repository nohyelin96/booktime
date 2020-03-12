<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>추천 도서 검색</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">

<style type="text/css">
	.page{
		border-radius: 10px;
		margin: 2% 0;
	}
	a{
	color:#00bcd5;
	}
</style>

<!-- Bootstrap core JavaScript -->
  <script src="<c:url value='/resources/vendor/jquery/jquery.min.js'/>"></script>
  <script src="<c:url value='/resources/vendor/bootstrap/js/bootstrap.bundle.min.js'/>"></script>

<script type="text/javascript">
	$(function() {
		$(".choose").click(function(){
			var checkBtn = $(this);
	        
	        var i=checkBtn.parent();
	        var isbn=i.find("input[name='isbn']").val();
	        var bookName=i.find("input[name='bookName']").val();
	        var price=i.find("input[name='price']").val();
	        var publisher=i.find("input[name='publisher']").val();
	        var writer=i.find("input[name='writer']").val();
	        var cover=i.find("input[name='cover']").val();
	          
	        alert(bookName+", "+writer);

			//ajax 통신으로 isbn,제목,가격,출판사,가격,표지 보낼것
			
			$.ajax({
			url : "<c:url value='/admin/adminRecommendAdd.do'/> ",
			type : "post",
			data : {
				"isbn": isbn,
				"bookName": bookName,
				"price": price,
				"publisher": publisher,
				"writer": writer,
				"cover": cover
			},
			success : function(result){
				alert("추천도서 등록 완료");
				opener.location.reload();
				self.close();
			},
			error:function(xhr, status, error){
				alert("Error:"+ status+"=>"+ error);
			}
				
		});		
	});
});
	function pageFunc(curPage){		
		$("input[name=start]").val(curPage);
		$("form[name=frmPage]").submit();
	}
	
</script>
<!-- 아이콘용 Font Awesome -->
  <script src="https://kit.fontawesome.com/a73e110cf5.js" crossorigin="anonymous"></script>
<style>
@import
	url('https://fonts.googleapis.com/css?family=Nanum+Gothic&display=swap')
	;
</style>
<style type="text/css">
p, label {
	font-size: 0.9em;
}

#divTable {
	width: 450px;
}

h1 {
	font-size: 1.5em;
	margin-bottom: 25px;
}

.error {
	color: red;
	display: none;
}

#page {
	margin: 10xp 0;
	text-align: center;
}
</style>

</head>
<body class="bg-dark">
<div class="container">
		<div class="container page" style="width: 100%; height:100%; background-color: white;">
	<h1 style="color:#00bcd5"><i class="fas fa-search" style="color:gray"></i>&nbsp;추천도서 검색</h1>
	<p style="color:gray">찾고 싶은 책 제목을 입력해 주세요</p>

<!-- 페이징 처리 관련 form -->
<form action="<c:url value='/admin/adminRecomand.do'/>" 
	name="frmPage" method="post">
	
	<!-- 한 페이지당 게시글 수  -->
	<input type= "hidden" name="MaxResults" value="10">
	<!-- 한 블럭당 페이지 수 -->
	<input type="hidden" name="blockSize" value="10">
	<!-- 전체 개수 -->
	<input type="hidden" name="totalResults" value="${pagingInfo.totalRecord }">
	<input type="hidden" name="start" value="${pagingInfo.currentPage }">
	<input type="hidden" value="${pagingInfo.firstPage }">
	<input type="hidden" value="${pagingInfo.lastPage }">
	
	<div class="form-row">
	<div class="form-group mr-2">
		<label for="title">책 제목</label>
	</div>	
	<div class="form-group md-8">
		<input class="form-control" type="text" name="title" id="title" value="${param.title }">
	</div>
	<div class="form-group">
		<button class="btn btn-info" id="btSearch" type="submit" title="search">찾기</button>
	</div>
	<span class="error">제목을 입력하세요</span>
	
	</div>
</form>
	<c:if test="${list!=null }">
		<div id="divTable">
			<table class="table table-hover box2" summary="알라딘 도서 검색 결과">
				<colgroup>
					<col style="width:20%">
					<col style="width:*">
				</colgroup>
				<thead class="thead-dark" style="width:100%">
					<tr>
						<th scope="col">책 표지</th>
						<th scope="col">책 제목</th>
						<th scope="col">지은이</th>
						<th scope="col">선택</th>
					</tr>
				</thead>

				<tbody>
					<c:if test="${empty list }">
						<tr style="text-align: center">
							<td colspan="4">검색 결과가 없습니다</td>
						</tr>
					</c:if>
					<c:if test="${!empty list }">
					
						<!-- 반복시작 -->
						<c:forEach var="map" items="${list }">
							<tr>
								<td scope="row"><img src="${map['cover'] }" alt="cover" style="width: 100px"></td>
								<td><a
									href='<c:url value="/book/bookDetail.do?ItemId=${map['isbn13'] }"/>'
									target="_blank"> ${map['title'] } </a></td>
								<td>${map['author'] }</td>
								<td style="width: 50px">
								<input class="form-check-input choose" id="btnChoose"
								type="checkbox" value="${vo.isbn13 }">
								
								<input type="hidden" id="isbn" name="isbn" value="${map['isbn13'] }">
								<input type="hidden" id="bookName" name="bookName" value="${map['title'] }">
								<input type="hidden" id="price" name="price" value="${map['priceSales'] }">
								<input type="hidden" id="publisher" name="publisher" value="${map['publisher'] }">
								<input type="hidden" id="writer" name="writer" value="${map['author'] }">
								<input type="hidden" id="cover" name="cover" value="${map['cover'] }">
								
								</td>
								
							</tr>
							
						</c:forEach>
						<!-- 반복끝 -->
					</c:if>
				</tbody>
			</table>
			<div class="divPage text-center">
					<!-- 이전블럭으로 이동 -->
					<c:if test="${pagingInfo.firstPage>1 }">	
						<a href="#" onclick="pageFunc(${pagingInfo.firstPage-1})">
							<i class="fas fa-chevron-left"></i>
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
							<i class="fas fa-chevron-right"></i>
						</a>
					</c:if>	

			</div>
		</div>
	</c:if>
	</div>
	</div>
</body>
</html>
