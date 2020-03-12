package com.ez.booktime.payment.model;

public class PaymentDetailVO {
	//private String payNo;
	private String isbn;
	private String bookName;
	private int qty;
	private int price;
	
	public String getIsbn() {
		return isbn;
	}
	public void setIsbn(String isbn) {
		this.isbn = isbn;
	}
	public String getBookName() {
		return bookName;
	}
	public void setBookName(String bookName) {
		this.bookName = bookName;
	}
	public int getQty() {
		return qty;
	}
	public void setQty(int qty) {
		this.qty = qty;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	@Override
	public String toString() {
		return "PaymentDetailVO [isbn=" + isbn + ", bookName=" + bookName + ", qty=" + qty + ", price=" + price + "]";
	}
	
}
