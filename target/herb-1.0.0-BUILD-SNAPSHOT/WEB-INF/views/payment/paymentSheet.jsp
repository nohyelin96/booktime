<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../inc/top.jsp"%>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<style type="text/css">
	.deliveryInfo{
		border-top: 1px solid #dee2e6;
		padding: 5px 15px;
	}
	.header{
		background-color: #f8f9fa;
		text-align: center;
		padding: 10px;
		font-weight: bold;
	}
	.btInstrument{
		border: 2px solid #dee2e6;
		font-weight: bold;
		transition-duration: 0.5s;
	}
	
	.btInstrument span{
		vertical-align: super;
	}
	
	.btOn{
		box-shadow: 0px 0px 5px dodgerblue;
	    color: white;
	    background-color: #007bff;
	    transition-duration: 0.5s;
	}
	
	.btOn img{
		transition-duration: 0.5s;
		filter:invert(1);
	}
	
	.btOn:hover{
		color: white;
	}
	
	.processing{
		position: relative;
    	top: 4em;
    	display: none;
	}
</style>
<script type="text/javascript">
	$(function(){
		setPaymentInfo();
		
		$("#btZip").click(function(){	//카카오 우편번호 찾기
			new daum.Postcode({
		        oncomplete: function(data) {
		            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분입니다.
		            var parselAddress = data.jibunAddress;
		            if(parselAddress==null || parselAddress.length<1){
		            	parselAddress = data.autoJibunAddress
		            }
		            
		            $("input[name=zipcode]").val(data.zonecode);
		            $("input[name=parselAddress]").val(parselAddress);
		            $("input[name=newAddress]").val(data.roadAddress);
		            
		        }
		    }).open();
		});
		
		$("input[type=radio]").click(function(){
			if($(this).val()=="1"){
				setPaymentInfo();
			}else if($(this).val()=="2"){
				$("input[name=customerName]").val("");
				$("input[name=hp]").val("");
				$("input[name=email1]").val("");
				$("input[name=email2]").val("");
				$("input[name=zipcode]").val("");
				$("input[name=parselAddress]").val("");
				$("input[name=newAddress]").val("");
				$("input[name=addressDetail]").val("");
				$("input[name=email2]").prop("readOnly", false);
				$("option").each(function(){
					if($(this).val()=="") $(this).prop("selected", true);
				});
			}
		});
		
		var hpWrong = false;
		$("input[name=hp]").keyup(function(){
			if(!hpPattern($(this).val())){
				$(".error").fadeIn(500);
				hpWrong = true;
			}else{
				$(".error").fadeOut(500);
				hpWrong = false;
			}
		});
		
		var IMP = window.IMP;
		IMP.init("imp86151581");
		
		var payOk = false;
		$("form[name=frmPayment]").submit(function(){
			if(!$("input[name=customerName]").val()){
				shake($("input[name=customerName]"));
				return false;
			}else if(!$("input[name=hp]").val() || hpWrong){
				shake($("input[name=hp]"));
				return false;
			}else if(!$("input[name=email1]").val()){
				shake($("input[name=email1]"));
				return false;
			}else if(!$("input[name=email2]").val()){
				shake($("input[name=email2]"));
				return false;
			}else if(!$("input[name=zipcode]").val()){
				shake($("#btZip"));
				return false;
			}else if(!$("input[name=addressDetail]").val()){
				shake($("input[name=addressDetail]"));
				return false;
			}else if(!$("input[name=instrument]").val()){
				shake($(".instrumentDiv"));
				return false;
			}
			
			//
			//payOk=true;
			
			if(!payOk){
				event.preventDefault();
			}else{
				return true;
			}
			
			var orderName = $(".bookName").eq(0).text();
			if($(".bookName").length>1){
				orderName += " 외 "+($(".bookName").length-1)+"권";
			}
			IMP.request_pay({
			    pg : 'inicis', // version 1.1.0부터 지원.
			    pay_method : $("input[name=instrument]").val(),
			    merchant_uid : 'merchant_' + new Date().getTime(),
			    name : orderName,
			    amount : $("input[name=price]").val(),
			    buyer_email : $("input[name=email1]").val()
			    	+"@"+$("input[name=email2]").val(),
			    buyer_name : '${sessionScope.name}',
			    buyer_tel : $("input[name=hp]").val(),
			    buyer_addr : $("input[name=newAddress]").val()
			    	+" "+$("input[name=addressDetail]").val(),
			    buyer_postcode : $("input[name=zipcode]").val()
			    /* m_redirect_url : 'https://www.yourdomain.com/payments/complete' */
			}, function(rsp) {
			    var msg = "";
			    
				if ( rsp.success ) {
			        msg = '결제가 완료되었습니다.';
			        msg += '고유ID : ' + rsp.imp_uid; //imp_797384778723
			        msg += '상점 거래ID : ' + rsp.merchant_uid;
			        msg += '결제 금액 : ' + rsp.paid_amount;
			        msg += '카드 승인번호 : ' + rsp.apply_num;
			        
			        var payNo = rsp.imp_uid.substring(rsp.imp_uid.indexOf("_")+1);
		        	$("input[name=payNo]").val(payNo); 
		        	
			        if("${sessionScope.userid}".length<1){
			        	$("input[name=nonMember]").val(getOrderDate());	//비회원용 조회코드
			        }else{
			        	$("input[name=nonMember]").val(0);	//회원일때 DefaultValue
			        }
			        payOk = true;
			        
			        $("form[name=frmPayment]").submit();
			        
			        $("*").animate({scrollTop:0},250);
					$(".me").fadeOut(500, function(){
			        	$(".processing").fadeIn(500);
			        });
			    } else {
			        msg = '결제에 실패하였습니다.';
			        msg += '에러내용 : ' + rsp.error_msg;
			        alert(msg);
			        return false;
			    }
			});
		});
		
		
		var val = $("input[name=price]").val();
		$("input[name=usePoint]").change(function(){	//포인트 적용
			var price = $("input[name=price]");
			var limit = $("#useFul").val(); //사용가능한 포인트
			
			if(parseInt($(this).val())>parseInt(limit)){	//가장 첫째자리만 비교해버려서 에러가 남=> 20 > 1000 = true
				$(this).val($(this).val()-$(this).val());
			}
			
			price.val(val-$(this).val());
			$("#sum").html(formatNum(val-$(this).val())+"원");
		});
		
		
		$("select").change(function(){
			var sel = $("option:selected").val();
			if(sel.length<1){
				$("input[name=email2]").prop("readOnly", false);
			}else{
				$("input[name=email2]").prop("readOnly", true);
			}
			
			$("input[name=email2]").val(sel);
			
		});
		
		var old = null;
		$(".btInstrument").click(function(){
			event.preventDefault();
			if(old!=null){
				old.removeClass("btOn");
			}
			$(this).addClass("btOn");
			
			var instrument = $(this).find("span").text();
			if(instrument=="휴대폰"){
				instrument = "phone";
			}else if(instrument=="실시간 계좌이체"){
				instrument = "trans";
			}else if(instrument=="신용카드"){
				instrument = "card";
			}else if(instrument=="삼성페이"){
				instrument = "samsung";
			}
			
			$("input[name=instrument]").val(instrument);
			
			old = $(this);
			
		});
	})
	
	function setPaymentInfo(){	//기존 주소 입력
		$("input[name=customerName]").val("${sessionScope.name}");
		$("input[name=hp]").val("${userVo.phone}");
		$("input[name=email1]").val("${userVo.email1}");
		
		var email2 = "${userVo.email2}";
		if(email2.length>0){
			$("option").each(function(){
				if($(this).val()==email2){
					$(this).prop("selected", true);
					$("input[name=email2]").val(email2).attr("readOnly", "readOnly");
				}
			});
		}
		
		$("input[name=zipcode]").val("${userVo.zipcode}");
		$("input[name=parselAddress]").val("${userVo.parseladdress}");
		$("input[name=newAddress]").val("${userVo.newaddress}");
		$("input[name=addressDetail]").val("${userVo.addressdetail}");
	}
	
	function hpPattern(hp){	//전화번호 패턴
		var exp = /^\d{2,3}-\d{3,4}-\d{4}$/;
		
		return exp.test(hp);
	}
	
	function shake(el){	//에러시 애니메이션
		el.animate({
			"margin-left": "15px"
		}, 100,function(){
			el.animate({
				"margin-left": "0"
			})
		})
		el.focus();
	}
	
	function formatNum(x) {	//jquery용 숫자 천단위 패턴
	    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}
	
	function getOrderDate(){ //현재 주문일 코드 생성
		var today = new Date();
		var orderDate = today.getFullYear()+""+(today.getMonth()+1)+"" 
			+today.getDate()+""+today.getSeconds()+""+today.getMilliseconds();
		
		return orderDate;
	}
</script>
<div class="processing container text-center">
	<img alt="결제 진행중 입니다." src="<c:url value="/resources/images/icons/processing.gif"/>">
</div>
<div class="container me">
	<div class="page-header my-4 p-3"
		style="border: 2px solid lightGray;">
		<h3><i class="fa fa-pencil"></i> 주문서 작성</h3>
		<small>- 금액을 확인하시고 배송정보를 정확하게 기입해주세요.</small><br>
		<small>- 3만원이상은 배송비 무료입니다.</small>
	</div>
	
	<div class="table-responsive">
		<form name="frmPayment" method="post" class="form-inline"
					action='<c:url value="/payment/paymentProcess.do"/>'>
					
			<table class="table mb-0" title="즐겨찾기 목록">
				<thead>
					<tr>
						<th scope="col" class="border-0 bg-light">
							<div class="p-2 px-3">도서정보</div>
						</th>
						<th scope="col" class="border-0 bg-light text-center">
							<div class="py-2">가격</div>
						</th>
						<th scope="col" class="border-0 bg-light text-center">
							<div class="py-2">수량</div>
						</th>
						<th scope="col" class="border-0 bg-light text-center">
							<div class="py-2">합계</div>
						</th>
					</tr>
				</thead>
				
				<tbody>
					<c:if test="${empty list }">
						<tr><td colspan="4" class="text-center">장바구니에 등록된 상품이 없습니다.</td></tr>
					</c:if>
					<c:set var="sum" value="0"/>
					<c:if test="${!empty list }">
						<!-- 반복 시작 -->
						<c:forEach var="i" begin="0" end="${fn:length(list)-1}">
						<tr>
							<th scope="row">
								<div class="p-2">
									<input type="hidden" name="details[${i}].isbn" value="${list[i].isbn }">
									<input type="hidden" name="details[${i}].bookName" value="${list[i].bookName }">
									<input type="hidden" name="details[${i}].qty" value="${list[i].qty }">
									<input type="hidden" name="details[${i}].price" value="${list[i].price }">
									<label for="ck1"  style="display: initial;"><!-- 번호매기기 -->
										<img
											src="${infoList[i]['cover'] }"
											alt="${list[i].bookName}" width="70" class="img-fluid rounded shadow-sm">
									</label>
									
									<div class="ml-3 d-inline-block align-middle">
										<h5 class="mb-0">
											<c:set var="bookName" value="${list[i].bookName }"/>
											<c:if test="${fn:length(bookName)>30 }">
												<c:set var="bookName" value="${fn:substring(bookName, 0, 30)}<br>${fn:substring(bookName, 30,fn:length(bookName))}"/>
											</c:if>
											
											<a href="<c:url value='/book/bookDetail.do?ItemId=${list[i].isbn }'/>" 
													class="text-dark d-inline-block align-middle"><b class="bookName">${bookName }</b></a>
										</h5>
										<a href="<c:url value="/book/bookList.do?cateNo=${infoList[i]['cateCode']}"/>">
												<small class="text-muted font-italic d-block">
													카테고리 : ${infoList[i]['cateName']}
												</small>
										</a>
									</div>
									
								</div>
							</th>
							<td class="align-middle text-center">
								<strong><fmt:formatNumber value="${list[i].price }" pattern="#,###"/>원</strong>
							</td>
							<td class="align-middle text-center"><strong>${list[i].qty }</strong></td>
							<td class="align-middle text-center">
								<strong><fmt:formatNumber value="${list[i].price*list[i].qty }" pattern="#,###"/> 원</strong>
								<c:set var="sum" value="${sum+(list[i].price*list[i].qty) }"/>
								<c:if test="${!empty sessionScope.userid }">
									<br><small class="text-danger">${infoList[i]['mileage']*list[i].qty }p 적립예정</small>
								</c:if>
							</td>
						</tr>
						</c:forEach>
						<!-- 반복 끝 -->
					</c:if>
					
					<tr>
						<td colspan="3" class="text-right">
							<b>총 상품 금액 :<br>
							+ 배송비 :<br>
							<c:if test="${!empty sessionScope.userid }">
								<span class="text-danger limit">- 포인트 사용(${userVo.mileage }점 사용가능) : </span><br>
							</c:if>
							<span style="font-size: 1.5em;">총 결제 금액 :</span>
							</b>
							
						</td>
						<td class="text-center">
							<b class="text-right d-inline-block">
								<fmt:formatNumber value="${sum}" pattern="#,###"/>원<br>
								<c:if test="${sum>=30000 }">무료</c:if>
								<c:if test="${sum<30000 }">2,500원
									<c:set var="sum" value="${sum+2500}"/>
								</c:if>
								<br>
								<c:if test="${!empty sessionScope.userid }">
									<span class="text-danger">
									<input type="number" min="0" max="${userVo.mileage }"
										value="0" class="form-control text-right pr-0 text-danger"
										name="usePoint" style="width: 80px;height: 16px;" step="10">원</span><br>
								</c:if>
								<span style="font-size: 1.5em;" id="sum">
									<fmt:formatNumber value="${sum}" pattern="#,###"/>원
								</span>
								<input type="hidden" value="${sum}" name="price">
							</b>
						</td>
					</tr>
				</tbody>
			</table>
			<hr class="mt-0" style="border: 3px solid lightGray;width: 100%;">
			
			<c:if test="${!empty list}">
				<div class="container">
					<h3><i class="fa fa-truck"></i> 배송지 정보</h3>
					<c:if test="${!empty sessionScope.userid }">
						<div class="row">
							<div class="deliveryInfo header col-md-3">배송지 선택</div>
							<div class="deliveryInfo col-md-9 form-group">
								<label><input type="radio" name="ck" checked="checked" value="1">회원정보</label>&nbsp;
								<label><input type="radio" name="ck" value="2">새로운 주소</label>
							</div>
						</div>
					</c:if>
					<div class="row">
						<div class="deliveryInfo header col-md-3">수령인</div>
						<div class="deliveryInfo col-md-9">
							<input type="text" name="customerName" class="form-control" placeholder="수령인 이름">
						</div>
					</div>
					<div class="row">
						<div class="deliveryInfo header col-md-3">연락처</div>
						<div class="deliveryInfo col-md-9">
							<input type="text" name="hp" class="form-control" placeholder="'-'을 포함한 연락처">
							<span class="error text-danger" style="display: none;">'-'를 포함하여 올바른 연락처를 입력해주세요!</span>
						</div>
					</div>
					<div class="row">
						<div class="deliveryInfo header col-md-3">이메일 주소</div>
						<div class="deliveryInfo col-md-9 form-group">
							<input type="text" name="email1" class="form-control">&nbsp;@&nbsp;
							<input type="text" name="email2" class="form-control">
							&nbsp;
							<select name="email3" class="form-control">
								<option value="">직접입력</option>
								<option value="naver.com">naver.com</option>
								<option value="gmail.com">gmail.com</option>
								<option value="daum.net">daum.net</option>
							</select>
						</div>
					</div>
					<div class="row">
						<div class="deliveryInfo header col-md-3" style="line-height: 150px;">배송지</div>
						<div class="deliveryInfo col-md-9">
							<input type="text" name="zipcode" class="form-control mb-2" style="width: 30%;" placeholder="우편번호">
							<input type="button" id="btZip" value="우편번호 찾기" class="btn btn-primary mb-2">
							<input type="text" name="parselAddress" class="form-control mb-2" style="width: 100%;" placeholder="지번주소" readonly="readonly">
							<input type="text" name="newAddress" class="form-control mb-2" style="width: 100%;" placeholder="도로명주소" readonly="readonly">
							<input type="text" name="addressDetail" class="form-control" style="width: 100%;" placeholder="상세주소">
						</div>
					</div>
					<div class="row" style="border-bottom: 1px solid #dee2e6;">
						<div class="deliveryInfo header col-md-3">요청사항</div>
						<div class="deliveryInfo col-md-9">
							<input type="text" name="message" class="form-control" style="width: 100%;"
								placeholder="예)부재시 경비실에 맡겨주세요.">
						</div>
					</div>
					
				</div>
				
				<hr class="mt-4" style="border: 3px solid lightGray;width: 100%;">
				<div class="col-md-3">
					<h3><i class="fa fa-won-sign"></i> 결제수단</h3>
				</div>
				<div class="col-md-8 text-center instrumentDiv">
					<a href="#" class="btn btInstrument">
						<i class="fa fa-mobile-alt fa-2x"></i> <span>휴대폰</span>
					</a>
					<a href="#" class="btn btInstrument">
						<i class="fa fa-money-check-alt fa-2x"></i> <span>실시간 계좌이체</span>
					</a>
					<a href="#" class="btn btInstrument align-middle">
						<i class="fa fa-credit-card fa-2x"></i> <span>신용카드</span>
					</a>
					<a href="#" class="btn btInstrument">
						<img src="<c:url value="/resources/images/icons/samsungPayBlack.png"/>"
							width="35px;"> <span style="vertical-align: middle;">삼성페이</span>
					</a>
					<input type="hidden" name="instrument">
					<input type="hidden" name="payNo">
				</div>
				
				<hr class="mt-3" style="border: 3px solid lightGray;width: 100%;">
				<div class="text-center my-5" style="width: 100%;">
					<a href="<c:url value="/favorite/cart.do"/>" class="btn btn-light" style="border: 1px solid lightGray;">장바구니로 가기</a>
					<input type="submit" value="결제하기" class="btn btn-primary">
				</div>
				
				<input type="hidden" name="nonMember">
				<input type="hidden" name="progress" value="결제완료">
				<input type="hidden" id="useFul" value="${userVo.mileage }">
			</c:if>
			
			<c:if test="${empty list }">
				<div class="text-center my-5" style="width: 100%">
					<a href="<c:url value="#"/>" class="btn btn-light" style="border: 1px solid lightGray;">책 둘러보기</a>
					<a href="<c:url value="/favorite/cart.do"/>" class="btn btn-primary">장바구니로 가기</a>
				</div>
			</c:if>
		</form>
	</div>
</div>

<%@include file="../inc/bottom.jsp"%>