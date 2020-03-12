package com.ez.booktime.admin.member.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.ez.booktime.freeBoard.model.FreeBoardService;
import com.ez.booktime.freeBoard.model.FreeBoardVO;

@Controller
@RequestMapping("/admin")
public class AdminBoardController {
	private static final Logger logger
	=LoggerFactory.getLogger(AdminBoardController.class);
	
	@Autowired
	private FreeBoardService boardService;
	
	@RequestMapping(value="/Write.do",method=RequestMethod.GET)
	public void adminBoardWrite_get(HttpSession session,
			Model model) {
		String userid=(String)session.getAttribute("useridA");
		
		logger.info("관리자 글쓰기 화면");
		logger.info("아이디={}",userid);
		
		FreeBoardVO boardVo=boardService.selectById(userid);
		
		model.addAttribute("boardVo",boardVo);
	}
	
	@RequestMapping(value="/Write.do",method=RequestMethod.POST)
	public String adminBoardWrite_post(@ModelAttribute FreeBoardVO boardVo,
			HttpSession session,
			Model model) {
		
		String userid=(String)session.getAttribute("userid");
		boardVo.setUserid(userid);
		
		logger.info("자유게시판 글쓰기 파라미터 boardVo={}",boardVo);
		
		String msg="", url="";
		int cnt=boardService.insertBoard(boardVo);
		logger.info("글등록 결과, cnt={}", cnt);
		
		if(cnt>0) {
			msg="글등록되었습니다.";
			url="/admin/adminBoard.do";
		}else {
			msg="글등록 실패!";
			url="/admin/adminBoard.do";
		}
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		
		return "common/message";
	}
	
	@RequestMapping("/adminBoard.do")
	public void adminBoardList(Model model) {
		logger.info("목록");
		
		List<FreeBoardVO> list=boardService.selectFreeBoard();
		logger.info("자유게시판 리스트 크기={}",list.size());
		
		model.addAttribute("list",list);
	}
	
	@RequestMapping("/Delete.do")
	public String adminBoardDelete(@RequestParam(required = false) int boardNo,
			Model model) {
		logger.info("게시글 삭제 화면");
		
		String msg="", url="";
		int cnt=boardService.drawBoard(boardNo);
		logger.info("글수정 결과, cnt={}", cnt);
		
		if(cnt>0) {
			msg="게시글 삭제 되었습니다.";
			url="/admin/adminBoard.do";
		}else {
			msg="게시글 삭제가 실패했습니다";
			url="/admin/adminBoard.do";
		}
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		
		return "common/message";
	}
}
