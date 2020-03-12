package com.ez.booktime.book.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ez.booktime.api.AladinAPI;
import com.ez.booktime.category.model.BookCategoryService;
import com.ez.booktime.category.model.BookCategoryVO;
import com.ez.booktime.freeBoard.controller.UploadController;
import com.ez.booktime.freeBoard.model.FreeBoardService;
import com.ez.booktime.freeBoard.model.FreeBoardVO;
import com.ez.booktime.inquiry.model.BoardVO;

@Controller
@RequestMapping("/book")
public class BookContoller {
	private static final Logger logger
		= LoggerFactory.getLogger(BookContoller.class);
	
	@Autowired
	private AladinAPI aladinApi;
	
	@Autowired
	private BookCategoryService cateService;
	
	@Autowired
	private BookGradeService gradeSerivce;
	
	@Autowired
	private FreeBoardService boardService;
	
	@Autowired
	private UploadController ckEdior;
	
	@RequestMapping("/bookDetail.do")
	public String productDetail(@RequestParam(required = false) String ItemId, Model model) {
		logger.info("상품 디테일 파라미터 isbn13={}",ItemId);
		
		if(ItemId==null || ItemId.isEmpty()) {
			model.addAttribute("msg", "잘못된 URL입니다");
			model.addAttribute("url", "/index.do");
			
			return "common/message";
		}
		
		Map<String, Object> map = null;
		try {
			 map = aladinApi.selectBook(ItemId);
			 
			 String cateName = (String)map.get("cateName");
			 BookCategoryVO cateVo = cateService.selectCategoryInfoByName(cateName);
			 
			 map.put("cateCode", cateVo.getCateCode());
			 
			 logger.info("상품 상세보기 결과 map={}",map);
			 
			 
			 
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		FreeBoardVO bVo = new FreeBoardVO();
		bVo.setCategory(ItemId);
		int reviewCnt = boardService.countReviews(bVo);
		
		List<Map<String, Object>> eventList = ckEdior.getEventMapList(150);
		
		model.addAttribute("map", map);
		model.addAttribute("reviewCnt", reviewCnt);
		model.addAttribute("eventList", eventList);
		
		return "book/bookDetail";
	}
	
	@RequestMapping("/bookGrade.do")
	public void productGrade(@ModelAttribute BookGradeVO vo
			, Model model) {
		logger.info("회원 리뷰 평점 보여주기, 파라미터 vo={}",vo);
		
		float grade = gradeSerivce.gradeByIsbn(vo);
		logger.info("회원id={}의 평점={}",vo.getUserid(),grade);
		
		model.addAttribute("grade", grade);
	}
	
	@RequestMapping("/bookGradeAvg.do")
	public String productGradeAvg(@ModelAttribute BookGradeVO vo
			,Model model) {
		logger.info("평점 평균 보여주기, 파라미터 vo={}",vo);
		
		float grade = gradeSerivce.gradeByIsbn(vo);
		logger.info("현재 isbn={}의 평점평균={}",vo.getIsbn(),grade);
		
		model.addAttribute("grade", grade);
		
		return "book/bookGrade";
	}
	
	@RequestMapping("/bookGradePicker.do")
	public void productGradePicker() {
		logger.info("평점 picker 보여주기");
	}
}
