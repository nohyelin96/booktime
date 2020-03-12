package com.ez.booktime.reply.model;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ReplyDAOMybatis implements ReplyDAO{
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	private String namespace="com.mybatis.mapper.reply.";
	
	@Override
	public int insertReply(ReplyVO replyVo) {
		return sqlSession.insert(namespace+"writeReply",replyVo);
	}

	@Override
	public List<ReplyVO> selectReplyList(int boardNo) {
		return sqlSession.selectList(namespace+"selectReplyByNo",boardNo);
	}

	@Override
	public int drawReply(int replyNo) {
		return sqlSession.update(namespace+"drawReply",replyNo);
	}

}
