<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../inc/top.jsp" %>
<link href="<c:url value='/resources/css/style.css'/>" 
	rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" charset="utf-8">

</script>
<div id="contact">
	<h1>1:1 문의하기</h1>
	<form action="<c:url value='/mail/mailSending.do'/>" method="POST">
		<fieldset>
			<label for="title">제목 : </label>
			<input type="text" name="title" id="title" placeholder="제목을 입력해주세요." />
			
			<label for="qType">문의 유형</label>
		    	<select name="qType" id="qType" title="문의 유형">
		       		<option class="selected">선택하세요</option>
		            <option class="selection">상품문의</option>
		            <option class="selection">주문/주문변경</option>
		            <option class="selection">배송관련 문의</option>
		            <option class="selection">반품/교환</option>
		            <option class="selection">회원정보</option>
		            <option class="selection">결제</option>         
		        </select>
			
			<label for="name">이름 : </label>
			<input type="text" name="name" id="name" placeholder="이름을 입력해주세요." />
			
			<label for="email">Email : </label>
			<input type="email" name="email" id="email" placeholder="E-Mail 주소를 입력해주세요." />
			
			<label for="message">문의 내용 : </label>
			<textarea id="message" name= "message" placeholder="문의하실 내용을 입력해주세요."></textarea>
			
			<!-- 파일 첨부 영역 => 추후 추가 -->
			<!-- <div class="filebox">
				<label for="upfile">첨부파일 : </label>
		    	<input type="file" id="upfile" name="upfile" />(최대 2M)
			</div> -->
			
			<input type="submit" value="보내기" />
			<input type="button" value="취소" />
			
		</fieldset>
	</form>
</div>

<%@include file="../inc/bottom.jsp" %>
