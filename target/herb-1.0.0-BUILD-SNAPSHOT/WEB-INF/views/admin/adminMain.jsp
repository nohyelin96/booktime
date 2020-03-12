<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="inc/top.jsp"%>

<style type="text/css">
	td, th{
		text-align: center;
	}
</style>

<!-- Breadcrumbs-->
<ol class="breadcrumb">
	<li class="breadcrumb-item"><a href="#">관리 홈</a></li>
	<li class="breadcrumb-item active">메인</li>
</ol>

<!-- Icon Cards-->
<div class="row">
	<div class="col-xl-3 col-sm-6 mb-3">
		<div class="card text-white bg-primary o-hidden h-100">
			<div class="card-body">
				<div class="card-body-icon">
					<i class="fas fa-fw fa-comments"></i>
				</div>
				<div class="mr-5">${map['recommending'] }개의
					추천도서가<br>등록되어있습니다.
				</div>
			</div>
			<a class="card-footer text-white clearfix small z-1"
				href="<c:url value='/admin/adminRe.do'/>"> <span
				class="float-left">더보기</span> <span class="float-right"> <i
					class="fas fa-angle-right"></i>
			</span>
			</a>
		</div>
	</div>

	<div class="col-xl-3 col-sm-6 mb-3">
		<div class="card text-white bg-warning o-hidden h-100">
			<div class="card-body">
				<div class="card-body-icon">
					<i class="fas fa-fw fa-list"></i>
				</div>
				<div class="mr-5">
					${map['newBoard'] }개의 새 글이 있습니다!<br> ${map['events'] }개의 이벤트가
					진행 중입니다!
				</div>
			</div>
			<a class="card-footer text-white clearfix small z-1"
				href="<c:url value='/admin/adminBoard.do'/>"> <span
				class="float-left">더보기</span> <span class="float-right"> <i
					class="fas fa-angle-right"></i>
			</span>
			</a>
		</div>
	</div>

	<div class="col-xl-3 col-sm-6 mb-3">
		<div class="card text-white bg-success o-hidden h-100">
			<div class="card-body">
				<div class="card-body-icon">
					<i class="fas fa-fw fa-shopping-cart"></i>
				</div>
				<div class="mr-5">${map['newPay'] }건의
					새 주문이 있습니다!<br> ${map['refund'] }건의 교환/환불 요청이 있습니다!
				</div>
			</div>
			<a class="card-footer text-white clearfix small z-1"
				href="<c:url value='/admin/adminCart.do'/>"> <span
				class="float-left">더보기</span> <span class="float-right"> <i
					class="fas fa-angle-right"></i>
			</span>
			</a>
		</div>
	</div>

	<div class="col-xl-3 col-sm-6 mb-3">
		<div class="card text-white bg-danger o-hidden h-100">
			<div class="card-body">
				<div class="card-body-icon">
					<i class="fas fa-fw fa-user-slash"></i>
				</div>
				<div class="mr-5">금일 ${map['newOutUser']}명이 탈퇴했습니다.</div>
			</div>
			<a class="card-footer text-white clearfix small z-1"
				href="<c:url value='/admin/adminMember.do'/>"> <span
				class="float-left">더보기</span> <span class="float-right"> <i
					class="fas fa-angle-right"></i>
			</span>
			</a>
		</div>
	</div>
</div>

<div class="row">
	<div class="col-md-6">
		<!-- Area Chart Example-->
		<div class="card mb-3">
			<div class="card-header">
				<i class="fas fa-chart-area"></i> 매출액 통계 (원)
			</div>

			<div class="card-body">
				<canvas id="myChart" width="200px" height="100px"></canvas>
				<script type="text/javascript">
					var ctx = document.getElementById("myChart");

					var myChart = new Chart(ctx, {

						type : 'bar',

						data : {

							labels : [ "매출액 통계" ],

							datasets : [ {

								label : "순이익",

								data : [ ${map['earning']} ],

								backgroundColor : [

								'rgba(255, 99, 132, 0.2)',

								],

								borderColor : [

								'rgba(255,99,132,1)',

								],

								borderWidth : 1

							},{
								label : "구매확정",

								data : [ ${map['payOk']} ],

								backgroundColor : [

								'rgba(54, 162, 235, 0.2)',

								],

								borderColor : [

								'rgba(54, 162, 235, 1)',

								],

								borderWidth : 1
							},{
								label : "(+)기간만료 마일리지",

								data : [ ${map['noUseP']} ],

								backgroundColor : [

								'rgba(75, 192, 192, 0.2)',

								],

								borderColor : [

								'rgba(75, 192, 192, 1)',

								],

								borderWidth : 1
							},{
								label : "(-)사용 마일리지",

								data : [ ${map['usedP']} ],

								backgroundColor : [

								'rgba(153, 102, 255, 0.2)',

								],

								borderColor : [

								'rgba(153, 102, 255, 1)',

								],

								borderWidth : 1
							}]//dataSet

						},//data

						options : {

							scales : {

								yAxes : [ {

									ticks : {

										beginAtZero : true

									}

								} ]

							}

						}

					});
				</script>
			</div>
			<div class="card-footer small text-muted">매출액 통계</div>
		</div>
	</div>

	<div class="col-md-6">
		<div class="card">
			<div class="card-header">
				<i class="fa fa-chart-pie"></i> 사용자 성비율 (%)
			</div>
			<div class="card-body">
				<canvas id="genders" width="200px" height="100px"></canvas>
				<script type="text/javascript">
						var ctx = document.getElementById("genders");
						var total = ${map['Male']+map['Female']+map['nonMember']};
						var myPieChart = new Chart(ctx, {
						  type: 'pie',
						  data: {
						    labels: ["남성", "여성", "비회원"],
						    datasets: [{
						      data: [Math.round(${map['Male']}/total*100), Math.round(${map['Female']}/total*100), Math.round(${map['nonMember']}/total*100)],
						      backgroundColor: ['#007bff', '#dc3545', '#28a745'],
						    }],
						  },
						});
					</script>
			</div>
			<div class="card-footer small text-muted">사용자 성비율</div>
		</div>
	</div>


</div>

<!-- DataTables Example -->
<div class="card mb-3">
	<div class="card-header">
		<i class="fas fa-table"></i> 주문 목록
	</div>
	<div class="card-body">
		<div class="table-responsive">
			<table class="table table-bordered" id="dataTable4" width="100%"
				cellspacing="0">
				<thead>
					<tr>
						<th class="align-middle">번호</th>
						<th class="align-middle">아이디</th>
						<th class="align-middle">주문 번호<br>
						<small>(비회원 주문번호)</small></th>
						<th class="align-middle">도로명 주소<br>
						<small>(지번)</small></th>
						<th class="align-middle">결제일</th>
						<th class="align-middle">취소일</th>
						<th class="align-middle">주문 가격(원)</th>
						<th class="align-middle">진행사항</th>
					</tr>
				</thead>
				<tfoot>
					<tr>
						<th>번호</th>
						<th>아이디</th>
						<th>주문 번호<br>
						<small>(비회원 주문번호)</small></th>
						<th>도로명 주소<br>
						<small>(지번)</small></th>
						<th>결제일</th>
						<th>취소일</th>
						<th>주문 가격(원)</th>
						<th>진행사항</th>
					</tr>
				</tfoot>
				<tbody>
					<c:forEach var="vo" items="${list}" varStatus="i">
						<tr>
							<td class="align-middle">${i.count}</td>
							<td class="align-middle"><c:if
									test="${fn:indexOf(vo.userid,'#')>=0}">
										비회원
									</c:if> <c:if test="${fn:indexOf(vo.userid,'#')<0}">
										${vo.userid }
									</c:if></td>
							<td class="align-middle">
								<div>
									${vo.payNo }
									<c:if test="${vo.nonMember!='0'}">
										<br>
										<small>(${vo.nonMember })</small>
									</c:if>
								</div>
							</td>
							<td class="align-middle">${vo.newAddress }<br>
							<small>(${vo.parselAddress})</small><br>${vo.addressDetail }</td>
							<td class="align-middle"><fmt:formatDate
									value="${vo.payDate }" pattern="yyyy년 MM월 dd일" /><br> <small><fmt:formatDate
										value="${vo.payDate }" pattern="a hh시 mm분 ss초" /></small></td>
							<td class="align-middle">
								<div class="text-danger">
									<fmt:formatDate value="${vo.cancleDate }"
										pattern="yyyy년 MM월 dd일" />
									<br> <small><fmt:formatDate
											value="${vo.cancleDate }" pattern="a hh시 mm분 ss초" /></small>
								</div>
							</td>
							<td class="align-middle"><fmt:formatNumber
									value="${vo.price }" pattern="#,###" /><br> <c:if
									test="${vo.usePoint>0 }">
									<small class="text-danger">(<fmt:formatNumber
											value="${vo.usePoint}" pattern="#,###" />P 사용)
									</small>
								</c:if></td>
							<td class="align-middle">${vo.progress }</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
	<div class="card-footer small text-muted">Updated yesterday at
		11:59 PM</div>
</div>

</div>
<!-- /.container-fluid -->

<%@ include file="inc/bottom.jsp"%>