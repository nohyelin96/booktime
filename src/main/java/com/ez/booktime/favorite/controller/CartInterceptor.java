package com.ez.booktime.favorite.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.ez.booktime.favorite.model.FavoriteService;

@Component
public class CartInterceptor extends HandlerInterceptorAdapter{
	private static final Logger logger
		= LoggerFactory.getLogger(CartInterceptor.class);
	
	@Autowired
	private FavoriteService favoriteService;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		int cnt = favoriteService.deleteCartOverDate();
		//회원은 30일 경과된 장바구니 모두 삭제
		//비회원은 1일 경과된 장바구니 모두 삭제
		logger.info("기일 경과 장바구니 삭제결과 cnt={}",cnt);
		
		return true;
	}
	
}
