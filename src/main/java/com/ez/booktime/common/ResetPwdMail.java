package com.ez.booktime.common;

import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Component;

@Component
public class ResetPwdMail {
	@Autowired
	private JavaMailSender mailSender;
	
	public String mailSending(String inputEmail) throws MessagingException {
		String tomail  = inputEmail;     // 받는 사람 이메일
		String setfrom = "nohyelin960410@gmail.com";         
		
		String title ="임시 비밀번호 입니다";// 제목
	    
		String pwd="";
		CreatePwd newPwd=new CreatePwd();
		try {
			pwd=newPwd.getNewPwd();
		} catch (Exception e) {
			e.printStackTrace();
		}
		String content ="임시 비밀번호 입니다. < "+pwd+" > 이 비밀번호로 로그인 한 뒤, 비밀번호를 재설정 해주세요.";// 내용
	    

	      MimeMessage mimeMsg=mailSender.createMimeMessage();
			mimeMsg.setSubject(title);
			mimeMsg.setText(content, "utf-8","html");
			mimeMsg.setRecipient(RecipientType.TO, 
					new InternetAddress(tomail));
			mimeMsg.setFrom(new InternetAddress(setfrom));
			
			mailSender.send(mimeMsg);
			
			return pwd;
	  }
}
