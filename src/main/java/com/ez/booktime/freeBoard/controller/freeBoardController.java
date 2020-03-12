package com.ez.booktime.freeBoard.controller;


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
import org.springframework.web.bind.annotation.ResponseBody;

import com.ez.booktime.common.PageNumber;
import com.ez.booktime.common.PaginationInfo;
import com.ez.booktime.common.SearchVO;
import com.ez.booktime.freeBoard.model.FreeBoardService;
import com.ez.booktime.freeBoard.model.FreeBoardVO;
import com.ez.booktime.reply.model.ReplyVO;

@Controller
@RequestMapping("/freeBoard")
public class freeBoardController {
	private static final Logger logger
		 = LoggerFactory.getLogger(freeBoardController.class);
	
	@Autowired
	private FreeBoardService boardService;
	
	@RequestMapping(value="/Write.do",method=RequestMethod.GET)
	public void freeBoardWrite_get(HttpSession session,
			Model model) {
		String userid=(String)session.getAttribute("userid");
		
		logger.info("자유게시판 글쓰기 화면");
		logger.info("아이디={}",userid);
		
		FreeBoardVO boardVo=boardService.selectById(userid);
		
		model.addAttribute("boardVo",boardVo);
	}
	
	@RequestMapping("/chkUser.do")
	public String freeBoardChkUser(HttpSession session,
			Model model) {
		String userid=(String)session.getAttribute("userid");
		logger.info("회원 여부 체크, 회원 아이디={}",userid);
		
		String msg="", url="";
		
		if(userid!=null && !userid.isEmpty()) {
			msg="자유게시판 글쓰기";
			url="/freeBoard/Write.do";
		}else {
			msg="회원만 자유게시판 글쓰기가 가능합니다. 이용시 가입 부탁드립니다.";
			url="/user/register.do";
		}
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		
		return "common/message";
	}
	
	@RequestMapping(value="/Write.do",method=RequestMethod.POST)
	public String freeBoardWrite_post(@ModelAttribute FreeBoardVO boardVo,
			HttpSession session,
			Model model) {
		
		String userid=(String)session.getAttribute("userid");
		
		boardVo.setCategory("자유");
		boardVo.setUserid(userid);
		
		logger.info("자유게시판 글쓰기 파라미터 boardVo={}",boardVo);
		
		String msg="", url="";
		int cnt=boardService.insertBoard(boardVo);
		logger.info("글등록 결과, cnt={}", cnt);
		
		if(cnt>0) {
			msg="글등록되었습니다.";
			url="/freeBoard/List.do";
		}else {
			msg="글등록 실패!";
			url="/freeBoard/Write.do";
		}
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		
		return "common/message";
	}
	
	
	@RequestMapping("/List2.do")
	public void freeBoardList(@ModelAttribute SearchVO searchVo,
			Model model) {
		//1
		logger.info("글 목록, 파라미터 searchVo={}",searchVo);
				
		//[1] 먼저 PaginationInfo객체를 생성하여 firstRecordIndex 값을 구한다
		PaginationInfo pagingInfo=new PaginationInfo();
		pagingInfo.setBlockSize(PageNumber.BLOCK_SIZE);
		pagingInfo.setRecordCountPerPage(PageNumber.RECORD_COUNT);
		pagingInfo.setCurrentPage(searchVo.getCurrentPage());
		
		//[2] searchVo에 recordCountPerPage와 firstRecordIndex를 셋팅한다
		searchVo.setRecordCountPerPage(PageNumber.RECORD_COUNT);
		searchVo.setFirstRecordIndex(pagingInfo.getFirstRecordIndex());
			
		logger.info("값 셋팅 후 searchVo={}", searchVo);
		
		List<FreeBoardVO> list=boardService.selectFreeBoardAll(searchVo);
		logger.info("자유게시판 리스트 크기={}",list.size());
		
		//[3] 레코드 개수 조회후 셋팅
		int totalRecord=boardService.selectTotalRecord(searchVo);
		logger.info("totalRecord={}", totalRecord);
				
		pagingInfo.setTotalRecord(totalRecord);
		
		model.addAttribute("list",list);
		model.addAttribute("pagingInfo", pagingInfo);
	}
	
	@RequestMapping("/Detail.do")
	public String freeBoardDetail(@RequestParam(defaultValue ="0") int boardNo,
			HttpSession session,
			Model model) {
		logger.info("자유게시판 글 상세보기 파라미터 boardNo={}",boardNo);
		String userid=(String)session.getAttribute("userid");
		
		if(boardNo==0) {
			model.addAttribute("msg"," 잘못된 url입니다.");
			model.addAttribute("msg"," 잘못된 url입니다.");
			
			return "common/message";
		}
		
		FreeBoardVO boardVo=boardService.selectByNo(boardNo);
		logger.info("상세보기 결과 boardVo={}",boardVo);
		
		model.addAttribute("boardVo",boardVo);
		model.addAttribute("chkid",userid);
		
		return "freeBoard/Detail";
	}
	

	@RequestMapping(value="/Edit.do", method=RequestMethod.GET)
	public String freeBoardEdit_get(@RequestParam(defaultValue ="0") int boardNo,
			Model model) {
		
		logger.info("자유게시판 글 수정하기  파라미터 boardNo={}",boardNo);
		
		if(boardNo==0) {
			model.addAttribute("msg"," 잘못된 url입니다.");
			model.addAttribute("msg"," 잘못된 url입니다.");
			
			return "common/message";
		}
		
		FreeBoardVO boardVo=boardService.selectByNo(boardNo);
		logger.info("상세보기 결과 boardVo={}",boardVo);
		
		model.addAttribute("boardVo",boardVo);
		
		return "freeBoard/Edit";
	}
	
	@RequestMapping(value="/Edit.do", method=RequestMethod.POST)
	public String freeBoardEdit_post(@ModelAttribute FreeBoardVO freeBoardVo,
			Model model) {
		logger.info("글 수정 파라미터 freeBoardVo={}",freeBoardVo);
		
		String msg="", url="";
		int cnt=boardService.updateBoard(freeBoardVo);
		logger.info("글수정 결과, cnt={}", cnt);
		
		if(cnt>0) {
			msg="게시글 수정 되었습니다.";
			url="/freeBoard/List.do";
		}else {
			msg="게시글 수정이 실패했습니다";
			url="/freeBoard/Edit.do?boardNo="+freeBoardVo.getBoardNo();
		}
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		
		return "common/message";
	}
	
	@RequestMapping("/Delete.do")
	public String freeBoardDelete(@RequestParam int boardNo,
			Model model) {
		logger.info("게시글 삭제 화면");
		
		String msg="", url="";
		int cnt=boardService.drawBoard(boardNo);
		logger.info("글수정 결과, cnt={}", cnt);
		
		if(cnt>0) {
			msg="게시글 삭제 되었습니다.";
			url="/freeBoard/List.do";
		}else {
			msg="게시글 삭제가 실패했습니다";
			url="/freeBoard/Detail.do?boardNo="+boardNo;
		}
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		
		return "common/message";
	}
	
	@RequestMapping("/List.do")
	public void AjaxList(Model model) {
		logger.info("목록");
	}
	
	@RequestMapping("/Tab1.do")
	public void boardList1(Model model) {
		
		String category="공지";
		logger.info("카테고리 선택 {}",category);
		
		List<FreeBoardVO> list=boardService.selectBoardByCate(category);
		logger.info("list 크기={}",list.size());

		model.addAttribute("list",list);
	}
	
	@RequestMapping("/Tab2.do")
	public void boardList2(Model model) {
		
		String category="이벤트";
		logger.info("카테고리 선택 {}",category);
		
		List<FreeBoardVO> list=boardService.selectBoardByCate(category);
		logger.info("list 크기={}",list.size());

		model.addAttribute("list",list);
	}
	
	@RequestMapping("/Tab3.do")
	public void boardList3(Model model) {
		
		String category="자유";
		logger.info("카테고리 선택 {}",category);
		
		List<FreeBoardVO> list=boardService.selectBoardByCate(category);
		logger.info("list 크기={}",list.size());

		model.addAttribute("list",list);
	}
}
