package com.ez.booktime.reply.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ez.booktime.reply.model.ReplyService;
import com.ez.booktime.reply.model.ReplyVO;

@Controller
@RequestMapping("/freeBoard/reply")
public class ReplyController {
	private static final Logger logger
	 = LoggerFactory.getLogger(ReplyController.class);
	
	@Autowired
	private ReplyService replyService;
	
	@RequestMapping("/replyWrite.do")
	@ResponseBody
	public String replyInput(@ModelAttribute ReplyVO replyVo,
			HttpSession session,
			Model model) {
		
		String userid=(String)session.getAttribute("userid");
		logger.info("회원 여부 체크, 회원 아이디={}",userid);
		
		replyVo.setUserid(userid);
		replyVo.setStep('1');
		
		logger.info("값 세팅 후 replyVo={}",replyVo);
		
		int cnt=replyService.insertReply(replyVo);
		logger.info("글등록 결과, cnt={}", cnt);
		String result="";
		
		if(cnt>0) {
			result="성공";
			System.out.println("댓글 입력 성공");
		}else {
			result="";
			System.out.println("댓글 입력 실패");
		}
		return result; 
	}
	
	@RequestMapping("/replyList.do")
	@ResponseBody
	public List<ReplyVO> replyList(@ModelAttribute ReplyVO replyVo,
			Model model) {
		logger.info("댓글 목록 화면");
		
		int boardNo=replyVo.getBoardNo();
		
		List<ReplyVO> list=replyService.selectReplyList(boardNo);
		logger.info("list 크기={}",list.size());

		return list;
	}
	
	@RequestMapping("/replyWrite2.do")
	@ResponseBody
	public String replyUpdate(@ModelAttribute ReplyVO replyVo,
			HttpSession session,
			Model model) {

		String userid=(String)session.getAttribute("userid");
		logger.info("회원 여부 체크, 회원 아이디={}",userid);
		
		replyVo.setUserid(userid);
		replyVo.setStep('2');
		
		logger.info("값 세팅 후 replyVo={}",replyVo);
		
		int cnt=replyService.insertReply(replyVo);
		logger.info("글등록 결과, cnt={}", cnt);
		String result="";
		
		if(cnt>0) {
			result="성공";
			System.out.println("댓글 입력 성공");
		}else {
			result="";
			System.out.println("댓글 입력 실패");
		}
		return result; 
	}
	
	@RequestMapping("/replyDelete.do")
	@ResponseBody
	public String drawReply(@ModelAttribute ReplyVO replyVo,
			Model model) {
		
		int replyNo=replyVo.getReplyNo();
		logger.info("replyNo={}",replyNo);
		
		int cnt=replyService.drawReply(replyNo);
		logger.info("글등록 결과, cnt={}", cnt);
		String result="";
		
		if(cnt>0) {
			result="성공";
			System.out.println("댓글 삭제 성공");
		}else {
			result="";
			System.out.println("댓글 삭제 실패");
		}
		return result; 
	}
}
