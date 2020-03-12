<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/mypage/mypageMain.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/mypage/useroutCss.css">
<meta charset="UTF-8">
<%@include file="../../inc/top.jsp" %>
<%@include file="../includeMy.jsp" %>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		$("#error").hide();
	});

	function send() {
		if(!frm.chkagree.checked){
			alert("상기 내용을 확인했다는 체크가 필요합니다.");
			event.preventDefault();
			$("#chkagree").focus();
		}else if($("#pwd").val().length<1){
			$("#error").show();
			event.preventDefault();
			$("#pwd").focus();
		}
		
	}

</script>
<form name="frm" method="post" action="<c:url value='/user/userOut.do'/>" onsubmit="send()">
	<!-- 회원 탈퇴 -->
	<div id="out">
		<p>회원탈퇴</p>
		<hr><hr>
		<div class="all">
			<div id="cont">
				<label>그동안  <span>"책 읽기 좋은 시간"</span>을 이용해주셔서 감사합니다.</label>
				<p>서비스를 이용하시는데 불편사항이 있으셨다면 아래의 사유를 작성해주시면 </p>
				<p>보다 더 나은 서비스를 제공드리기 위해 노력하겠습니다.</p>
			</div>
			<div id="info">
				<label>회원 탈퇴 안내</label>
				<hr>
					<p>탈퇴시 주의 사항</p>
					<ul id="ultag">
						<li>즉시 탈퇴 처리 및 기존 아이디 사용 불가</li>
						<p>회원 탈퇴 시, 즉시 탈퇴 처리되며 기존에 가입하셨던 아이디로 재가입(재사용)이 불가능 합니다.</p>
						<li>적립금/혜택 소멸 및 재가입시 복구 불가</li>
						<p>회원 탈퇴 시, 회원님 아이디에 등록된 적립금과 우수고객등급에 따른 혜택은 모두 소멸되어, 
							재가입하더라도 복구되지 않습니다. (Mileage, 도서 상품권, 할인쿠폰 등)</p>
						<li>탈퇴 후 7일 이내 재가입 불가</li>
						<p>회원 탈퇴 후 7일이내 동일 휴대전화번호 / 이메일주소 / 개인식별정보(CI/DI)로 사이트 가입이 불가능합니다.</p>
					</ul>
					<hr>
					<p>게시글 안내사항</p>
					<ul id="ultag">
						<li>상품리뷰와 1:1 문의와 같은 게시판형 서비스에 등록 된 게시물은 탈퇴 후에도 자동 삭제 되지 않습니다.</li>
					</ul>
					<hr>
				<label>탈퇴 사유 확인</label>
					<div id="cause">
						<table id="tbl">
							<tr>
								<th>탈퇴사유</th>
								<td>
									<input name="withdrawalreason" id="b1" type="radio" value="상품품질 불만"><label for="b1">상품품질 불만</label>
									<input name="withdrawalreason" id="b2" type="radio" value="이용빈도 낮음"><label for="b2">이용빈도 낮음</label>
									<input name="withdrawalreason" id="b3" type="radio" value="개인정보유출 우려"><label for="b3">개인정보유출 우려</label>
									<input name="withdrawalreason" id="b4" type="radio" value="배송지연"><label for="b4">배송지연</label><br>
									<input name="withdrawalreason" id="b5" type="radio" value="교환/환불/품질 불만"><label for="b5">교환/환불/품질 불만</label>
									<input name="withdrawalreason" id="b6" type="radio" value="A/S 불만"><label for="b6">A/S 불만</label>
									<input name="withdrawalreason" id="b7" type="radio" value="기타"><label for="b7">기타</label>
								</td>
							</tr>
							<tr>
								<th>기타</th>
								<td>
									<textarea name="withdrawalreason" rows="1" cols="1" placeholder="기타 불편사항 등 고객님의 충고를 부탁 드립니다."></textarea>
								</td>
							</tr>
						</table>
					</div>
				<label>본인 확인</label>
					<div id="chkuser">
						<table class="tbl2">
							<tr>
								<th>아이디</th>
								<td>${userid }</td>
							</tr>
							<tr>
								<th>비밀번호</th>
								<td><input type="password" name="pwd" id="pwd">
								<span id="error">*비밀번호를 입력해주세요</span>
								</td>
							</tr>
						</table>
					</div>
					<div id="chk">
					<input type="checkbox" name="chkagree" id="chkagree"> 
					<label for="chkagree">상기 사항을 모두 확인하였습니다.</label><br>
					<p>적립금/혜택 소멸, 재가입 시 복구 불가능, 마일리지 <b>이용 종료 및 복구 불가능 및 기존 아이디 영구 재사용 <b id="b">및 7일이내 재가입</b> 불가함</b>에 동의 합니다.</p>
					<input type="button" value="취소"><input type="submit" value="동의">
					</div>
			</div>
			
			
		</div>
	</div>
</form>
</div>
</div>
<%@include file="../../inc/bottom.jsp" %>







