package com.ez.booktime.common;

import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Component;

@Component
public class EmailSender {
	
	@Autowired
	private JavaMailSender mailSender;
	
	public void sendMail(String subject, String content
			, String receiver, String sender){
		MimeMessage mimeMsg = mailSender.createMimeMessage();
		try {
			mimeMsg.setSubject(subject);
			mimeMsg.setRecipient(RecipientType.TO, new InternetAddress(receiver));
			mimeMsg.setFrom(new InternetAddress(sender));
		
			mimeMsg.setContent(content,"text/html;charset=UTF-8");
			
		} catch (MessagingException e) {
			e.printStackTrace();
		}
		
		mailSender.send(mimeMsg);
	}
	
}
