package com.ez.booktime.reply.model;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ReplyServiceImpl implements ReplyService{
	
	@Autowired
	private ReplyDAO replyDao;
	
	@Override
	public int insertReply(ReplyVO replyVo) {
		return replyDao.insertReply(replyVo);
	}

	@Override
	public List<ReplyVO> selectReplyList(int boardNo) {
		return replyDao.selectReplyList(boardNo);
	}

	@Override
	public int drawReply(int replyNo) {
		return replyDao.drawReply(replyNo);
	}

}
