<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/mypage/userInfo.css">
<%@include file="../../inc/top.jsp" %>  
<%@include file="../includeMy.jsp" %>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script type="text/javascript">
	$('.form-check-input').prop('indeterminate', true);
	
	function sample4_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
                
                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var roadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 참고 항목 변수

                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('zipcode').value = data.zonecode;
                document.getElementById("newaddress").value =data.roadAddress;
                document.getElementById("parseladdress").value =data.jibunAddress;
                
                // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
                if(roadAddr !== ''){
                    document.getElementById("extraAddress").value = extraRoadAddr;
                } else {
                    document.getElementById("extraAddress").value = '';
                }

                var guideTextBox = document.getElementById("guide");
                // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
                if(data.autoRoadAddress) {
                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                    guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                    guideTextBox.style.display = 'block';

                } else if(data.autoJibunAddress) {
                    var expJibunAddr = data.autoJibunAddress;
                    guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
                    guideTextBox.style.display = 'none';
                } else {
                    guideTextBox.innerHTML = '';
                    guideTextBox.style.display = 'none';
                }
            }
        }).open()
	}
	
	function btnId(){ //아이디 중복확인
		var userid=frm1.userid.value;
		window.open("<c:url value='/user/chkId.do?userid="+userid+"'/>","",
			"width=500px, height=200px, scrollbars=yes, resizable=yes");
	}
	
	$(document).ready(function(){
		$("#email3").hide();
		
		$("#email2").change(function(){
			if($("#email2").val()=='etc'){
				$("#email3").show();
			}else{
				$("#email3").hide();
			}
		});
		
		var y="Y";
		
		var addressError=document.getElementById("addressError");
		
		$(".submit").click(function(event){
			if($("#parseladdress").val().length<1){
				addressError.innerHTML='지번주소 입력시 [더보기]란을 클릭해 선택해주십시오.';
				addressError.style.display ='block';
			}
		});
		
		$(".edithp").hide();//처음엔 숨겨놓음
		$(".editaddress").hide();
		$(".editemail").hide();
		
	});
	
	$(function(){
		$("#btHp").click(function(){
			$(".edithp").slideToggle();
		});
		$("#btaddress").click(function(){
			$(".editaddress").slideToggle();
		});
		$("#btemail").click(function(){
			$(".editemail").slideToggle();
		});
		
		
		$("#btn1").click(function(){
			if($("#pwd").val().length<1){
				alert("비밀번호를 입력해주세요");
				event.preventDefault();
				$("#pwd").focus();
			}else if($("#hp2").val().length>4){
				alert("입력하신 휴대폰 번호를 다시 확인해 주세요");
				event.preventDefault();
				$("#hp2").focus();
			}else if($("#hp3").val().length>4){
				alert("입력하신 휴대폰 번호를 다시 확인해 주세요");
				event.preventDefault();
				$("#hp3").focus();
			}
		});
		
		/*$("#btn2").click(function(){
			if(){
				
			}
		});*/
		
	});
	
	
	
</script>

<form name="frm" method="post" action="<c:url value='/mypage/myinfo/editUser.do'/>">
	<div class="info">
		<p id="all">개인정보 수정</p>
		<p id="sub"><img src="<c:url value='/resources/images/icons/arrow.png'/>">
		고객님의 주소와 연락처 등 개인정보를 수정할 수 있습니다.</p>
		<p id="sub"><img src="<c:url value='/resources/images/icons/arrow.png'/>">
		이메일은 한번 더 확인하시어,  다양한 이벤트정보를 제공해 드리는 SMS, 메일서비스 혜택을 받으시기 바랍니다.</p>
		<hr><hr>
		<div id="editform">
			<p class="p1">나의 정보 관리</p>
			<fieldset id="userid">
				<label>아이디</label>
				<input type="text" readonly="readonly" value="${userid }">
			</fieldset>
			
			<fieldset id="name">
				<label>성명</label>
				<input type="text" readonly="readonly" value="${name }">
			</fieldset>
			
			<fieldset id="birth">
				<label>생년월일</label>
				<input type="text" readonly="readonly" value="${birth }">
			</fieldset>
			
			<fieldset id="gender">
				<label>성별</label>
				<input type="text" value="${gender }" readonly="readonly">
			</fieldset>
			
			<fieldset id="hp">
				<label>전화번호</label>
				<span>${phone }</span>
				<input class="editbt" id="btHp" type="button" value="수정">
				<div class="edithp">
				<hr>
					<c:set var="phone" value="${fn:split(phone,'-') }"/>
					<input name="hp1" type="text" class="" id="hp1" value="${phone[0] }" onfocus="this.value=''"> - 
				    <input name="hp2" type="text" class="" id="hp2" value="${phone[1] }" onfocus="this.value=''"> - 
				    <input name="hp3" type="text" class="" id="hp3" value="${phone[2] }" onfocus="this.value=''">
				</div>
			</fieldset>
			
			<fieldset id="address">
				<label>주소</label>
				<span>${newaddress} ${addressDetail}</span>
				<input class="editbt" id="btaddress" type="button" value="수정">
				<div class="editaddress">
				<hr>
					<input name="zipcode" type="text" class="" id="zipcode" value="${zipcode }">
			      	<button type="button" class="btn" onclick="sample4_execDaumPostcode()">우편번호 찾기</button><br>
			      	
			      	<input name="newaddress" type="text" class="" id="newaddress" value="${newaddress }"><br>
			      	
			      	<input name="parseladdress" type="text" class="" id="parseladdress" value="${parseladdress }">
			      	<p style="color: gray; font-size: 0.8em;margin-left: 203px;margin-top: 3px;">도서 산간지방 배송을 위해 지번주소를 받드시 입력해 주시기 바랍니다.</p>
			      	<span id="addressError" style="color:red;font-size: 0.8em;"></span>
			      	<span id="guide" style="color:#999;display:none"></span><br>
			      	
			      	<input name="addressdetail" type="text" class="" id="addressdetail" value="${addressDetail }">
			      	<input type="text" id="extraAddress" style="display: none;">
				</div>
			</fieldset>
			
			<fieldset id="email">
				<label>E-mail</label>
				<span>${email1 } @ ${email2 }</span>
				<input class="editbt" id="btemail" type="button" value="수정">
				<div class="editemail">
				<hr>
					<input type="text" name="email1" id="email1" value="${email1 }" onfocus="this.value=''"> @
					<input type="text" name="email2" id="email2" value="${email2 }" onfocus="this.value=''">
      			</div>
			</fieldset>
			<fieldset>
				<label><img src="<c:url value='/resources/images/icons/check.png'/>">비밀번호 확인</label>
				<input type="password" name="pwd" id="pwd">
			</fieldset>
			<button type="submit" id="btn1">나의정보 수정</button>
		</div>
	</div>
</div>
</div>
</form>
<%@include file="editPWD.jsp" %>

<%@include file="../../inc/bottom.jsp" %>