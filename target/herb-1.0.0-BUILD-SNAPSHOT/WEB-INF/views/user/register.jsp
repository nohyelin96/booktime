<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="../inc/top.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/register.css">
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <link rel="stylesheet" href="/resources/demos/style.css">
<title>회원등록</title>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript">
	$('.form-check-input').prop('indeterminate', true);
	
	$( function() {
	    $( "#datepicker" ).datepicker({
	      changeMonth: true,
	      changeYear: true
	    });
	  });
	
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
		
		$("#userid").focus();
		
		$("#error1").hide();
		$("#error2").hide();
		$("#errorid").hide();
		$("#error3").hide();
		$("#error4").hide();
		$("#error5").hide();
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
			if($("#userid").val().length<8){ //아이디가 8자리 이하일때
				$("#errorid").show();
				event.preventDefault();
				$("#userid").focus();
			}else if($("#pwd").val().length<8){ //비밀번호가 8자리 이하일때
				$("#error2").show();
				event.preventDefault();
				$("#pwd").focus();
			}else if($("#name").val().length<1){ //이름이 비어있다면
				$("#error3").show();
				event.preventDefault();
				$("#name").focus();
			}else if($("#hp2").val().length>4){
				alert("휴대폰 번호를 다시 입력해 주세요");	
				event.preventDefault();
				$("#hp2").focus();
			}else if($("#hp3").val().length>4){
				alert("휴대폰 번호를 다시 입력해주세요");
				event.preventDefault();
				$("#hp3").focus();
			}
		});
	});
	
	
</script>
</head>
<body>
<h2>회원가입</h2>
<form name="frm1" class="frm1" method="post" action="<c:url value='/user/userWrite.do'/>">
<div class="allBox">
    <div class="insertId">
      <label for="">아이디 : </label>
      <input name="userid" type="text" class="" id="userid" required placeholder="예) hong123">
      <input type="button" value="중복확인" onclick="btnId()">
      <label id="error1">*아이디 중복확인을 해주세요</label>
      <label id="errorid">*아이디는 8자리 이상입력해야 합니다.</label>
      <input type="hidden" name="chkid" id="chkid">
    </div>
    
    <div class="insertPwd">
      <label for="">패스워드 : </label>
      <input name="pwd" type="password" class="" id="pwd" required size="20" placeholder="영문자(대/소)+숫자+특수문자">
      <label id="error2">*비밀번호는 영대소문자,문자,숫자를 조합한 8~20자 이내로 입력해주세요</label>
    </div>
    
    <div class="insertName">
      <label for="">이름 : </label>
      <input name="name" type="text" class="" id="name" required placeholder="예) 홍길동">
      <label id="error3">*이름은 비워둘 수 없습니다.</label>
    </div>
  
    <div class="insertBirth">
      <label for="birth" id="birth">생년월일 : </label>
      <input name="birth" type="date" id="datepicke" required placeholder="생일을 입력해주세요">
    </div>
    
    <label id="allGender">성별 : </label>
    <div class="insertGender">
	  	<div>
			 <input type="radio" value="F" id="female" name="gender" checked="checked">
			 <label for="female"> 여성</label>
			 <input type="radio" value="M" id="male" name="gender">
			 <label for="male"> 남성</label><br>
			 <span id="view" ></span>
		</div>
    </div>
    
    <div><input type="hidden" name="grade" value="M1"></div>
    
    <div class="email">
      <label>E-mail : </label>
      <input name="email1" type="text" id="email1" required placeholder="예) hong123"> @
      <select name="email2" id="email2" required>
        	<option value="">선택하세요</option>
        	<option value="naver.com">naver.com</option>
        	<option value="daum.net">daum.net</option>
        	<option value="gmail.com">gmail.com</option>
        	<option value="nate.com">nate.com</option>
        	<option value="etc">직접입력</option>
      </select>
      <input name="email3" type="text" id="email3" placeholder="gmail.com">
	  <input name="emailagree" type="checkbox" id="emailagree" value="Y">
	  <label id="agree" for="emailagree"> 이메일 수신에 동의합니다.</label>
	  <div id="info"></div>
  	</div>
  	  	
    <div class="">
      <label for="">우편번호 : </label>
      <input name="zipcode" type="text" class="" id="zipcode" required placeholder="예) 12345">
      <button type="button" class="" onclick="sample4_execDaumPostcode()">우편번호 찾기</button>
    </div>
    
    <div class="">
      <label for="">도로명주소 : </label>
      <input name="newaddress" type="text" class="" id="newaddress" required placeholder="예) 한누리대로 411, 국립중앙박물관, 상암동 1595">
    </div>
    
    <div class="">
      <label for="">지번주소 : </label>
      <input name="parseladdress" type="text" class="" id="parseladdress" required placeholder="예) 서울특별시 서초구 반포동 산60-1 국립중앙도서관">
      <span id="addressError" style="color:red;font-size: 0.8em;"></span>
      <span id="guide" style="color:#999;display:none"></span>
    </div>
    
    <div class="">
      <label for="">상세주소 : </label>
      <input name="addressdetail" type="text" class="" id="addressdetail" required placeholder="예) 자이아파트 103동">
      <input type="text" id="extraAddress" style="display: none;">
    </div>
    
    <div class="">
    <label>휴대폰 번호 : </label>
		<select name="hp1" id="h1" class="" required>
	    	<option selected>010</option>
	        <option>...</option>
	    </select> - 
	    <input name="hp2" type="text" class="" id="hp2" required> - 
	    <input name="hp3" type="text" class="" id="hp3" required>
    </div>
  <input class="submit" type="submit" value="회원가입">
</div>
</form>
</body>
</html>
<%@include file="../inc/bottom.jsp" %>