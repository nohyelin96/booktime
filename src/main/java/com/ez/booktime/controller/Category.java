package com.ez.booktime.controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.ez.booktime.api.AladinAPI;

public class Category {
	private static final String LIST_URL = "https://www.aladin.co.kr/ttb/api/ItemList.aspx";
	private static final String TTB_KEY = "?ttbkey=ttbstjgh5051633001&";
	
	private static final String LIST_NEW_ALL = "QueryType=ItemNewAll&";
	private static final String LIST_NEW_SPECIAL = "QueryType=ItemNewSpecial&";
	private static final String LIST_RECOMMAND = "QueryType=ItemEditorChoice&";
	private static final String BESTSELLER = "QueryType=Bestseller&";
	
	private static final Logger logger
		=LoggerFactory.getLogger(AladinAPI.class);
	
	public List<Map<String, Object>> categoryFind(int cateNo,
			int start, int maxResult) 
			throws Exception {
		
		//카테고리 번호
		
		String category 
		="categoryId="
		+cateNo
		+"&"
		+"start="
		+start
		+"&"
		+"MaxResults="
		+maxResult
		+"&";
		
		//신간 전체 List url 조립
		String apiURL = LIST_URL+TTB_KEY
				+LIST_NEW_ALL
				+category
				+options();
		URL url = new URL(apiURL);
		System.out.println(url);
		
		HttpURLConnection con = (HttpURLConnection)url.openConnection();
        con.setRequestMethod("GET");
        int responseCode = con.getResponseCode();
        BufferedReader br;
        if(responseCode==200) { // 정상 호출
            br = new BufferedReader(new InputStreamReader(con.getInputStream()));
        } else {  // 에러 발생
            br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
        }
        String inputLine;
        StringBuffer response = new StringBuffer();
        while ((inputLine = br.readLine()) != null) {
            response.append(inputLine);
        }
        br.close();
        con.disconnect();
        
        String cateResult=response.toString();
        System.out.println(cateResult);
        
        JSONParser jp = new JSONParser();
        JSONObject jsonObj = (JSONObject) jp.parse(cateResult);
        JSONArray memberArray = (JSONArray)jsonObj.get("item");
        System.out.println(memberArray.toString());
		
        List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
		for(int i=0;i<memberArray.size();i++) {
			
			JSONObject jsonObj2 = (JSONObject)memberArray.get(i);
			
			Map<String, Object> map = new HashMap<String, Object>();
			
			String title=(String) jsonObj2.get("title");
			map.put("title", title);	//제목
			System.out.println(title);
			String author=(String) jsonObj2.get("author");
			map.put("author", author); //지은이
			System.out.println(author);
			map.put("publisher", jsonObj2.get("publisher"));	//출판사
	        map.put("pubDate", jsonObj2.get("pubDate"));	//출간일
			//map.put("discription", jsonObj2.get("discription"));	//설명
			map.put("priceStandard", jsonObj2.get("priceStandard"));	//정가
			map.put("priceSales", jsonObj2.get("priceSales"));
			map.put("cover", jsonObj2.get("cover"));	//표지
			map.put("isbn13", jsonObj2.get("isbn13"));	//isbn13(13자리)
			
			map.put("totalResult", jsonObj.get("totalResults"));	//API 총 결과 수
			map.put("startIndex", jsonObj2.get("startIndex"));
			map.put("start", jsonObj2.get("Start"));	//검색결과 시작페이지
			map.put("maxResult", jsonObj.get("MaxResults"));	//검색결과 한 페이지당 최대 출력 개수
			
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
	
	public List<Map<String, Object>> categorySpecial(int cateNo) throws Exception {
		
		//카테고리 번호
		
		String category = "CategoryId="
		+cateNo
		+"&";
		
		//신간 분야별 Special List url 조립
		String apiSpecialURL = LIST_URL+TTB_KEY
				+LIST_NEW_SPECIAL
				+category
				+optionsCover();
		URL urlSpecial = new URL(apiSpecialURL);
		
		System.out.println(urlSpecial);
		
		HttpURLConnection con = (HttpURLConnection)urlSpecial.openConnection();
        con.setRequestMethod("GET");
        int responseCode = con.getResponseCode();
        BufferedReader br;
        if(responseCode==200) { // 정상 호출
            br = new BufferedReader(new InputStreamReader(con.getInputStream()));
        } else {  // 에러 발생
            br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
        }
        String inputLine;
        StringBuffer response = new StringBuffer();
        while ((inputLine = br.readLine()) != null) {
            response.append(inputLine);
        }
        br.close();
        con.disconnect();
        
        String cateResult=response.toString();
        System.out.println(cateResult);
        
        JSONParser jp = new JSONParser();
        JSONObject jsonObj = (JSONObject) jp.parse(cateResult);
        
		// String totalResults = (String)jsonObj.get("totalResults"); 
        
        JSONArray memberArray = (JSONArray)jsonObj.get("item");
        System.out.println(memberArray.toString());
		
        List<Map<String, Object>> specialList = new ArrayList<Map<String,Object>>();
		for(int i=0;i<memberArray.size();i++) {
			JSONObject jsonObjSpecial = (JSONObject)memberArray.get(i);
			
			Map<String, Object> map = new HashMap<String, Object>();
			
			String title=(String) jsonObjSpecial.get("title");
			map.put("title", title);	//제목
			System.out.println(title);
			String author=(String) jsonObjSpecial.get("author");
			map.put("author", author); //지은이
			System.out.println(author);
			map.put("publisher", jsonObjSpecial.get("publisher"));	//출판사
	        map.put("pubDate", jsonObjSpecial.get("pubDate"));	//출간일
			//map.put("discription", jsonObjSpecial.get("discription"));	//설명
			map.put("priceStandard", jsonObjSpecial.get("priceStandard"));	//가격
			map.put("priceSales", jsonObjSpecial.get("priceSales"));	//가격
			map.put("cover", jsonObjSpecial.get("cover"));	//표지
			map.put("isbn13", jsonObjSpecial.get("isbn13"));	//isbn13(13자리)
			//map.put("totalResults", totalResults);
			
			specialList.add(map);
        }
		return specialList;
	}
	
	public List<Map<String, Object>> categoryRecommand(int cateNo) throws Exception {
		
		//카테고리 번호
		
		String category = "CategoryId="
		+cateNo
		+"&";
		
		//신간 분야별 Special List url 조립
		String apiSpecialURL = LIST_URL+TTB_KEY
				+LIST_RECOMMAND
				+category
				+optionsCover();
		URL urlSpecial = new URL(apiSpecialURL);
		
		System.out.println(urlSpecial);
		
		HttpURLConnection con = (HttpURLConnection)urlSpecial.openConnection();
        con.setRequestMethod("GET");
        int responseCode = con.getResponseCode();
        BufferedReader br;
        if(responseCode==200) { // 정상 호출
            br = new BufferedReader(new InputStreamReader(con.getInputStream()));
        } else {  // 에러 발생
            br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
        }
        String inputLine;
        StringBuffer response = new StringBuffer();
        while ((inputLine = br.readLine()) != null) {
            response.append(inputLine);
        }
        br.close();
        con.disconnect();
        
        String cateResult=response.toString();
        System.out.println(cateResult);
        
        JSONParser jp = new JSONParser();
        JSONObject jsonObj = (JSONObject) jp.parse(cateResult);
        
		// String totalResults = (String)jsonObj.get("totalResults"); 
        
        JSONArray memberArray = (JSONArray)jsonObj.get("item");
        System.out.println(memberArray.toString());
		
        List<Map<String, Object>> recommandList = new ArrayList<Map<String,Object>>();
		for(int i=0;i<memberArray.size();i++) {
			JSONObject jsonObjSpecial = (JSONObject)memberArray.get(i);
			
			Map<String, Object> map = new HashMap<String, Object>();
			
			String title=(String) jsonObjSpecial.get("title");
			map.put("title", title);	//제목
			System.out.println(title);
			String author=(String) jsonObjSpecial.get("author");
			map.put("author", author); //지은이
			System.out.println(author);
			map.put("publisher", jsonObjSpecial.get("publisher"));	//출판사
	        map.put("pubDate", jsonObjSpecial.get("pubDate"));	//출간일
			//map.put("discription", jsonObjSpecial.get("discription"));	//설명
			map.put("priceStandard", jsonObjSpecial.get("priceStandard"));	//가격
			map.put("priceSales", jsonObjSpecial.get("priceSales"));	//가격
			map.put("cover", jsonObjSpecial.get("cover"));	//표지
			map.put("isbn13", jsonObjSpecial.get("isbn13"));	//isbn13(13자리)
			//map.put("totalResults", totalResults);
			
			recommandList.add(map);
        }
		return recommandList;
	}
	
	public String optionsCover() {
		String coverSmall = "Cover=Mid&";	// 표지 크기
		String output = "Output=JS&";	//json
		String version = "Version=20131101";
		
		return coverSmall+output+version;
	}
	
	//전체 신간도서 조회
	public List<Map<String, Object>> AllNewList(
			int start, int maxResult) 
			throws Exception {
		
		//카테고리 번호
		
		String searchTarget
		="searchTarget=Book&"
		+"start="
		+start
		+"&"
		+"MaxResults="
		+maxResult
		+"&";
		
		//신간 전체 List url 조립
		String apiURL = LIST_URL+TTB_KEY
				+LIST_NEW_ALL
				+searchTarget
				+options();
		URL url = new URL(apiURL);
		System.out.println(url);
		
		HttpURLConnection con = (HttpURLConnection)url.openConnection();
        con.setRequestMethod("GET");
        int responseCode = con.getResponseCode();
        BufferedReader br;
        if(responseCode==200) { // 정상 호출
            br = new BufferedReader(new InputStreamReader(con.getInputStream()));
        } else {  // 에러 발생
            br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
        }
        String inputLine;
        StringBuffer response = new StringBuffer();
        while ((inputLine = br.readLine()) != null) {
            response.append(inputLine);
        }
        br.close();
        con.disconnect();
        
        String cateResult=response.toString();
        System.out.println(cateResult);
        
        JSONParser jp = new JSONParser();
        JSONObject jsonObj = (JSONObject) jp.parse(cateResult);
        JSONArray memberArray = (JSONArray)jsonObj.get("item");
        System.out.println(memberArray.toString());
		
        List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
		for(int i=0;i<memberArray.size();i++) {
			
			JSONObject jsonObj2 = (JSONObject)memberArray.get(i);
			
			Map<String, Object> map = new HashMap<String, Object>();
			
			String title=(String) jsonObj2.get("title");
			map.put("title", title);	//제목
			System.out.println(title);
			String author=(String) jsonObj2.get("author");
			map.put("author", author); //지은이
			System.out.println(author);
			map.put("publisher", jsonObj2.get("publisher"));	//출판사
	        map.put("pubDate", jsonObj2.get("pubDate"));	//출간일
			//map.put("discription", jsonObj2.get("discription"));	//설명
			map.put("priceStandard", jsonObj2.get("priceStandard"));	//정가
			map.put("priceSales", jsonObj2.get("priceSales"));
			map.put("cover", jsonObj2.get("cover"));	//표지
			map.put("isbn13", jsonObj2.get("isbn13"));	//isbn13(13자리)
			
			map.put("totalResult", jsonObj.get("totalResults"));	//API 총 결과 수
			map.put("startIndex", jsonObj2.get("startIndex"));
			map.put("start", jsonObj2.get("Start"));	//검색결과 시작페이지
			map.put("maxResult", jsonObj.get("MaxResults"));	//검색결과 한 페이지당 최대 출력 개수
			
			list.add(map);
        }
		return list;
	}
	
	//전체 베스트셀러 조회
		public List<Map<String, Object>> AllBestsellerList(
				int start, int maxResult) 
				throws Exception {
			
			//카테고리 번호
			
			String searchTarget
			="searchTarget=Book&"
			+"start="
			+start
			+"&"
			+"MaxResults="
			+20
			+"&";
			
			//신간 전체 List url 조립
			String apiURL = LIST_URL+TTB_KEY
					+BESTSELLER
					+searchTarget
					+options();
			URL url = new URL(apiURL);
			System.out.println(url);
			
			HttpURLConnection con = (HttpURLConnection)url.openConnection();
	        con.setRequestMethod("GET");
	        int responseCode = con.getResponseCode();
	        BufferedReader br;
	        if(responseCode==200) { // 정상 호출
	            br = new BufferedReader(new InputStreamReader(con.getInputStream()));
	        } else {  // 에러 발생
	            br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
	        }
	        String inputLine;
	        StringBuffer response = new StringBuffer();
	        while ((inputLine = br.readLine()) != null) {
	            response.append(inputLine);
	        }
	        br.close();
	        con.disconnect();
	        
	        String cateResult=response.toString();
	        System.out.println(cateResult);
	        
	        JSONParser jp = new JSONParser();
	        JSONObject jsonObj = (JSONObject) jp.parse(cateResult);
	        JSONArray memberArray = (JSONArray)jsonObj.get("item");
	        System.out.println(memberArray.toString());
			
	        List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
			for(int i=0;i<memberArray.size();i++) {
				
				JSONObject jsonObj2 = (JSONObject)memberArray.get(i);
				
				Map<String, Object> map = new HashMap<String, Object>();
				
				String title=(String) jsonObj2.get("title");
				map.put("title", title);	//제목
				System.out.println(title);
				String author=(String) jsonObj2.get("author");
				map.put("author", author); //지은이
				System.out.println(author);
				map.put("publisher", jsonObj2.get("publisher"));	//출판사
		        map.put("pubDate", jsonObj2.get("pubDate"));	//출간일
				map.put("discription", jsonObj2.get("discription"));	//설명
				map.put("priceStandard", jsonObj2.get("priceStandard"));	//정가
				map.put("priceSales", jsonObj2.get("priceSales"));
				map.put("cover", jsonObj2.get("cover"));	//표지
				map.put("isbn13", jsonObj2.get("isbn13"));	//isbn13(13자리)
				
				map.put("totalResult", jsonObj.get("totalResults"));	//API 총 결과 수
				map.put("startIndex", jsonObj2.get("startIndex"));
				map.put("start", jsonObj2.get("Start"));	//검색결과 시작페이지
				map.put("maxResult", jsonObj.get("MaxResults"));	//검색결과 한 페이지당 최대 출력 개수

				if(jsonObj2.get("bestRank") == null) {
				}else {
					int rank;
					try{
					    rank = Integer.parseInt(jsonObj2.get("bestRank").toString());
					    
					    String bestRank = Integer.toString(rank);
					    map.put("bestRank", bestRank);	//제목
						System.out.println(bestRank);
					} catch(NumberFormatException e) {
					 e.printStackTrace();
					}
				}
					
				list.add(map);
	        }
			return list;
		}
}
