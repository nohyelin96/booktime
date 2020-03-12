package com.ez.booktime.favorite.model;

import java.sql.Timestamp;
import java.util.List;

public class FavoriteVO {
	private int favoriteNo;
	private String userid;
	private String group;
	private String isbn;
	private String bookName;
	private String writer;
	private String publisher;
	private int price;
	private int qty;
	private Timestamp regdate;
	
	private List<FavoriteVO> voList;
	//name = voList[i].favoriteNo
	//Controller => @modelAttribute FavoriteVO
	
	public int getFavoriteNo() {
		return favoriteNo;
	}
	public void setFavoriteNo(int favoriteNo) {
		this.favoriteNo = favoriteNo;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getGroup() {
		return group;
	}
	public void setGroup(String group) {
		this.group = group;
	}
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
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getPublisher() {
		return publisher;
	}
	public void setPublisher(String publisher) {
		this.publisher = publisher;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public int getQty() {
		return qty;
	}
	public void setQty(int qty) {
		this.qty = qty;
	}
	public Timestamp getRegdate() {
		return regdate;
	}
	public void setRegdate(Timestamp regdate) {
		this.regdate = regdate;
	}
	
	
	
	public List<FavoriteVO> getVoList() {
		return voList;
	}
	public void setVoList(List<FavoriteVO> voList) {
		this.voList = voList;
	}
	@Override
	public String toString() {
		return "FavoriteVO [favoriteNo=" + favoriteNo + ", userid=" + userid + ", group=" + group + ", isbn=" + isbn
				+ ", bookName=" + bookName + ", writer=" + writer + ", publisher=" + publisher + ", price=" + price
				+ ", qty=" + qty + ", regdate=" + regdate + ", voList=" + voList + "]";
	}
	
	
}
