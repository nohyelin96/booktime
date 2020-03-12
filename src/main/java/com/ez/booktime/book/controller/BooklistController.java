package com.ez.booktime.book.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ez.booktime.api.AladinAPI;
import com.ez.booktime.common.PaginationInfo;
import com.ez.booktime.controller.Category;
import com.ez.booktime.favorite.model.FavoriteService;
import com.ez.booktime.favorite.model.FavoriteVO;

@Controller
@RequestMapping("/book")
public class BooklistController {
	private static final Logger logger
		= LoggerFactory.getLogger(BooklistController.class);

	@Autowired 
	private AladinAPI aladinApi;
	
	@Autowired
	private FavoriteService favoriteSerivce;
	
	@SuppressWarnings("null")
	@RequestMapping("/bookList.do") 
	public String bookList_post(@RequestParam(defaultValue="0") int cateNo
			, @RequestParam(defaultValue = "1") int start
			, @RequestParam(defaultValue = "20") int maxResult
			, @RequestParam(required = false, value="searchKeyword") 
			String searchKeyword
			, @RequestParam(required = false, value="author") String author
			, @RequestParam(required = false, value="publisher") String publisher
			, Model model) throws Exception { 
		logger.info("카테고리 번호 cateNo={}, 현재 페이지 start={}", cateNo, start);
		logger.info("한 페이지당 출력 개수 maxResult={}, 검색어 searchKeyword={}", maxResult, searchKeyword);
		logger.info("작가 및 출판사별 출력 author={}, publisher={}", author, publisher);
		
		Category category=new Category();
		PaginationInfo pagingInfo=new PaginationInfo();
		List<Map<String, Object>> list=null;
		
		if((searchKeyword==null || searchKeyword.isEmpty()) &&
			(author==null || author.isEmpty()) && (publisher!=null && !publisher.isEmpty())) {
				list = aladinApi.searchByPublAndCate(publisher, cateNo, start, 20);
				logger.info("출판사별 검색 결과 list.size={}", list.size());
		}else if((author==null || author.isEmpty()) &&
			(searchKeyword!=null && !searchKeyword.isEmpty())) {
			list = aladinApi.searchByTitleAndCate(searchKeyword, cateNo, start, 20);
			logger.info("제목 검색 결과 list.size={}",list.size());
		}else if((searchKeyword==null || searchKeyword.isEmpty()) &&
			(author!=null && !author.isEmpty())) {
			list = aladinApi.searchByAuthorAndCate(author, cateNo, start, 20);
			logger.info("특정 저자 검색 결과 list.size={}",list.size());
		}else if((searchKeyword==null || searchKeyword.isEmpty()) &&
				(author==null || author.isEmpty())){
			list=category.categoryFind(cateNo, start, maxResult);
			logger.info("카테고리 검색 리스트 크기={}",list.size());
		}
		
		if(list.size()<1) {
			model.addAttribute("msg","검색결과가 없습니다.");
			model.addAttribute("url","/book/bookList.do?cateNo="+cateNo);
			
			return "common/message";
		}
		
		int total = Integer.parseInt(list.get(0).get("totalResult").toString());
		
		pagingInfo.setTotalRecord(total);
		pagingInfo.setBlockSize(10);
		pagingInfo.setCurrentPage(start);
		pagingInfo.setRecordCountPerPage(20);
		
		model.addAttribute("list",list);
		model.addAttribute("pagingInfo", pagingInfo);
		  
		return "book/bookList"; 
	}
	 
	@RequestMapping("/bookBestList.do")
	public String bestBook(@RequestParam(defaultValue="0") int cateNo, 
			Model model) throws Exception {
		logger.info("카테고리 번호={}, CateNo={}", cateNo);
		
		Category category=new Category();
		List<Map<String, Object>> specialList=category.categorySpecial(cateNo);
		logger.info("카테고리 베스트 검색 리스트, specialList.size={}",specialList.size());
		
		model.addAttribute("specialList", specialList);
		
		return "book/bookBestList";
	}
	
	@RequestMapping("/bookRecommandList.do")
	public String recommandBook(@RequestParam(defaultValue="0") int cateNo, 
			Model model) throws Exception {
		logger.info("카테고리 번호={}, cateNo={}", cateNo);
		
		Category category=new Category();
		List<Map<String, Object>> recommandList=category.categoryRecommand(cateNo);
		logger.info("카테고리 베스트 검색 리스트, specialList.size={}",recommandList.size());
		
		model.addAttribute("recommandList", recommandList);
		
		return "book/bookRecommandList";
	}
	
	@RequestMapping("/addBookCart.do")
	@ResponseBody
	public boolean addBookCart(@RequestParam String isbn, HttpSession session, 
			Model model) throws Exception {
		logger.info("isbn 정보, 파라미터 isbn={}", isbn);
		
		//isbn에 따른 책 정보 조회
		Map<String, Object> map=aladinApi.selectBook(isbn);
		logger.info("isbn에 따른 책 정보, map={}", map);
		
		//조회돈 책 정보 변수에 세팅
		String userid = (String)session.getAttribute("userid");
		String title = (String) map.get("title");
		String writer = (String) map.get("author");
		String publisher = (String) map.get("publisher");
		int price = ((Long) map.get("priceSales")).intValue();
		

		//FavoriteVO에 세팅
		FavoriteVO vo = new FavoriteVO();
		vo.setGroup("CART");
		vo.setIsbn(isbn);
		vo.setBookName(title);
		vo.setWriter(writer);
		vo.setPublisher(publisher);
		vo.setPrice(price);
		vo.setQty(1);
		
		if(userid==null || userid.isEmpty()) {
			vo.setUserid("#"+session.getId());	//비회원이면 #sessionI
		}else {
			vo.setUserid(userid);
		}
		
		logger.info("장바구니 추가 처리, 파라미터vo={}",vo);
		
		int res=favoriteSerivce.insertFavorite(vo);
		
		boolean bool=false;
		if(res>0) {
			bool=true;
		}
		
		return bool;
	}
	
	@RequestMapping("/addBookFavo.do")
	@ResponseBody
	public boolean addBookFav(@RequestParam String isbn, HttpSession session, 
			Model model) throws Exception {
		logger.info("isbn 정보, 파라미터 isbn={}", isbn);
		
		//isbn에 따른 책 정보 조회
		Map<String, Object> map=aladinApi.selectBook(isbn);
		logger.info("isbn에 따른 책 정보, map={}", map);
		
		//조회돈 책 정보 변수에 세팅
		String userid = (String)session.getAttribute("userid");
		String title = (String) map.get("title");
		String writer = (String) map.get("author");
		String publisher = (String) map.get("publisher");
		int price = ((Long) map.get("priceSales")).intValue();
		

		//FavoriteVO에 세팅
		FavoriteVO vo = new FavoriteVO();
		vo.setGroup("FAVORITE");
		vo.setIsbn(isbn);
		vo.setBookName(title);
		vo.setWriter(writer);
		vo.setPublisher(publisher);
		vo.setPrice(price);
		vo.setQty(1);
		
		if(userid==null || userid.isEmpty()) {
			vo.setUserid("#"+session.getId());	//비회원이면 #sessionI
		}else {
			vo.setUserid(userid);
		}
		
		logger.info("장바구니 추가 처리, 파라미터vo={}",vo);
		
		int res=favoriteSerivce.insertFavorite(vo);
		
		boolean bool=false;
		if(res>0) {
			bool=true;
		}
		
		return bool;
	}
	
	@RequestMapping("/addBookAllCart.do")
	@ResponseBody
	public boolean addBookAllCart(@RequestParam(value = "checkArray[]" ) List<String> checkArray, 
			HttpSession session, Model model) throws Exception {
		logger.info("isbn 정보, 파라미터 checkArray.size={}", checkArray.size());
		
		String userid = (String)session.getAttribute("userid");
		FavoriteVO vo = new FavoriteVO();
		int res=0;
		
		for(String isbn : checkArray) {
			logger.info("checkArray 값:"+ isbn);

			//isbn에 따른 책 정보 조회
			Map<String, Object> map=aladinApi.selectBook(isbn);
			logger.info("isbn에 따른 책 정보, map={}", map);

			//조회돈 책 정보 변수에 세팅
			String title = (String) map.get("title");
			String writer = (String) map.get("author");
			String publisher = (String) map.get("publisher");
			int price = ((Long) map.get("priceSales")).intValue();
			
			//FavoriteVO에 세팅
			vo.setGroup("CART");
			vo.setIsbn(isbn);
			vo.setBookName(title);
			vo.setWriter(writer);
			vo.setPublisher(publisher);
			vo.setPrice(price);
			vo.setQty(1);
			if(userid==null || userid.isEmpty()) {
				vo.setUserid("#"+session.getId());	//비회원이면 #sessionI
			}else {
				vo.setUserid(userid);
			}
			
			logger.info("장바구니 추가 처리, 파라미터vo={}",vo);
			
			res=favoriteSerivce.insertFavorite(vo);
		}
		
		boolean bool=false;
		if(res>0) {
			bool=true;
		}
		
		return bool;
	}
	
	@RequestMapping("/addBookAllFavo.do")
	@ResponseBody
	public boolean addBookAllFavo(@RequestParam(value = "checkArray[]" ) List<String> checkArray, 
			HttpSession session, Model model) throws Exception {
		logger.info("isbn 정보, 파라미터 checkArray.size={}", checkArray.size());
		
		String userid = (String)session.getAttribute("userid");
		FavoriteVO vo = new FavoriteVO();
		int res=0;
		
		for(String isbn : checkArray) {
			logger.info("checkArray 값:"+ isbn);

			//isbn에 따른 책 정보 조회
			Map<String, Object> map=aladinApi.selectBook(isbn);
			logger.info("isbn에 따른 책 정보, map={}", map);

			//조회돈 책 정보 변수에 세팅
			String title = (String) map.get("title");
			String writer = (String) map.get("author");
			String publisher = (String) map.get("publisher");
			int price = ((Long) map.get("priceSales")).intValue();
			
			//FavoriteVO에 세팅
			vo.setGroup("FAVORITE");
			vo.setIsbn(isbn);
			vo.setBookName(title);
			vo.setWriter(writer);
			vo.setPublisher(publisher);
			vo.setPrice(price);
			vo.setQty(1);
			if(userid==null || userid.isEmpty()) {
				vo.setUserid("#"+session.getId());	//비회원이면 #sessionI
			}else {
				vo.setUserid(userid);
			}
			
			logger.info("찜목록 추가 처리, 파라미터vo={}",vo);
			
			res=favoriteSerivce.insertFavorite(vo);
		}
		
		boolean bool=false;
		if(res>0) {
			bool=true;
		}
		
		return bool;
	}
	
	@RequestMapping("/directPayments.do")
	@ResponseBody
	public int directPayments(@RequestParam String isbn, HttpSession session, 
			Model model) throws Exception {
		logger.info("isbn 정보, 파라미터 isbn={}", isbn);
		
		//isbn에 따른 책 정보 조회
		Map<String, Object> map=aladinApi.selectBook(isbn);
		logger.info("isbn에 따른 책 정보, map={}", map);
		
		//조회돈 책 정보 변수에 세팅
		String userid = (String)session.getAttribute("userid");
		String title = (String) map.get("title");
		String writer = (String) map.get("author");
		String publisher = (String) map.get("publisher");
		int price = ((Long) map.get("priceSales")).intValue();

		//FavoriteVO에 세팅
		FavoriteVO vo = new FavoriteVO();
		vo.setGroup("CART");
		vo.setIsbn(isbn);
		vo.setBookName(title);
		vo.setWriter(writer);
		vo.setPublisher(publisher);
		vo.setPrice(price);
		vo.setQty(1);
		
		if(userid==null || userid.isEmpty()) {
			vo.setUserid("#"+session.getId());	//비회원이면 #sessionI
		}else {
			vo.setUserid(userid);
		}
		
		logger.info("상품 목록 페이지에서 구매하기 처리 파라미터 vo={}");
		
		int cnt = favoriteSerivce.insertFavorite(vo);
		logger.info("주문서 페이지로 넘어가기전 장바구니에 넣기 결과 cnt={}",cnt);
		
		
		return cnt;
	}
}
