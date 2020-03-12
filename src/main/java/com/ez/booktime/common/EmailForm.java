package com.ez.booktime.common;

import java.text.DecimalFormat;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Component;

import com.ez.booktime.payment.model.PaymentDetailVO;
import com.ez.booktime.payment.model.PaymentVO;

@Component
public class EmailForm {
	private DecimalFormat df = new DecimalFormat("#,###");
	
	public String paymentResultForm(PaymentVO vo
			,List<Map<String, Object>> infoList, String addr) {
		String bootStrap = "<link rel=\"stylesheet\" href=\"https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css\" integrity=\"sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh\" crossorigin=\"anonymous\">"; 
		String jquery = "<script\r\n" + 
				"  src=\"https://code.jquery.com/jquery-3.4.1.js\"\r\n" + 
				"  integrity=\"sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU=\"\r\n" + 
				"  crossorigin=\"anonymous\"></script>";
		//적용 안됨..
		
		String payNo = vo.getPayNo();
		String param = "";
		if(!vo.getNonMember().equals("0")) {
			payNo=vo.getNonMember();
			param = payNo;
		}
		
		String str= jquery+bootStrap +
				"<div class=\"container mt-4\">" + 
				"	<div class=\"page-header text-center\">" + 
				"		<h2>구매해주셔서 감사합니다!</h2>" + 
				"		<small class=\"text-danger\">주문번호 : " + payNo + 
				"		</small><hr class=\"mb-0\">" + 
				"	</div>"+
				"<table class=\"table mb-0\" title=\"주문 결과\">"+
				"	<thead>" + 
				"			<tr>" + 
				"				<th scope=\"col\" class=\"border-0 bg-light\">" + 
				"					<div class=\"p-2 px-3\">도서정보</div>" + 
				"				</th>" + 
				"				<th scope=\"col\" class=\"border-0 bg-light text-center\">" + 
				"					<div class=\"py-2\">가격</div>" + 
				"				</th>" + 
				"				<th scope=\"col\" class=\"border-0 bg-light text-center\">" + 
				"					<div class=\"py-2\">수량</div>" + 
				"				</th>" + 
				"				<th scope=\"col\" class=\"border-0 bg-light text-center\">" + 
				"					<div class=\"py-2\">합계</div>" + 
				"				</th>" + 
				"			</tr>" + 
				"		</thead>"+
				"<tbody>";
		String arrStr = "";
		
		int sum = 0;
		int i = 0;
		for(PaymentDetailVO dVo :vo.getDetails()) {
			String bookName = dVo.getBookName();
			if(bookName.length()>30) {
				bookName = bookName.substring(0,30)+"<br>"+bookName.substring(30);
			}
			
			arrStr += "<tr>" + 
					"					<th scope=\"row\">" + 
					"						<div class=\"p-2\">" + 
					"							<label for=\"ck1\"  style=\"display: initial;\"><!-- 번호매기기 -->" + 
					"								<img" + 
					"									src=\""+infoList.get(i).get("cover")+"\"" + 
					"									alt=\""+dVo.getBookName()+"\" width=\"70\" class=\"img-fluid rounded shadow-sm\">" + 
					"							</label>" + 
					"							" + 
					"							<div class=\"ml-3 d-inline-block align-middle\">" + 
					"								<h5 class=\"mb-0\">" + 
					"									<b class=\"bookName\">"+bookName+"</b>" + 
					"								</h5>" + 
					"							</div>" + 
					"						</div>" + 
					"					</th>" + 
					"					<td class=\"align-middle text-center\">" + 
					"						<strong>"+df.format(dVo.getPrice())+"원</strong>" + 
					"					</td>" + 
					"					<td class=\"align-middle text-center\" style=\"text-align:center;\"><strong>"+dVo.getQty()+"</strong></td>" + 
					"					<td class=\"align-middle text-center\">" + 
					"						<strong>"+df.format((dVo.getPrice()*dVo.getQty()))+"원</strong>" + 
					"					</td>" + 
					"				</tr>";
			
			sum += (dVo.getPrice()*dVo.getQty());
			i++;
		}//for
		
		str += arrStr;
		
		String delivery = "2,500원";
		if(sum>=30000) {
			delivery="무료";
		}
		
		str += "<tr>" + 
				"				<td colspan=\"3\" class=\"text-right\">" + 
				"					<b>총 상품 금액 :<br>" + 
				"					+ 배송비 :<br>" + 
			"						<span class=\"text-danger limit\">- 사용 포인트 : </span><br>" + 
				"					<span style=\"font-size: 1.5em;\">총 결제 금액 :</span>" + 
				"					</b>" + 
				"				</td>" + 
				"				<td class=\"text-center\">" + 
				"					<b class=\"text-right d-inline-block\">" + 
										df.format(sum)+"원<br>" + delivery +
				"						<br>" + 
				"						<span class=\"text-danger\">"+df.format(vo.getUsePoint())+"원</span><br>" + 
				"						<span style=\"font-size: 1.5em;\" id=\"sum\">" + 
											df.format(vo.getPrice())+"원" + 
				"						</span>" + 
				"					</b>" + 
				"				</td>" + 
				"			</tr>" + 
				"		</tbody>" + 
				"	</table>" + 
				"</div>"+
				"<hr><div class=\"text-center\">"+
				"	<a class=\"btn btn-info\" href=\""+addr+"/payment/paymentList.do?payNo="+param+"\">주문내역 확인</a><br>"+
				"</div>";
		
		return str;
	}
	
}
