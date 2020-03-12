package com.ez.booktime.inquiry.controller;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.ez.booktime.common.EmailSender;

@Controller
public class InquiryController {
	private static final Logger logger
		= LoggerFactory.getLogger(InquiryController.class);
	
	@Autowired
	private JavaMailSender mailSender;
	
	@Autowired
	private EmailSender emSender;
	
	@RequestMapping(value="/inquiry/inquiryPage.do", method = RequestMethod.GET )
	public String inquiry_get() {
		logger.info("1:1 문의 화면 보여주기");
		
		return "inquiry/inquiryPage";
	}
	
	@RequestMapping(value = "/mail/mailSending.do", method = RequestMethod.POST)
	public String mailSending(HttpServletRequest request
			, HttpSession session
			, Model model) {
		String tomail  = "stjgh505@gmail.com";     // 받는 사람 이메일
		String setfrom = request.getParameter("email");         
		String title   = request.getParameter("title");      // 제목
		String type = request.getParameter("qType");
		String name = request.getParameter("name");
		String msg = request.getParameter("message");
		
		String userid = (String) session.getAttribute("userid");
		if(userid==null || userid.isEmpty()) {
			userid = "비회원";
		}
		logger.info("tomail={}, setFrom={}",tomail, setfrom);
		logger.info("title={}, type={}",title, type);
		logger.info("name={}, userid={}",name, userid);
		logger.info("msg={}", msg);
		
	    String content ="<strong>문의 유형</strong> : "+ type + 
	    				"<br>" + "<br>"
	    				+ "<strong>아이디</strong> : "+ userid + 
	    				"<br>" + "<br>"
	    				+ "<strong>이름</strong> : "+name+
	    				"<br>" + "<br>"
	    				+ "<strong>이메일</strong> : "+ setfrom + 
	    				"<br>" + "<br>"
	    				+ "<strong>내용</strong> : "+ msg;// 내용
	   
	    String alert="", url="/inquiry/inquiryPage.do";
	    setfrom = setfrom.toLowerCase();
	    tomail = tomail.toLowerCase();
	    
	    emSender.sendMail(title, content, tomail, setfrom);
	    alert="문의 메일을 발송하였습니다.";
	    url="/index.do";
	    /*
	    try {
	      MimeMessage message = mailSender.createMimeMessage();
	      MimeMessageHelper messageHelper 
	                        = new MimeMessageHelper(message, true, "UTF-8");
	      
	      messageHelper.setTo(tomail);     // 받는사람 이메일
	      messageHelper.setFrom(setfrom);  // 보내는사람 생략하거나 하면 정상작동을 안함
	      messageHelper.setSubject(title); // 메일제목은 생략이 가능하다

	      messageHelper.setText(content,true);  // 메일 내용
	     
	      mailSender.send(message);
	      alert="문의 메일을 발송하였습니다.";
	      url="/index.do";
	    } catch(Exception e){
	      e.printStackTrace();
	      alert="메일 발송에 실패하였습니다.";
	    }
	    */
	   
	    model.addAttribute("msg", alert);
	    model.addAttribute("url", url);
	    
	    return "common/message";
	  }
}
