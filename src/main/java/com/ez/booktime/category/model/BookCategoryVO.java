package com.ez.booktime.category.model;

public class BookCategoryVO {
	private int cateCode;
	private String cateName;
	private String mall;
	private int orderNo;
	
	public int getCateCode() {
		return cateCode;
	}
	public void setCateCode(int cateCode) {
		this.cateCode = cateCode;
	}
	public String getCateName() {
		return cateName;
	}
	public void setCateName(String cateName) {
		this.cateName = cateName;
	}
	public String getMall() {
		return mall;
	}
	public void setMall(String mall) {
		this.mall = mall;
	}
	public int getOrderNo() {
		return orderNo;
	}
	public void setOrderNo(int orderNo) {
		this.orderNo = orderNo;
	}
	@Override
	public String toString() {
		return "BookCategoryVO [cateCode=" + cateCode + ", cateName=" + cateName + ", mall=" + mall + ", orderNo="
				+ orderNo + "]";
	}
	
	
}
