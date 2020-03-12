package com.ez.booktime.user.controller;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

@Component
public class LoginInterceptor extends HandlerInterceptorAdapter{
	private static final Logger logger
	=LoggerFactory.getLogger(LoginInterceptor.class);

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		logger.info("컨트롤러 수행 전 호출 - preHandle()" );
		
		//uri읽어오기
		//http://localhost:9090/booktime/login/login.do => login이 필요한 단계의 uri
		String uri=request.getRequestURI();
		logger.info("uri={}", uri);
		
		//세션 가져오기
		HttpSession session=request.getSession();
		String userid=(String) session.getAttribute("userid");
		
		//로그인 되어있지 않으면 로그인하라고 한다.
		if(userid==null || userid.isEmpty()) {
			response.setContentType("text/html;charset=utf-8");
			PrintWriter out=response.getWriter();
			out.print("<script>");
			out.print("location.href='"+request.getContextPath()+"/login/login.do';");
			out.print("</script>");
			return false;
		}else {
			return true;
		}
	}
	
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		logger.info("로그인 인터셉터 성공!");
	}
	
}
