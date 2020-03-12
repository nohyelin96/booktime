package com.ez.booktime.mileage.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ez.booktime.common.DateSearchVO;
import com.ez.booktime.common.PageNumber;
import com.ez.booktime.common.PaginationInfo;
import com.ez.booktime.mileage.model.MileageService;
import com.ez.booktime.mileage.model.MileageVO;
import com.ez.booktime.user.model.UserService;
import com.ez.booktime.user.model.UserVO;

@Controller
@RequestMapping("/mypage/Mileage")
public class MileageController {
	private static final Logger logger
	 = LoggerFactory.getLogger(MileageController.class);
	
	@Autowired
	private MileageService mileageService;
	
	@Autowired
	private UserService userService;
	
	@RequestMapping("/Mileage.do")
	public void MileageList(@ModelAttribute DateSearchVO dateSearchVo,
	HttpSession session,Model model) {

		String userid=(String) session.getAttribute("userid");

		dateSearchVo.setCustomerId(userid);

		logger.info("주문내역, 파라미터 dateSearchVo={}", dateSearchVo);
		
		//유저 마일리지 조회
		UserVO vo = userService.selectByUserid(userid);
		
		//기본 오늘날짜에서 1년전 내역만 조회
		String startDay=dateSearchVo.getStartDay();
		if(startDay==null || startDay.isEmpty()) {
		Date today = new Date();
		
		Calendar yearLater = Calendar.getInstance();
		yearLater.setTime(today);
		yearLater.add(Calendar.DATE, -7);
        
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String str=sdf.format(today);
		String str2=sdf.format(yearLater.getTime());
		
		dateSearchVo.setStartDay(str2);
		dateSearchVo.setEndDay(str);			
		}
		
		//[1]
		PaginationInfo pagingInfo=new PaginationInfo();
		pagingInfo.setBlockSize(PageNumber.BLOCK_SIZE);
		pagingInfo.setCurrentPage(dateSearchVo.getCurrentPage());
		pagingInfo.setRecordCountPerPage(PageNumber.RECORD_COUNT);
				
		//[2]
		dateSearchVo.setFirstRecordIndex(pagingInfo.getFirstRecordIndex());
		dateSearchVo.setRecordCountPerPage(PageNumber.RECORD_COUNT);
		
		logger.info("값 세팅 후 파라미터 dateSearchVo={}", dateSearchVo);
		
		List<MileageVO> list=mileageService.selectMileageList(dateSearchVo);
		logger.info("마일리지 조회 리스트 크기={}",list.size());
		
		//[3]
		int totalRecord=mileageService.selectTotalRecord(dateSearchVo);
		logger.info("주문내역조회, totalRecord={}", totalRecord);
				
		pagingInfo.setTotalRecord(totalRecord);
				
		model.addAttribute("list",list);
		model.addAttribute("pagingInfo", pagingInfo);
		model.addAttribute("vo", vo);

	}
}
