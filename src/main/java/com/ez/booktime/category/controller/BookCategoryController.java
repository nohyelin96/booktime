package com.ez.booktime.category.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ez.booktime.category.model.BookCategoryService;
import com.ez.booktime.category.model.BookCategoryVO;

@Controller
public class BookCategoryController {
	private static final Logger logger
		= LoggerFactory.getLogger(BookCategoryController.class);
	
	@Autowired
	private BookCategoryService bcService;
	
	@RequestMapping("/inc/categoryBar.do")
	public void categoryBar(Model model) {
		logger.info("카테고리 사이드 바");
		
		List<BookCategoryVO> list=bcService.selectCatgoryBar();
		logger.info("카테고리 제목 조회 결과, list.size={}", list.size());
		
		model.addAttribute("list", list);
	}
}
