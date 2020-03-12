package com.ez.booktime.reply.model;

import java.util.List;

public interface ReplyService {
	int insertReply(ReplyVO replyVo);
	List<ReplyVO> selectReplyList(int boardNo);
	int drawReply(int replyNo);
}
