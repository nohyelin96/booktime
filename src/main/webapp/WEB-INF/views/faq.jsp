<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="inc/top.jsp" %>
<style>
.btn-blog {
    color: #ffffff;
    background-color: #37d980;
    border-color: #37d980;
    border-radius:0;
    margin-bottom:10px
}
.btn-blog:hover,
.btn-blog:focus,
.btn-blog:active,
.btn-blog.active,
.open .dropdown-toggle.btn-blog {
    color: white;
    background-color:#34ca78;
    border-color: #34ca78;
}
 h2{color:#1c1c1c;}
 .margin10{margin-bottom:10px; margin-right:10px;}
</style>  
  
  <%@include file="inc/categoryBar.jsp" %>
      
      <!-- Content Column -->
      <div class="col-lg-10 mb-4">
       <!-- Page Heading/Breadcrumbs -->
    <h1 class="mt-4 mb-3">FAQ
      <small>자주 묻는 질문</small>
    </h1>
	
	<br>
	<br>
<!--Accordion wrapper-->
<div class="accordion md-accordion" id="accordionEx" role="tablist" aria-multiselectable="true">

  <!-- Accordion card -->
  <div class="card">

    <!-- Card header -->
    <div class="card-header" role="tab" id="headingOne1">
      <a data-toggle="collapse" data-parent="#accordionEx" href="#collapseOne1" aria-expanded="true"
        aria-controls="collapseOne1">
        <h5 class="mb-0">
          #1 품절, 절판 상품은 구입할 수 없습니까? <i class="fas fa-angle-down rotate-icon"></i>
        </h5>
      </a>
    </div>

    <!-- Card body -->
    <div id="collapseOne1" class="collapse show" role="tabpanel" aria-labelledby="headingOne1"
      data-parent="#accordionEx">
      <div class="card-body">
       상품 페이지에 품절, 일시품절, 절판, 구판절판 등으로 표시된 상품은 현재로서는 구입하실 수 없는 상품이니 이점 양해하여 주십시오.
      </div>
    </div>

  </div>
  <!-- Accordion card -->

  <!-- Accordion card -->
  <div class="card">

    <!-- Card header -->
    <div class="card-header" role="tab" id="headingTwo2">
      <a class="collapsed" data-toggle="collapse" data-parent="#accordionEx" href="#collapseTwo2"
        aria-expanded="false" aria-controls="collapseTwo2">
        <h5 class="mb-0">
          #2 주문 후 입금 전(입금확인 전)인데, 언제쯤 배송됩니까? <i class="fas fa-angle-down rotate-icon"></i>
        </h5>
      </a>
    </div>

    <!-- Card body -->
    <div id="collapseTwo2" class="collapse" role="tabpanel" aria-labelledby="headingTwo2"
      data-parent="#accordionEx">
      <div class="card-body">
        주문완료 후 주문조회 페이지 상단의 주문처리 일정표로 확인하실 수 있습니다.
상품 준비예상일, 출고예상일 및 수령예상일 정보를 참고해주십시오.
단, 결제완료 상태를 전제로 한 일정이며, 입금 전이면 입금확인 완료(입금 후 약 30분-1시간 내 확인)후 해당 시점의 재고 유무, 각 배송사 집하마감 시간 경과 여부 등을 기준으로 주문처리 일정이 재계산되므로, 입금대기 상태의 일정과 달라질 수 있습니다. 입금완료 후 주문 일정을 반드시 참고해주시기 바랍니다.
또한, 상품 추가,배송지 혹은 배송방법 변경 등의 경우에도 상황에 따라 일정 변경이 발생될 수 있으므로 변경 후 새로 세팅된 일정을 참고하시기 바랍니다.
      </div>
    </div>

  </div>
  <!-- Accordion card -->

  <!-- Accordion card -->
  <div class="card">

    <!-- Card header -->
    <div class="card-header" role="tab" id="headingThree3">
      <a class="collapsed" data-toggle="collapse" data-parent="#accordionEx" href="#collapseThree3"
        aria-expanded="false" aria-controls="collapseThree3">
        <h5 class="mb-0">
          #3 수령예상일이 지났는데 아직 못 받았습니다. <i class="fas fa-angle-down rotate-icon"></i>
        </h5>
      </a>
    </div>

    <!-- Card body -->
    <div id="collapseThree3" class="collapse" role="tabpanel" aria-labelledby="headingThree3"
      data-parent="#accordionEx">
      <div class="card-body">
        출고완료 후 통상 1-2일 내에는 배송이 됩니다만, 배송 물량이 급증하거나 해당 지역의 배송 상황에 다른 문제가 있다면 예정일 보다 지연될 수 있습니다.
우선, 주문조회 후 해당 주문의 "배송상황추적"클릭 후 배송상황이나 영업소 확인을 해 보세요. 영업소에 의뢰하시면 자세한 안내와 배송 예상시점 등을 확인하실 수 있습니다.
영업소와의 연락이 어려운 경우에는 해당 주문 조회 후  미배송신고해 주시면 신속 배송 되도록 조치해드립니다.
      </div>
    </div>

  </div>
  
  <!-- Accordion card -->
    <!-- Card header -->
    <div class="card-header" role="tab" id="headingFour4">
      <a class="collapsed" data-toggle="collapse" data-parent="#accordionEx" href="#collapseFour4"
        aria-expanded="false" aria-controls="collapseFour4">
        <h5 class="mb-0">
          #4 입금했는데 왜 아직 "입금대기" 상태입니까? <i class="fas fa-angle-down rotate-icon"></i>
        </h5>
      </a>
    </div>

    <!-- Card body -->
    <div id="collapseFour4" class="collapse" role="tabpanel" aria-labelledby="headingFour4"
      data-parent="#accordionEx">
      <div class="card-body">
        주문내역서의 입금예정 정보(입금액/입금은행/입금자명)와 100% 동일하게 입금하셨다면 "입금 후 40분-1시간 내" 입금확인이 완료되고 주문처리 단계는 상품준비중으로 이행하며 상품 준비가 시작됩니다. 아직 입금확인 소요시간이 경과하지 않았다면 조금만 기다려주십시오.
단, 1시간 이상 지나도록 입금 확인이 안될 경우에는 주문내역서 입금예정 정보와 실제 입금 정보가 다른 경우인데요,. 이 경우 실제 입금내역 조회 후 1대1 고객상담>결제>입금신고 이용해 입금정보를 신고해주시면 신속히 확인해 드립니다.
      </div>
    </div>

  </div>
  
  <!-- Accordion card -->
    <!-- Card header -->
    <div class="card-header" role="tab" id="headingFive5">
      <a class="collapsed" data-toggle="collapse" data-parent="#accordionEx" href="#collapseFive5"
        aria-expanded="false" aria-controls="collapseFive5">
        <h5 class="mb-0">
          #5 마일리지를 주문에 사용하고 싶습니다. <i class="fas fa-angle-down rotate-icon"></i>
        </h5>
      </a>
    </div>

    <!-- Card body -->
    <div id="collapseFive5" class="collapse" role="tabpanel" aria-labelledby="headingFive5"
      data-parent="#accordionEx">
      <div class="card-body">
        마이페이지>마일리지에는 마일리지가 보관되어 있습니다. 주문접수 과정에서 결제페이지 상단 "추가할인 받기" 코너에서 보유하고 계신 내역 조회 및 사용이 가능합니다. 먼저 보유하시는 수단을 사용하시고 나머지 금액을 신용카드/온라인송금 등으로 추가 결제하시면 알뜰하게 구매하실 수 있습니다.
주문접수 이후 온라인송금 주문에 한해 주문에 반영하실 수 있습니다.
마일리지는 우선 "적립금"으로 전환하신 후 적립금 형태로 주문 결제에 사용 가능합니다. 마일리지는 10원이상 적립 후 적립금 전환이 가능합니다.
      </div>
    </div>

  </div>
  <!-- Accordion card -->    

</div>
<!-- Accordion wrapper -->  
	<div class="ml-3">
	찾으시는 질문이 없나요?
	<a href="inquiry/inquiryPage.do"> 1:1 문의하기</a>
	</div>
    </div>
 
</div>

</div>
  <!-- Footer -->
  <%@include file="inc/bottom.jsp" %>