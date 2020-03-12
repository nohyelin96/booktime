package com.ez.booktime.freeBoard.controller;

import java.io.File;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.ez.booktime.freeBoard.model.FreeBoardService;
import com.ez.booktime.freeBoard.model.FreeBoardVO;
import com.google.gson.JsonObject;

@Controller
public class UploadController {
	private static final Logger logger
	= LoggerFactory.getLogger(UploadController.class);
	
	@Autowired
	private FreeBoardService boardService;
	
	@RequestMapping(value="freeBoard/imageUpload.do", method=RequestMethod.POST)
	@ResponseBody
	public String fileUpload(HttpServletRequest req, HttpServletResponse resp, 
                 MultipartHttpServletRequest multiFile) throws Exception {
		JsonObject json = new JsonObject();
		PrintWriter printWriter = null;
		OutputStream out = null;
		MultipartFile file = multiFile.getFile("upload");
		if(file != null){
			if(file.getSize() > 0 && StringUtils.isNotBlank(file.getName())){
				if(file.getContentType().toLowerCase().startsWith("image/")){
					try{
						String fileName = file.getName();
						byte[] bytes = file.getBytes();
						String uploadPath = req.getServletContext().getRealPath("/img");
						File uploadFile = new File(uploadPath);
						if(!uploadFile.exists()){
							uploadFile.mkdirs();
						}
						fileName = UUID.randomUUID().toString();
						uploadPath = uploadPath + "/" + fileName;
						out = new FileOutputStream(new File(uploadPath));
                        out.write(bytes);
                        
                        printWriter = resp.getWriter();
                        resp.setContentType("text/html");
                        String fileUrl = req.getContextPath() + "/img/" + fileName;
                        
                        // json 데이터로 등록
                        // {"uploaded" : 1, "fileName" : "test.jpg", "url" : "/img/test.jpg"}
                        // 이런 형태로 리턴이 나가야함.
                        json.addProperty("uploaded", 1);
                        json.addProperty("fileName", fileName);
                        json.addProperty("url", fileUrl);
                        
                        printWriter.println(json);
                    }catch(IOException e){
                        e.printStackTrace();
                    }finally{
                        if(out != null){
                            out.close();
                        }
                        if(printWriter != null){
                            printWriter.close();
                        }		
					}
				}
			}
		}
		return null;
	}

	public String getEventImageUrl(String content, int size) {
		String str = "";
		
		if(content!=null && !content.isEmpty()) {
			String temp = removeOverImg(content);
			if(content.indexOf("<img")>-1) {
				String img = temp.substring(temp.indexOf("<img"),temp.lastIndexOf("px\" />")+6 );
				
				double per = (double)size/Integer.parseInt(img.substring(img.indexOf("width:")+6, img.lastIndexOf("px\" ")));
				int height = Integer.parseInt(img.substring(img.indexOf("height:")+7, img.lastIndexOf("px;")));
				System.out.println(per+"????"+height);
				
				img = img.replace(img.substring(img.indexOf("width:"), img.lastIndexOf("px\" ")), "width:"+size);
				str = img.replace(img.substring(img.indexOf("height:"), img.lastIndexOf("px;")), "height:"+(per*height));
			}
		}
		
		return str;
	}

	public String removeOverImg(String content) {
		String str = "";
		if(content!=null && !content.isEmpty() && content.split("<img").length>2) {
			str = content.substring(0, content.lastIndexOf("<img"));
			
			return removeOverImg(str);
		}else {
			str = content;
		}
		
		return str;
	}
	
	public List<Map<String, Object>> getEventMapList(int imgWidth) {
		List<FreeBoardVO> listB = boardService.selectBoardByCate("이벤트");
		List<Map<String, Object>> eventList = new ArrayList<Map<String,Object>>();
		for(FreeBoardVO vo :listB) {
			Map<String, Object> eMap = new HashMap<String, Object>();
			String imgUrl = getEventImageUrl(vo.getContent(), imgWidth);
			
			eMap.put("imgUrl",  imgUrl);
			eMap.put("title", vo.getTitle());
			eMap.put("content", vo.getContent());
			eMap.put("no", vo.getBoardNo());
			
			eventList.add(eMap);
		}
		
		return eventList;
	}
}
