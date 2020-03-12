package com.ez.booktime.admin.recommend.controller;

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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ez.booktime.admin.recommend.model.RecommendService;
import com.ez.booktime.admin.recommend.model.RecommendVO;
import com.ez.booktime.api.AladinAPI;
import com.ez.booktime.common.PaginationInfo;
import com.ez.booktime.controller.Category;
import com.ez.booktime.reply.model.ReplyVO;

@Controller
@RequestMapping("/admin")
public class AdminRecommendBookController {
	private static final Logger logger
	=LoggerFactory.getLogger(AdminRecommendBookController.class);
	
	@Autowired
	private RecommendService recommendService;
	
	@RequestMapping("/adminRe.do")
	public void adminRe(Model model) {
		logger.info("관리자 노출관리 화면 보여주기");
		
		List<RecommendVO> list=recommendService.selectRecommend();
		logger.info("list크기={}",list.size());
		
		model.addAttribute("list",list);
	}
	
	@RequestMapping("/adminRecomand")
	public String recomandBookSearch_post(@RequestParam(required=false) String title,
			@RequestParam(defaultValue = "1") int start,
			@RequestParam(defaultValue = "10") int maxResults,
			Model model) {

		logger.info("검색어={}", title);
		
		PaginationInfo pagingInfo=new PaginationInfo();
		
		String searchKeyword=title;
		
		if(title!=null && !title.isEmpty()) {
			AladinAPI api=new AladinAPI();
			List<Map<String, Object>> list=null;
			try {
				list = api.searchByTitle(searchKeyword, start, maxResults);
			} catch (Exception e) {
				e.printStackTrace();
			}
			logger.info("검색 리스트, list.size={}",list.size());
			
			int total = 0;
			
			String totalStr = list.get(0).get("totalResult").toString();
			logger.info(totalStr);
			if(totalStr!=null && !totalStr.isEmpty()) {
				total = Integer.parseInt(totalStr);
			}
			
			pagingInfo.setTotalRecord(total);
			pagingInfo.setBlockSize(10);
			pagingInfo.setCurrentPage(start);
			pagingInfo.setRecordCountPerPage(10);
			
			model.addAttribute("list", list);
			model.addAttribute("pagingInfo", pagingInfo);
		}
		
		return "/admin/adminRecomand";
	}
	
	@RequestMapping("/deleteRecommend.do")
	@ResponseBody
	public int deleteRecommend(@RequestParam(required=false) String recombookNoList) {
		logger.info("파라미터 recombookNoList={}", recombookNoList);
		
		int count = recommendService.deleteRecommend(recombookNoList);
		
		return count;
	}

	@RequestMapping("/adminRecommendAdd.do")
	@ResponseBody
	public String recommendAdd(@ModelAttribute RecommendVO recommendVo,
			HttpSession session,
			Model model) {
		
		String userid=(String)session.getAttribute("useridA");
		logger.info("관리자 아이디={}",userid);
		
		recommendVo.setManagerId(userid);
		
		logger.info("값 세팅 후 recommendVo={}",recommendVo);
		
		int cnt=recommendService.insertRecommend(recommendVo);
		logger.info("글등록 결과, cnt={}", cnt);
		String result="";
		
		if(cnt>0) {
			result="성공";
			System.out.println("추천도서 입력 성공");
		}else {
			result="";
			System.out.println("추천도서 입력 실패");
		}
		return result; 
	}
}
