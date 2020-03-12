package com.ez.booktime.common;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

@Component
public class FileUploadUtil {
	@Resource(name = "fileUpProperties")
	private Properties props;
	
	public static final int REVIEW_IMG_UPLOAD=1;
	
	private static final Logger logger
		= LoggerFactory.getLogger(FileUploadUtil.class);
	
	public List<Map<String, Object>> fileUpload(HttpServletRequest request
			,int uploadPathType){
		//파일 업로드 처리
		MultipartHttpServletRequest multiReq = (MultipartHttpServletRequest) request;
		
		Map<String, MultipartFile> fileMap = multiReq.getFileMap();
		
		//결과를 넣을 List
		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
		
		Iterator<String> iter = fileMap.keySet().iterator();
		while(iter.hasNext()) {
			MultipartFile oneFile = fileMap.get(iter.next());
			
			//업로드 된 파일이 있는 경우
			if(!oneFile.isEmpty()) {
				String originalFilename = oneFile.getOriginalFilename();
				String fileName = getUniqueFileName(originalFilename);
				long fileSize = oneFile.getSize();
				
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("originalFileName", originalFilename);
				map.put("fileName", fileName);
				map.put("fileSize", fileSize);
				
				list.add(map);
				
				//업로드 처리
				String upPath = getFilePath(request, uploadPathType);
				
				File file = new File(upPath, fileName);
				
				try {
					oneFile.transferTo(file);
				} catch (IllegalStateException e) {
					e.printStackTrace();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}//while
		
		return list;
	}
	
	public String getFilePath(HttpServletRequest request, int uploadPathType) {
		String path = "";
		
		String type = props.getProperty("file.upload.type");
		logger.info("type={}",type);
		if(type.equals("test")) {
			if(uploadPathType==REVIEW_IMG_UPLOAD) {
				path = props.getProperty("reviewImgFile.upload.path.test");
			}
		}else if(type.equals("deploy")) {//배포시 실제 경로
			String dirName = "";
			
			if(uploadPathType==REVIEW_IMG_UPLOAD) {
				dirName = props.getProperty("reviewImgFile.upload.path");
			}
			
			path = request.getServletContext().getRealPath(dirName);
		}
		logger.info("업로드 경로 path={}",path);
		
		return path;
	}
	
	public String getUniqueFileName(String originalFilename) {
		//img.jpg => booktime!img20200203123150123.txt
		int idx = originalFilename.lastIndexOf(".");
		String fileName = originalFilename.substring(0, idx);
		String extension = originalFilename.substring(idx);
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSSS");
		Date today = new Date();
		
		String res = "booktime!"+fileName+sdf.format(today)+extension;
		logger.info("변경된 fileName = {}",res);
		
		return res;
	}
}
