package com.ez.booktime.payment.model;

import java.sql.Timestamp;
import java.util.List;

public class PaymentVO {
	private String payNo;
	private String userid;
	private String email1;
	private String email2;
	private String nonMember;
	private int price;
	private int usePoint;
	private Timestamp payDate;
	private Timestamp cancleDate;
	private String instrument;
	private String zipcode;
	private String parselAddress;
	private String newAddress;
	private String addressDetail;
	private String progress;
	private String customerName;
	private String message;
	private String hp;
	
	private List<PaymentDetailVO> details;
	
	private List<PaymentVO> voList;
	
	public String getPayNo() {
		return payNo;
	}
	public void setPayNo(String payNo) {
		this.payNo = payNo;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getEmail1() {
		return email1;
	}
	public void setEmail1(String email1) {
		this.email1 = email1;
	}
	public String getEmail2() {
		return email2;
	}
	public void setEmail2(String email2) {
		this.email2 = email2;
	}
	public String getNonMember() {
		return nonMember;
	}
	public void setNonMember(String nonMember) {
		this.nonMember = nonMember;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public int getUsePoint() {
		return usePoint;
	}
	public void setUsePoint(int usePoint) {
		this.usePoint = usePoint;
	}
	public Timestamp getPayDate() {
		return payDate;
	}
	public void setPayDate(Timestamp payDate) {
		this.payDate = payDate;
	}
	public Timestamp getCancleDate() {
		return cancleDate;
	}
	public void setCancleDate(Timestamp cancleDate) {
		this.cancleDate = cancleDate;
	}
	public String getInstrument() {
		return instrument;
	}
	public void setInstrument(String instrument) {
		this.instrument = instrument;
	}
	public String getZipcode() {
		return zipcode;
	}
	public void setZipcode(String zipcode) {
		this.zipcode = zipcode;
	}
	public String getParselAddress() {
		return parselAddress;
	}
	public void setParselAddress(String parselAddress) {
		this.parselAddress = parselAddress;
	}
	public String getNewAddress() {
		return newAddress;
	}
	public void setNewAddress(String newAddress) {
		this.newAddress = newAddress;
	}
	public String getProgress() {
		return progress;
	}
	public void setProgress(String progress) {
		this.progress = progress;
	}
	public String getCustomerName() {
		return customerName;
	}
	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public String getHp() {
		return hp;
	}
	public void setHp(String hp) {
		this.hp = hp;
	}
	public List<PaymentDetailVO> getDetails() {
		return details;
	}
	public void setDetails(List<PaymentDetailVO> details) {
		this.details = details;
	}
	
	public String getAddressDetail() {
		return addressDetail;
	}
	public void setAddressDetail(String addressDetail) {
		this.addressDetail = addressDetail;
	}
	
	
	public List<PaymentVO> getVoList() {
		return voList;
	}
	public void setVoList(List<PaymentVO> voList) {
		this.voList = voList;
	}
	
	@Override
	public String toString() {
		return "PaymentVO [payNo=" + payNo + ", userid=" + userid + ", email1=" + email1 + ", email2=" + email2
				+ ", nonMember=" + nonMember + ", price=" + price + ", usePoint=" + usePoint + ", payDate=" + payDate
				+ ", cancleDate=" + cancleDate + ", instrument=" + instrument + ", zipcode=" + zipcode
				+ ", parselAddress=" + parselAddress + ", newAddress=" + newAddress + ", addressDetail=" + addressDetail
				+ ", progress=" + progress + ", customerName=" + customerName + ", message=" + message + ", hp=" + hp
				+ ", details=" + details + ", voList=" + voList + "]";
	}
	
}
