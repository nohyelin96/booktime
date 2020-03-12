package com.ez.booktime.book.controller;

public class BookGradeVO {
	private int bookGradeNo;
	private String userid;
	private String isbn;
	private int bookGrade;
	private int boardNo;
	
	public int getBookGradeNo() {
		return bookGradeNo;
	}
	public void setBookGradeNo(int bookGradeNo) {
		this.bookGradeNo = bookGradeNo;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getIsbn() {
		return isbn;
	}
	public void setIsbn(String isbn) {
		this.isbn = isbn;
	}
	public int getBookGrade() {
		return bookGrade;
	}
	public void setBookGrade(int bookGrade) {
		this.bookGrade = bookGrade;
	}
	public int getBoardNo() {
		return boardNo;
	}
	public void setBoardNo(int boardNo) {
		this.boardNo = boardNo;
	}
	
	@Override
	public String toString() {
		return "BookGradeVO [bookGradeNo=" + bookGradeNo + ", userid=" + userid + ", isbn=" + isbn + ", bookGrade="
				+ bookGrade + ", boardNo=" + boardNo + "]";
	}
	
}
