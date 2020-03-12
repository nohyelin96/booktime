package com.ez.booktime.mileage.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.ez.booktime.mileage.model.MileageService;

@Component
public class MileageIntercepter extends HandlerInterceptorAdapter{
	private final static Logger logger
		= LoggerFactory.getLogger(MileageIntercepter.class);
	
	@Autowired
	private MileageService mileageService;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		int cnt = mileageService.chkMileageLimit();
		
		logger.info("마일리지 유효기간 체크 결과 cnt={}",cnt);
		return true;
	}

}
