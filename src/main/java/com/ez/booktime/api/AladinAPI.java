package com.ez.booktime.api;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class AladinAPI {
	private static final String TTB_KEY = "?ttbkey=ttbstjgh5051633001&";
	
	public static final String SEARCH_TITLE = "QueryType=Title&";
	public static final String SEARCH_AUTHOR = "QueryType=Author&";
	public static final String SEARCH_PUBLISHER = "QueryType=Publisher&";
	
	public static final String LIST_NEW_ALL = "QueryType=ItemNewAll&";
	public static final String LIST_BEST_SELLER = "QueryType=Bestseller&";
	
	private static final Logger logger
		=LoggerFactory.getLogger(AladinAPI.class);
	
	@Autowired
	private Utility util;
	
	//상품 조회 API
	public Map<String, Object> selectBook(String isbn13) throws Exception{
		//필수
		String selectUrl = "http://www.aladin.co.kr/ttb/api/ItemLookUp.aspx";
		String itemIdType = "ItemIdType=ISBN13&";
		if(isbn13.length()<13) {
			itemIdType="ItemIdType=ItemId&";
		}
		isbn13 = "ItemId="+isbn13+"&";
		
		String apiURL = selectUrl+TTB_KEY
				+isbn13+itemIdType+options();
		
		URL url = new URL(apiURL);
		logger.info("URL={}",url);
		JSONObject obj = util.getJson(url, "get", null);
		Map<String, Object> map=  parse(obj).get(0);
		
		return map;
	}
	
	//상품 검색 API
	//AladinAPI.SEARCH_~ 상수, searchKeyword 검색어
	//start 시작페이지, maxResults 한페이지 출력결과수
	public List<Map<String, Object>> searchBy(String searchType, String searchKeyword
			, int start, int maxResults) throws Exception {
		//필수
		String searchUrl = "http://www.aladdin.co.kr/ttb/api/ItemSearch.aspx";
		
		String query = "Query="+URLEncoder.encode(searchKeyword, "UTF-8")+"&";	//제목
		logger.info("알라딘 검색, 파라미터 searchKeyword={}",searchKeyword);
		logger.info("파라미터 start={},maxResults={}",start,maxResults);
		
		//url 조립
		String apiURL = searchUrl+TTB_KEY
				+searchType+query
				+options();
		URL url = new URL(apiURL);
		
		JSONObject jsonObj = util.getJson(url,"get",null);
		List<Map<String, Object>> list = parse(jsonObj);
		
		return list;
	}
	
	/*
	 * //상품 검색 API - 카테고리별 검색 //AladinAPI.SEARCH_~ 상수, searchKeyword 검색어, //start
	 * 시작페이지, maxResults 한페이지 출력결과수 public List<Map<String, Object>> searchByCate(
	 * int cateNo, String searchKeyword, int start, int maxResults) throws Exception
	 * { //필수 String searchUrl = "http://www.aladdin.co.kr/ttb/api/ItemSearch.aspx";
	 * String categoryId="CategoryId="+cateNo+"&";
	 * logger.info("파라미터 start={},maxResults={}",start,maxResults);
	 * 
	 * //url 조립 String apiURL = searchUrl+TTB_KEY +LIST_NEW_ALL +categoryId
	 * +"start=" +start +"&" +"MaxResults=" +20 +"&" +options(); URL url = new
	 * URL(apiURL); logger.info("카테고리별로 검색하기 URL={}",url);
	 * 
	 * JSONObject jsonObj = util.getJson(url,"get",null); List<Map<String, Object>>
	 * list = parse(jsonObj);
	 * 
	 * return list; }
	 */
	
	//상품 검색 API - 제목 검색
	//AladinAPI.SEARCH_~ 상수, searchKeyword 검색어, 
		//start 시작페이지, maxResults 한페이지 출력결과수
		public List<Map<String, Object>> searchByTitleAndCate( 
				String searchKeyword, int cateNo, 
				int start, int maxResults) throws Exception {
			//필수
			String searchUrl = "http://www.aladdin.co.kr/ttb/api/ItemSearch.aspx";
			
			String categoryId="CategoryId="+cateNo+"&";
			String query = "Query="+URLEncoder.encode(searchKeyword,"UTF-8")+"&";	//제목
			logger.info("알라딘 검색, 파라미터 searchKeyword={}",searchKeyword);
			logger.info("파라미터 start={},maxResults={}",start,maxResults);
			
			//url 조립
			String apiURL = searchUrl+TTB_KEY
					+SEARCH_TITLE+query
					+categoryId
					+"start="
					+start
					+"&"
					+"MaxResults="
					+20
					+"&"
					+options();
			URL url = new URL(apiURL);
			logger.info("제목으로 검색하기 URL={}",url);
			
			JSONObject jsonObj = util.getJson(url,"get",null);
			List<Map<String, Object>> list = parse(jsonObj);
			
			return list;
		}
		
		//상품 검색 API - 특정 저자 상품 출력 리스트
		//AladinAPI.SEARCH_~ 상수, author 검색어, 
			//start 시작페이지, maxResults 한페이지 출력결과수
			public List<Map<String, Object>> searchByAuthorAndCate( 
					String author, int cateNo, 
					int start, int maxResults) throws Exception {
				//필수
				String searchUrl = "http://www.aladdin.co.kr/ttb/api/ItemSearch.aspx";
				
				String categoryId="CategoryId="+cateNo+"&";
				String query = "Query="+URLEncoder.encode(author,"UTF-8")+"&";	//제목
				logger.info("알라딘 검색, 파라미터 author={}",author);
				logger.info("파라미터 start={},maxResults={}",start,maxResults);
				
				//url 조립
				String apiURL = searchUrl+TTB_KEY
						+SEARCH_AUTHOR+query
						+categoryId
						+"start="
						+start
						+"&"
						+"MaxResults="
						+20
						+"&"
						+options();
				URL url = new URL(apiURL);
				logger.info("특정 저자 상품 목록 URL={}",url);
				
				JSONObject jsonObj = util.getJson(url,"get",null);
				List<Map<String, Object>> list = parse(jsonObj);
				
				return list;
			}
	
			//상품 검색 API - 특정 출판사 상품 출력 리스트
			//AladinAPI.SEARCH_~ 상수, publisher 검색어, 
			//start 시작페이지, maxResults 한페이지 출력결과수
			public List<Map<String, Object>> searchByPublAndCate( 
					String publisher, int cateNo, 
					int start, int maxResults) throws Exception {
				//필수
				String searchUrl = "http://www.aladdin.co.kr/ttb/api/ItemSearch.aspx";

				String categoryId="CategoryId="+cateNo+"&";
				String query = "Query="+URLEncoder.encode(publisher,"UTF-8")+"&";	//제목
				logger.info("알라딘 검색, 파라미터 publisher={}",publisher);
				logger.info("파라미터 start={},maxResults={}",start,maxResults);

				//url 조립
				String apiURL = searchUrl+TTB_KEY
						+SEARCH_PUBLISHER+query
						+categoryId
						+"start="
						+start
						+"&"
						+"MaxResults="
						+20
						+"&"
						+options();
				URL url = new URL(apiURL);
				logger.info("특정 저자 상품 목록 URL={}",url);

				JSONObject jsonObj = util.getJson(url,"get",null);
				List<Map<String, Object>> list = parse(jsonObj);

				return list;
			}
			
	public List<Map<String, Object>> parse(JSONObject jsonObj) {
		JSONObject jsonTemp = jsonObj;
		
		JSONArray jsonArr = (JSONArray) jsonObj.get("item");
		logger.info("검색결과 arrSize={}",jsonArr.size());
		
		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
		for(int i=0;i<jsonArr.size();i++) {
			jsonObj = (JSONObject)jsonArr.get(i);
			
			Map<String, Object> map = new HashMap<String, Object>();
			//map.put("isbn", jsonObj.get("isbn"));	//isbn(10자리)
			map.put("isbn13", jsonObj.get("isbn13"));	//isbn13(13자리)
			map.put("title", jsonObj.get("title"));	//제목
			map.put("author", jsonObj.get("author"));	//지은이
			map.put("pubDate", jsonObj.get("pubDate"));	//출간일
			map.put("publisher", jsonObj.get("publisher"));	//출판사
			map.put("priceStandard", jsonObj.get("priceStandard"));	//판매 정가
			map.put("description", jsonObj.get("description"));	//상품 설명(요약)
			map.put("priceSales", jsonObj.get("priceSales"));	//판매 세일가(알라딘)
			map.put("mileage", jsonObj.get("mileage"));	//적립 마일리지
			map.put("adult", jsonObj.get("adult"));	//성인유무
			map.put("stockstatus", jsonObj.get("stockstatus"));	//재고상태 정상유통일경우 공백
			
			logger.info("json데이터 title ={}, publisher={}", jsonObj.get("title"),jsonObj.get("publisher").toString());
			
			String cates = (String)jsonObj.get("categoryName");
			String cate = "";
			if(cates!=null && !cates.isEmpty()) {
				cate = cates.split(">")[1].trim();
			}
			map.put("cateName", cate);	//카테고리 명
	
			String coverURL = (String)jsonObj.get("cover");
			map.put("cover", coverURL.replace("/cover/", "/cover500/"));	//표지
			
			map.put("totalResult", jsonTemp.get("totalResults"));	//API 총 결과 수
			map.put("startIndex", jsonTemp.get("startIndex"));
			map.put("start", jsonObj.get("Start"));	//검색결과 시작페이지
			map.put("maxResult", jsonObj.get("MaxResults"));	//검색결과 한 페이지당 최대 출력 개수 
			
			//상품 조회 API의 경우 subInfo 담기
			JSONObject subObj = (JSONObject)jsonObj.get("subInfo");	//부가정보
			
			if(subObj!=null && !subObj.isEmpty()) {
				String subTitle = (String)subObj.get("subTitle");
				if(subTitle!=null) {
					map.put("subTitle", subTitle); //부제
				}
				
				String originalTitle = (String)subObj.get("originalTitle");
				if(originalTitle!=null) {
					map.put("originalTitle", originalTitle); //원제
				}
				
				map.put("itemPage", subObj.get("itemPage")); //상품 쪽수
				
				//도서 판형정보, 포장 관련 정보
				subObj = (JSONObject) subObj.get("packing");
				map.put("styleDesc", subObj.get("styleDesc"));	//판형 정보
				map.put("weight", subObj.get("weight"));	//무게 (그램)
				map.put("sizeWidth", subObj.get("sizeWidth"));	//가로(mm)
				map.put("sizeHeight", subObj.get("sizeHeight"));//세로(mm)
				map.put("sizeDepth", subObj.get("sizeDepth"));	//깊이(mm)
				
			}
			
			list.add(map);
		}
		
		return list;
	}

	public String options() {
		String cover = "Cover=big&";	//표지 크기
		String output = "Output=JS&";	//json
		String version = "Version=20131101&";
		String optResult = "OptResult=packing";
		
		return cover+output+version+optResult;
	}
	
	//상품 검색 API - 제목 검색
		//AladinAPI.SEARCH_~ 상수, searchKeyword 검색어, 
			//start 시작페이지, maxResults 한페이지 출력결과수
			public List<Map<String, Object>> searchByTitle( 
					String searchKeyword,
					int start, int maxResults) throws Exception {
				//필수
				String searchUrl = "http://www.aladdin.co.kr/ttb/api/ItemSearch.aspx";
				
				String query = "Query="+URLEncoder.encode(searchKeyword,"UTF-8")+"&";	//제목
				logger.info("알라딘 검색, 파라미터 searchKeyword={}",searchKeyword);
				logger.info("파라미터 start={},maxResults={}",start,maxResults);
				
				//url 조립
				String apiURL = searchUrl+TTB_KEY
						+SEARCH_TITLE+query
						+"start="
						+start
						+"&"
						+"MaxResults="
						+10
						+"&"
						+options();
				URL url = new URL(apiURL);
				logger.info("제목으로 검색하기 URL={}",url);
				
				HttpURLConnection con = (HttpURLConnection) url.openConnection();
				con.setRequestMethod("GET");
				
				int responseCode = con.getResponseCode();
		        BufferedReader br;
		        if(responseCode==200) { // 정상 호출
		            br = new BufferedReader(new InputStreamReader(con.getInputStream(), "UTF-8"));
		        } else {  // 에러 발생
		        	logger.info("에러 발생 responseCode={}",responseCode);
		            br = new BufferedReader(new InputStreamReader(con.getErrorStream(), "UTF-8"));
		        }
		        
		        JSONParser jsonParser = new JSONParser();
				JSONObject jsonObj = (JSONObject) jsonParser.parse(br);
		        br.close();
		       
				List<Map<String, Object>> list = parse(jsonObj);
				
				return list;
			}
}
