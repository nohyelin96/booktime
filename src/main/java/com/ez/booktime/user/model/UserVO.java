package com.ez.booktime.user.model;

import java.sql.Timestamp;

public class UserVO {
	private String userid;
	private String pwd;
	private String name;
	private String birth;
	private String gender;
	private String grade; //등급
	private String email1;
	private String email2;
	private char emailagree; 
	private String zipcode;
	private String parseladdress; //지번주소
	private String newaddress; //도로명
	private String addressdetail;
	private String phone;
	private int mileage;
	private Timestamp withdrawaldate; //탈퇴일
	private String withdrawalreason; //탈퇴사유
	
	public UserVO() {
		super();
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getBirth() {
		return birth;
	}

	public void setBirth(String birth) {
		this.birth = birth;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getGrade() {
		return grade;
	}

	public void setGrade(String grade) {
		this.grade = grade;
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

	public char getEmailagree() {
		return emailagree;
	}

	public void setEmailagree(char emailagree) {
		this.emailagree = emailagree;
	}

	public String getZipcode() {
		return zipcode;
	}

	public void setZipcode(String zipcode) {
		this.zipcode = zipcode;
	}

	public String getParseladdress() {
		return parseladdress;
	}

	public void setParseladdress(String parseladdress) {
		this.parseladdress = parseladdress;
	}

	public String getNewaddress() {
		return newaddress;
	}

	public void setNewaddress(String newaddress) {
		this.newaddress = newaddress;
	}

	public String getAddressdetail() {
		return addressdetail;
	}

	public void setAddressdetail(String addressdetail) {
		this.addressdetail = addressdetail;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public int getMileage() {
		return mileage;
	}

	public void setMileage(int mileage) {
		this.mileage = mileage;
	}


	public Timestamp getWithdrawaldate() {
		return withdrawaldate;
	}

	public void setWithdrawaldate(Timestamp withdrawaldate) {
		this.withdrawaldate = withdrawaldate;
	}

	public String getWithdrawalreason() {
		return withdrawalreason;
	}

	public void setWithdrawalreason(String withdrawalreason) {
		this.withdrawalreason = withdrawalreason;
	}

	@Override
	public String toString() {
		return "UserVO [userid=" + userid + ", pwd=" + pwd + ", name=" + name + ", birth=" + birth + ", gender="
				+ gender + ", grade=" + grade + ", email1=" + email1 + ", email2=" + email2 + ", emailagree="
				+ emailagree + ", zipcode=" + zipcode + ", parseladdress=" + parseladdress + ", newaddress="
				+ newaddress + ", addressdetail=" + addressdetail + ", phone=" + phone + ", mileage=" + mileage
				+ ", withdrawaldate=" + withdrawaldate + ", withdrawalreason=" + withdrawalreason + "]";
	}

}
