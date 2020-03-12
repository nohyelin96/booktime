package com.ez.booktime.freeBoard.model;

import java.sql.Timestamp;

import com.ez.booktime.common.SearchVO;

public class FreeBoardVO extends SearchVO{
	private int boardNo; //게시글번호
	private String userid; //아이디
	private String category; //카테고리
	private String title; //제목
	private String content; //내용
	private Timestamp regdate; //작성일
	private String filename; //파일이름
	private String originalFilename; //원래 파일 이름
	private long filesize; //파일크기
	private Timestamp deleteDate; //삭제일
	private String name; //작성자 이름
	private String qType; //문의 유형
	
	public int getBoardNo() {
		return boardNo;
	}
	public void setBoardNo(int boardNo) {
		this.boardNo = boardNo;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Timestamp getRegdate() {
		return regdate;
	}
	public void setRegdate(Timestamp regdate) {
		this.regdate = regdate;
	}
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
	public String getOriginalFilename() {
		return originalFilename;
	}
	public void setOriginalFilename(String originalFilename) {
		this.originalFilename = originalFilename;
	}
	public long getFilesize() {
		return filesize;
	}
	public void setFilesize(long filesize) {
		this.filesize = filesize;
	}
	public Timestamp getDeleteDate() {
		return deleteDate;
	}
	public void setDeleteDate(Timestamp deleteDate) {
		this.deleteDate = deleteDate;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getqType() {
		return qType;
	}
	public void setqType(String qType) {
		this.qType = qType;
	}
	
	@Override
	public String toString() {
		return "FreeBoardVO [boardNo=" + boardNo + ", userid=" + userid + ", category=" + category + ", title=" + title
				+ ", content=" + content + ", regdate=" + regdate + ", filename=" + filename + ", originalFilename="
				+ originalFilename + ", filesize=" + filesize + ", deleteDate=" + deleteDate + ", name=" + name
				+ ", qType=" + qType + ", toString()=" + super.toString() + "]";
	}
	
	
}
