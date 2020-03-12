<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="inc/top.jsp" %>

        <!-- Breadcrumbs-->
        <ol class="breadcrumb">
          <li class="breadcrumb-item">
            <a href="<c:url value='/admin/adminMain.do'/>">관리 홈</a>
          </li>
          <li class="breadcrumb-item active">회원관리</li>
        </ol>

        <!-- DataTables Example -->
        <div class="card mb-3">
          <div class="card-header">
            <i class="fas fa-table"></i>
            회원 목록</div>
          <div class="card-body">
            <div class="table-responsive">
              <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                <thead>
                  <tr>
                    <th>이름</th>
                    <th>아이디 <span class="text-primary">(관리자)</span></th>
                    <th>이메일</th>
                    <th>전화번호</th>
                    <th>주소</th>
                    <th>생년월일</th>
                    <th>수정</th>
                    <th>탈퇴</th>
                  </tr>
                </thead>
                <tfoot>
                  <tr>
                    <th>이름</th>
                    <th>아이디 <span class="text-primary">(관리자)</span></th>
                    <th>이메일</th>
                    <th>전화번호</th>
                    <th>주소</th>
                    <th>생년월일</th>
                    <th>수정</th>
                    <th>탈퇴</th>
                  </tr>
                </tfoot>
					<c:if test="${empty list}">
						<td colspan="8">회원 조회결과가 없습니다.</td>
					</c:if>

					<!-- 반복문 시작 -->
					<c:if test="${!empty list}">
						<c:forEach var="vo" items="${list }">
							<tr>
														
								<td>${vo.name }</td>
								<c:if test="${fn:contains(vo.grade, 'A')}">
									<td class="text-primary">${vo.userid }</td>
								</c:if>
								<c:if test="${fn:contains(vo.grade, 'M')}">
									<td>${vo.userid }</td>
								</c:if>
								<c:if test="${fn:contains(vo.emailagree, 'Y')}">
									<td>${vo.email1 }@${vo.email2 }</td>
								</c:if>
								<c:if test="${!fn:contains(vo.emailagree,'Y')}">
									<td class="text-danger">
									${vo.email1 }@${vo.email2 }<br>
									<small>(이메일 수신거부)</small>
									</td>
								</c:if>
								<td>${vo.phone }</td>
								<td>${vo.zipcode }<br>${vo.newaddress }<br><small>(${vo.parseladdress })
									<br>${vo.addressdetail }</small>
								</td>
								<td>${vo.birth }</td>
					
					<td>
					<input type="hidden" name="withdrawaldate" value="${vo.withdrawaldate }">					
                    <a class="btn btn-info edit"
					href="#"
					role="button">수정</a>
					</td>
                    <td>
                    <c:if test="${empty vo.withdrawaldate}">
                    <a class="btn btn-danger withdrow"
					href="#"
					role="button">탈퇴</a>
					</c:if>
					
					<c:if test="${!empty vo.withdrawaldate}">
                    탈퇴된 회원
					</c:if>
					</td>		
</tr>
						</c:forEach>
					</c:if>
					<!-- 반복문 끝 -->
				</tbody>
                  </tbody>
              </table>
            </div>
            <div class="col text-center">
        <a class="btn btn-info"
					href="${pageContext.request.contextPath}/admin/adminMemberExport.do"
					role="button">엑셀 파일로 받기</a>
        </div>
          </div>
          <div class="card-footer small text-muted">마지막 업데이트 11:59 PM</div>
        </div>

      </div>
      <!-- /.container-fluid -->
<script type="text/javascript">
$(function(){

		
	$("#dataTable").on("click", ".withdrow", function(){
              
              var btn = $(this);
              
              var trr = btn.parent().parent();
              var tdd = trr.children();
    	  
              var userid = tdd.eq(1).text();
				win = window.open("<c:url value='/admin/withdrowForm.do?userid="+userid+"'/>","refund","top=100,left=300,resizable=no,location=no,width=550,height=650");

				win.focus();
	});
      
	$("#dataTable").on("click", ".edit", function(){
          
          var checkBtn = $(this);
          
          var tr = checkBtn.parent().parent();
          var td = tr.children();
          
          var i=checkBtn.parent();
          var input=i.find("input[name='withdrawaldate']").val();
          
          //console.log("클릭한 Row의 모든 데이터 : "+tr.text());
          
          var id = td.eq(1).text();
          //alert(id);
          
          //alert(input);

			win = window.open("<c:url value='/admin/memberEditForm.do?userid="+id+"'/>","refund","top=100,left=300,resizable=no,location=no,width=550,height=650");

			win.focus();
    	  
	});
})
</script>

     <%@ include file="inc/bottom.jsp" %>