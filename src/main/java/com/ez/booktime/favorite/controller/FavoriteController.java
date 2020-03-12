package com.ez.booktime.favorite.controller;

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
import org.springframework.web.bind.annotation.ResponseBody;

import com.ez.booktime.api.AladinAPI;
import com.ez.booktime.category.model.BookCategoryService;
import com.ez.booktime.category.model.BookCategoryVO;
import com.ez.booktime.favorite.model.FavoriteDAO;
import com.ez.booktime.favorite.model.FavoriteService;
import com.ez.booktime.favorite.model.FavoriteVO;

@Controller
@RequestMapping("/favorite")
public class FavoriteController {
	private static final Logger logger
		= LoggerFactory.getLogger(FavoriteController.class);
	
	@Autowired
	private FavoriteService favoriteSerivce;
	
	@Autowired
	private BookCategoryService cateService;
	
	@Autowired
	private AladinAPI aladinApi;
	
	@RequestMapping("/favorite.do")
	public void favorite(HttpSession session, Model model) {
		String userid = (String)session.getAttribute("userid");
		logger.info("즐겨찾기 리스트, 파라미터 userid={}",userid);
		
		FavoriteVO fVo = new FavoriteVO();
		fVo.setUserid(userid);
		fVo.setGroup("FAVORITE");
		
		getFavorites(fVo, model);
		
	}
	
	@RequestMapping("/cart.do")
	public void cart(HttpSession session, Model model) {
		String userid = (String)session.getAttribute("userid");
		if(userid==null) {
			userid = "#"+session.getId();
		}
		logger.info("장바구니 리스트, 파라미터 userid={}",userid);
		
		FavoriteVO fVo = new FavoriteVO();
		fVo.setUserid(userid);
		fVo.setGroup("CART");
			
		getFavorites(fVo, model);
	}
	
	private void getFavorites(FavoriteVO fVo, Model model) {
		List<FavoriteVO> list = favoriteSerivce.selectFavorite(fVo);
		
		List<Map<String, Object>> infoList = new ArrayList<Map<String, Object>>();
		for(FavoriteVO vo : list) {
			try {
				Map<String, Object> aladin = aladinApi.selectBook(vo.getIsbn());
				
				String cateName = (String)aladin.get("cateName");
				BookCategoryVO cateVo = cateService.selectCategoryInfoByName(cateName);
				
				Map<String, Object> info = new HashMap<String, Object>();
				
				info.put("cover", aladin.get("cover"));
				info.put("cateName", cateName);
				info.put("cateCode", cateVo.getCateCode());
				
				infoList.add(info);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		logger.info("favorite 그룹={}, 조회된 favoriteList.size={}",fVo.getGroup(), list.size());
		
		model.addAttribute("list", list);
		model.addAttribute("infoList", infoList);
	}
	
	
	@RequestMapping("/addFavorite.do")
	@ResponseBody
	public int addFavorite(@ModelAttribute FavoriteVO vo
			, HttpSession session) {
		
		String userid = (String)session.getAttribute("userid");
		if(userid==null || userid.isEmpty()) {
			vo.setUserid("#"+session.getId());	//비회원이면 #sessionI
		}else {
			vo.setUserid(userid);
		}
		
		
		logger.info("장바구니 추가 처리, 파라미터vo={}",vo);
		
		return favoriteSerivce.insertFavorite(vo);
	}
	
	@RequestMapping("/moveFavorite.do")
	@ResponseBody
	public int moveFavorite(String favoriteNoList) {
		int count = favoriteSerivce.moveFavorite(favoriteNoList);
		
		return count;
	}
	
	@RequestMapping("/updateCart.do")
	public String updateCart(@ModelAttribute FavoriteVO vo) {
		logger.info("장바구니 수량 처리, 파라미터 vo={}",vo);
		
		int count = favoriteSerivce.updateQty(vo);
		logger.info("장바구니 수량 수정 결과 count={}",count);
		
		return "redirect:/favorite/cart.do";
	}
	
	@RequestMapping("/deleteFavorite.do")
	@ResponseBody
	public int deleteFavorite(@RequestParam String favoriteNoList
			,@RequestParam String group) {
		logger.info("favorite삭제 처리, 파라미터 favoriteNoList={}, group={}",favoriteNoList, group);
		
		int count = favoriteSerivce.deleteFavorite(favoriteNoList, group);
		
		return count;
	}
	
	/*
	 * @RequestMapping("/addListOneFavorite.do")
	 * 
	 * @ResponseBody public int addOneFavorite(@ModelAttribute FavoriteVO vo ,
	 * HttpSession session) {
	 * 
	 * String userid = (String)session.getAttribute("userid"); if(userid==null ||
	 * userid.isEmpty()) { vo.setUserid("#"+session.getId()); //비회원이면 #sessionI
	 * }else { vo.setUserid(userid); }
	 * 
	 * List<FavoriteVO> bookInfo = vo.getVoList();
	 * 
	 * vo.setGroup(bookInfo.get(2).getGroup());
	 * vo.setIsbn(bookInfo.get(3).getIsbn());
	 * vo.setBookName(bookInfo.get(4).getBookName());
	 * vo.setWriter(bookInfo.get(5).getWriter());
	 * vo.setPublisher(bookInfo.get(6).getPublisher());
	 * vo.setPrice(bookInfo.get(7).getPrice()); vo.setQty(bookInfo.get(8).getQty());
	 * 
	 * logger.info("장바구니 추가 처리, 파라미터vo={}",vo);
	 * 
	 * return favoriteSerivce.insertFavorite(vo); }
	 */
}
