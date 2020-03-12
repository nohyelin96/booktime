<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 암호찾기</title>

  <!-- Custom fonts for this template-->
  <link href="${pageContext.request.contextPath}/resources/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">

  <!-- Custom styles for this template-->
  <link href="${pageContext.request.contextPath}/resources/css/sb-admin.css" rel="stylesheet">

</head>

<body class="bg-dark">

  <div class="container">
    <div class="card card-login mx-auto mt-5">
      <div class="card-header">비밀번호 초기화</div>
      <div class="card-body">
        <div class="text-center mb-4">
          <h4>암호를 잊었나요?</h4>
          <p>이메일 주소를 입력하시면 어떻게 비밀번호를 
          <br>다시 만들 수 있는지, 메일을 발송하여 
          <br>안내해 드리겠습니다.</p>
        </div>
        <form name=emailForm" method="post"
					action="<c:url value='/admin/adminPassword.do'/>">
          <div class="form-group">
            <div class="form-label-group">
           		<input type="text" id="userid" name="userid" class="form-control" 
              		placeholder="아이디를 입력해주세요." required="required" autofocus="autofocus">
              	<label for="userid">아이디를 입력해주세요.</label>
            </div>
            <div class="form-label-group">
              <input type="email" id="inputEmail" name="inputEmail" class="form-control" 
              	placeholder="가입시 입력한 이메일을 입력해주세요." required="required" autofocus="autofocus">
              <label for="inputEmail">가입시 입력한 이메일을 입력해주세요.</label>
            </div>
          </div>
          <button type="submit" class="btn btn-primary btn-block">비밀번호 초기화</button>
        </form>
        <div class="text-center mt-4">
          <a class="d-block small" href="<c:url value='/admin/adminLogin.do' />">로그인 화면으로</a>
        </div>
      </div>
    </div>
  </div>

  <!-- Bootstrap core JavaScript-->
  <script src="<c:url value='/resources/vendor/jquery/jquery.min.js' />"></script>
  <script src="<c:url value='/resources/vendor/bootstrap/js/bootstrap.bundle.min.js' />"></script>

  <!-- Core plugin JavaScript-->
  <script src="<c:url value='/resources/vendor/jquery-easing/jquery.easing.min.js' />"></script>

</body>
</html>