package com.ez.booktime.reply.model;

import java.sql.Timestamp;

import org.springframework.format.annotation.DateTimeFormat;

import com.ez.booktime.freeBoard.model.FreeBoardVO;

public class ReplyVO{
	private int replyNo;
	private int boardNo;
	private String userid;
	private String replyContent;
	
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private Timestamp replyRegdate;
	private int groupNo;
	private char step;
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private Timestamp replyDeleteDate;
	
	public int getReplyNo() {
		return replyNo;
	}
	public void setReplyNo(int replyNo) {
		this.replyNo = replyNo;
	}
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
	public String getReplyContent() {
		return replyContent;
	}
	public void setReplyContent(String replyContent) {
		this.replyContent = replyContent;
	}
	public Timestamp getReplyRegdate() {
		return replyRegdate;
	}
	public void setReplyRegdate(Timestamp replyRegdate) {
		this.replyRegdate = replyRegdate;
	}
	public int getGroupNo() {
		return groupNo;
	}
	public void setGroupNo(int groupNo) {
		this.groupNo = groupNo;
	}
	public char getStep() {
		return step;
	}
	public void setStep(char step) {
		this.step = step;
	}
	public Timestamp getReplyDeleteDate() {
		return replyDeleteDate;
	}
	public void setReplyDeleteDate(Timestamp replyDeleteDate) {
		this.replyDeleteDate = replyDeleteDate;
	}
	
	@Override
	public String toString() {
		return "ReplyVO [replyNo=" + replyNo + ", boardNo=" + boardNo + ", userid=" + userid + ", replyContent="
				+ replyContent + ", replyRegdate=" + replyRegdate + ", groupNo=" + groupNo + ", step=" + step
				+ ", replyDeleteDate=" + replyDeleteDate + "]";
	}
	
}
