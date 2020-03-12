package com.ez.booktime.review.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
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

import com.ez.booktime.book.controller.BookGradeService;
import com.ez.booktime.book.controller.BookGradeVO;
import com.ez.booktime.common.FileUploadUtil;
import com.ez.booktime.common.PaginationInfo;
import com.ez.booktime.freeBoard.model.FreeBoardService;
import com.ez.booktime.freeBoard.model.FreeBoardVO;
import com.ez.booktime.payment.model.PaymentService;

@Controller
@RequestMapping("/review")
public class ReviewController {
	private static final Logger logger
		= LoggerFactory.getLogger(ReviewController.class);
	
	@Autowired
	private FileUploadUtil uploadUtil;
	
	@Autowired
	private FreeBoardService boardService;
	
	@Autowired
	private PaymentService paymentService;
	
	
	@RequestMapping(value = "/review.do", method = RequestMethod.GET)
	public void review_get(@RequestParam("ItemId") String isbn
//			, @RequestParam(defaultValue = "1") int currentPage
//			, @RequestParam String searchCondition
			, @ModelAttribute FreeBoardVO bVo
			, HttpSession session
			, Model model) {
		String userid = (String)session.getAttribute("userid");
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("isbn", isbn);
		map.put("userid", userid);
		
		logger.info("리뷰 불러오기, 파라미터 map={}, bVo={}", map,bVo);
		
		int pCnt = 0;
		int rCnt = 0;
		if(userid!=null && !userid.isEmpty()) {
			pCnt = paymentService.countPaymentByIsbn(map); //구입 기록 개수
			rCnt = boardService.countReview(map); //리뷰 작성 횟수
		}
		
		//페이징과 리뷰리스트
//		FreeBoardVO bVo = new FreeBoardVO();
		bVo.setUserid(userid);
		bVo.setCategory(isbn);
		
		int blockSize = 10;
		int recordCountPerPage = 6;
		
		PaginationInfo pagingInfo = new PaginationInfo();
		pagingInfo.setBlockSize(blockSize);
		pagingInfo.setCurrentPage(bVo.getCurrentPage());
		pagingInfo.setRecordCountPerPage(recordCountPerPage);
		
		bVo.setFirstRecordIndex(pagingInfo.getFirstRecordIndex());
		bVo.setLastRecordIndex(pagingInfo.getLastRecordIndex());
		bVo.setRecordCountPerPage(recordCountPerPage);
		
		pagingInfo.setTotalRecord(boardService.countReviews(bVo));
		
		List<FreeBoardVO> list = new ArrayList<FreeBoardVO>();
		logger.info("세팅 후 bVo={}",bVo);
		list = boardService.selectReviews(bVo);
		
		logger.info("리뷰 불러오기 결과, 구입cnt={}, 리뷰cnt={}", pCnt,rCnt);
		logger.info("list.size={}", list.size());
		logger.info("firstRecordIndex={}, lastRecordIndex={}"
				, pagingInfo.getFirstRecordIndex(), pagingInfo.getLastRecordIndex());
		
		model.addAttribute("myPaymentCount", pCnt);
		model.addAttribute("myReviewCount", rCnt);
		model.addAttribute("list", list);
		model.addAttribute("pagingInfo", pagingInfo);
		
	}
	
	@RequestMapping(value = "/review.do", method = RequestMethod.POST)
	public String review_post(@ModelAttribute BookGradeVO gVo
			,@ModelAttribute FreeBoardVO bVo
			,HttpServletRequest request
			,HttpSession session
			,Model model) {
		String userid = (String)session.getAttribute("userid");
		String name = (String)session.getAttribute("name");
		gVo.setUserid(userid);
		bVo.setUserid(userid);
		bVo.setName(name);
		logger.info("리뷰 등록 처리, 파라미터 gradeVo={}, boardVo={}",gVo, bVo);
		
		List<Map<String, Object>> list = uploadUtil.fileUpload(request, FileUploadUtil.REVIEW_IMG_UPLOAD);
		if(list!=null && !list.isEmpty()) {
			bVo.setOriginalFilename((String)list.get(0).get("originalFileName"));
			bVo.setFilename((String)list.get(0).get("fileName"));
			bVo.setFilesize((Long)list.get(0).get("fileSize"));
		}
		
		int cnt = boardService.writeReview(bVo, gVo);
		
		String msg = "리뷰 작성에 실패하였습니다.", url="/book/bookDetail.do?ItemId="
				+gVo.getIsbn()+"&mode=review";
		if(cnt>0) {
			msg = "소중한 리뷰 감사합니다.";
		}else {
			File file = new File(uploadUtil.getFilePath(request, FileUploadUtil.REVIEW_IMG_UPLOAD), bVo.getFilename());
			
			if(file.exists()) {
				file.delete();
			}
		}
		
		model.addAttribute("msg",msg);
		model.addAttribute("url",url);
		
		return "common/message";
	}
	
}
