package com.ez.booktime.api;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Iterator;
import java.util.Map;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

@Component
public class Utility {
	private static final Logger logger
		= LoggerFactory.getLogger(Utility.class);
	
	public JSONObject getJson(URL url, String method, Map<String, String> keyMap) throws Exception {
		System.out.println("유틸");
		HttpURLConnection con = (HttpURLConnection) url.openConnection();
		method = method.toUpperCase();
		con.setRequestMethod(method);
		
		//post방식, 서버키와 시크릿키 파라미터 세팅
		if(method.equals("POST") && keyMap!=null && !keyMap.isEmpty()) {
			con.setDoOutput(true);
			con.setRequestProperty("Content-type", "application/x-www-form-urlencoded");

			Iterator<String> iter = keyMap.keySet().iterator();
			String param = "";
			while(iter.hasNext()) {
				String key = iter.next();
				String val = keyMap.get(key);
				
				if(key.equals("Authorization")) {
					con.setRequestProperty(key, val);
					
					continue;
				}
				param += (key +"="+val+"&");
			}//while
			param = param.substring(0, param.lastIndexOf("&"));
			logger.info("POST-key=Value : {}",param);
			
			OutputStreamWriter wr = new OutputStreamWriter(con.getOutputStream());
			wr.write(param);
			wr.flush();
			wr.close();
		}
		
		int responseCode = con.getResponseCode();
        BufferedReader br;
        if(responseCode==200) { // 정상 호출
            br = new BufferedReader(new InputStreamReader(con.getInputStream()));
        } else {  // 에러 발생
        	logger.info("에러 발생 responseCode={}",responseCode);
            br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
        }
        
        JSONParser jsonParser = new JSONParser();
		JSONObject jsonObj = (JSONObject) jsonParser.parse(br);
        br.close();
       
        return jsonObj;
	}
}
