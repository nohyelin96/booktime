package com.ez.booktime.controller;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;

import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ez.booktime.admin.recommend.model.RecommendService;
import com.ez.booktime.admin.recommend.model.RecommendVO;
import com.ez.booktime.api.AladinAPI;

@Controller
public class IndexController {
	private static final Logger logger
		=LoggerFactory.getLogger(IndexController.class);
	
	@Autowired
	private RecommendService recommendService;

	@RequestMapping("/index.do")
	public String index(Model model) {
		logger.info("index 화면 보여주기");
		
		//받아오는 데이터 양
		int start=1;
		int maxResult=8;
				
		Category category=new Category();
		List<Map<String, Object>> list = null;
		try {
			list = category.AllBestsellerList(start, maxResult);
		} catch (Exception e) {
			e.printStackTrace();
		}
		logger.info("베스트셀러 리스트, list.size={}",list.size());
		
		List<RecommendVO> list2=recommendService.selectRecommend();
		logger.info("추천도서 리스트, list.size={}",list.size());
		
		model.addAttribute("list", list);
		model.addAttribute("list2", list2);
				
		return "index";
	}
	
	@RequestMapping("/new.do")
	public void mainNewBook() throws Exception {
		logger.info("신간도서");
		/*	
		//받아오는 데이터 양
		int start=1;
		int maxResult=8;
		
		Category category=new Category();
		List<Map<String, Object>> list=category.AllNewList(start, maxResult);
		logger.info("신간도서 리스트, list.size={}",list.size());
		
		model.addAttribute("list", list);
	*/	
	}
	
	@RequestMapping("/category.do")
	public String categoryList(@RequestParam(defaultValue="0")
	int cateNo 
	, @RequestParam(defaultValue = "1") int start
	, @RequestParam(defaultValue = "20") int maxResult,
	Model model) throws Exception {
		logger.info("카테고리 번호={}",cateNo);
		
		Category category=new Category();
		List<Map<String, Object>> list=category.categoryFind(cateNo, start, maxResult);
		logger.info("카테고리 검색 리스트 크기={}",list.size());
		
		model.addAttribute("list",list);
		
		return "category";
	}
	
	@RequestMapping("/search.do")
	public String showSearchResult(@RequestParam(defaultValue="0")
	String searchKeyword, Model model) throws Exception{
		logger.info("검색어 searchKeyword={}",searchKeyword);

		return "searchList";
	}
	
	@RequestMapping("/faq.do")
	public void showFAQ() {
		logger.info("자주 묻는 질문");
	}
}
