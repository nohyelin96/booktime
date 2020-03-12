package com.ez.booktime.admin.recommend.model;

import java.util.List;

import com.ez.booktime.favorite.model.FavoriteVO;

public class RecommendVO {
	private int recombookNo;
	private String isbn;
	private int catecode;
	private String bookName;
	private int price;
	private String publisher;
	private String writer;
	private String managerId;
	private String cover;

	public int getRecombookNo() {
		return recombookNo;
	}

	public void setRecombookNo(int recombookNo) {
		this.recombookNo = recombookNo;
	}

	public String getIsbn() {
		return isbn;
	}

	public void setIsbn(String isbn) {
		this.isbn = isbn;
	}

	public int getCatecode() {
		return catecode;
	}

	public void setCatecode(int catecode) {
		this.catecode = catecode;
	}

	public String getBookName() {
		return bookName;
	}

	public void setBookName(String bookName) {
		this.bookName = bookName;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public String getPublisher() {
		return publisher;
	}

	public void setPublisher(String publisher) {
		this.publisher = publisher;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public String getManagerId() {
		return managerId;
	}

	public void setManagerId(String managerId) {
		this.managerId = managerId;
	}

	public String getCover() {
		return cover;
	}

	public void setCover(String cover) {
		this.cover = cover;
	}

	@Override
	public String toString() {
		return "RecommendVO [recombookNo=" + recombookNo + ", isbn=" + isbn + ", catecode=" + catecode + ", bookName="
				+ bookName + ", price=" + price + ", publisher=" + publisher + ", writer=" + writer + ", managerId="
				+ managerId + ", cover=" + cover+"]";
	}	
	
}
