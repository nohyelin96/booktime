package com.ez.booktime.admin.member.controller;

import javax.mail.MessagingException;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ez.booktime.common.ResetPwdMail;
import com.ez.booktime.user.model.UserService;
import com.ez.booktime.user.model.UserVO;

@Controller
@RequestMapping("/admin")
public class adminMailController {
	private static final Logger logger
	=LoggerFactory.getLogger(adminMailController.class);

	@Autowired ResetPwdMail mail;

	@Autowired
	private UserService userService;

	@RequestMapping(value="/adminPassword.do", method=RequestMethod.GET)
	public void adminPassword() {
		logger.info("관리자 암호찾기 화면 보여주기");
	}

	@RequestMapping(value="/adminPassword.do", method=RequestMethod.POST)
	public String adminResetPwd(@RequestParam String inputEmail
			,@ModelAttribute UserVO vo
			,Model model){

		logger.info("보내는 사람 메일 주소={}",inputEmail);

		try {
			//이메일 주소 파싱
			String email1=inputEmail.substring(0, inputEmail.indexOf("@"));
			System.out.println("이메일 아이디"+email1);
			String email2=inputEmail.substring(inputEmail.lastIndexOf("@")+1);
			System.out.println("이메일 주소"+email2);
			
			vo.setEmail1(email1);
			vo.setEmail2(email2);
			
			//비밀번호 변경하기(재설정 유저가)
			
			String userid=userService.selectByEmail(vo);//유저 아이디 검색
			
			String msg = "일치하는 계정이 없습니다.", url="/admin/adminPassword.do";
			if(userid==null || userid.isEmpty()) {
				model.addAttribute("msg",msg);
				model.addAttribute("url",url);
				
				return "common/message";
			}
			
			String newPassword=mail.mailSending(inputEmail);
			logger.info("이메일 발송 성공");
			
			vo.setPwd(newPassword);
			logger.info("userVo={}",vo);
			int cnt=userService.resetPwd(vo);//비밀번호 변경
			
			if(cnt>0) {
				msg = "이메일로 안내된 비밀번호로 로그인해주세요.";
				url = "/admin/adminLogin.do";
			}else {
				msg = "비밀번호 변경과정에서 에러가 발생하였습니다.";
			}
			
			model.addAttribute("msg",msg);
			model.addAttribute("url",url);
			
		} catch (MessagingException e) {
			model.addAttribute("msg","이메일 발송 실패!!");
			model.addAttribute("url","/admin/adminPassword.do");
			e.printStackTrace();
		}
		
		return "common/message";
	}
	
	@RequestMapping(value = "/adminRePwd.do", method = RequestMethod.GET)
	public void adminRePwd_get() {
		logger.info("관리자 패스워드 변경창");
	}
			
	@RequestMapping(value = "/adminRePwdP.do", method = RequestMethod.POST
			, produces = "application/text; charset=UTF-8")
	@ResponseBody
	public String adminRePwd_post(@RequestParam String currPwd
			,@RequestParam String newPwd
			,HttpSession session) {
		String str = "";
		
		String userid = (String)session.getAttribute("useridA");
		logger.info("비밀번호 변경 처리 currPwd={}, newPwd={}", currPwd, newPwd);
		logger.info("관리자 userid={}",userid);
		
		int res = userService.userGetPwd(userid, currPwd);
		System.out.println(res);
		if(res==UserService.LOGIN_OK) {
			System.out.println("로그인 ok");
			UserVO vo = new UserVO();
			vo.setUserid(userid);
			vo.setPwd(newPwd);
			
			int cnt = userService.resetPwd(vo);
			if(cnt>0) {
				str = "변경하였습니다.";
			}else {
				str = "변경하지 못했습니다.";
			}
		}else if(res==UserService.PWD_DISAGREE) {
			str = "현재 비밀번호가 일치하지 않습니다.";
		}
		
		return str;
	}
}
