package com.ez.booktime.user.controller;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ez.booktime.user.model.UserService;
import com.ez.booktime.user.model.UserVO;
import com.google.api.client.googleapis.auth.clientlogin.ClientLogin.Response;

import oracle.net.aso.p;

@Controller
public class UserController {//logger생성 구문 위에 어노테이션을 쓰지 말것! 주의
	private static final Logger logger
	=LoggerFactory.getLogger(UserController.class);
	
	@Autowired
	private UserService userService;
	
	//약관화면
	@RequestMapping("/user/provision.do")
	public void provision() {
		logger.info("약관화면");
	}
	//약관화면 보여주기
	@RequestMapping("/user/agreement.do")
	public String  agreement_get() {
		logger.info("회원약관 화면 보여주기");
		
		return "/user/agreement";
	}
	//회원가입 화면 보여주기
	@RequestMapping("/user/register.do")
	public String user_get() {
		logger.info("회원가입 화면 보여주기");
		
		return "/user/register";
	}
	
	@RequestMapping("/user/userWrite.do")
	public String insertUser(@ModelAttribute UserVO userVo,@RequestParam String hp1,
			@RequestParam String hp2, @RequestParam String hp3, @RequestParam String email3,
			Model model) {
		logger.info("회원가입 처리하기, 파라미터 userVo={}, hp1={}", userVo, hp1);
		logger.info("hp2={}, hp3={}",hp2, hp3 );
		logger.info("email3={}", email3);
		
		String phone="";
		if(hp2!=null && !hp2.isEmpty() && hp3!=null && !hp3.isEmpty()) {
			phone=hp1+"-"+hp2+"-"+hp3;
		}
		userVo.setPhone(phone);
		
		String email1=userVo.getEmail1();
		String email2=userVo.getEmail2();
		
		if(email1==null || email1.isEmpty()) {
			email1="";
			email2="";
		}else {
			if(email2.equals("etc")) {
				email2=email3;
			}
		}
		userVo.setEmail1(email1);
		userVo.setEmail2(email2);
		
		char agree = userVo.getEmailagree();
		if(agree!='Y') agree = 'N';
		userVo.setEmailagree(agree);
		
		logger.info("파라미터 저장후 userVo={}", userVo);
		
		int cnt=userService.insertUser(userVo);
		String msg="", url="/login/login.do";
		if(cnt>0) {
			msg="회원가입이 완료되었습니다.";
		}else {
			msg="회원가입에 실패했습니다!";
		}
		
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		
		return "/common/message";
	}
	
	@RequestMapping("/user/chkId.do")
	public String chkId(@RequestParam String userid, Model model ) {
		logger.info("아이디 중복체크, 파라미터 userid={}", userid);
		
		boolean result=false;
		if(userid!=null && !userid.isEmpty()) {
			result=userService.chkUserid(userid);
			logger.info("아이디 중복확인 결과 result={}", result);
		}
		
		model.addAttribute("result", result);
		return "/user/chkId";
	}
	
	@RequestMapping("user/userOut.do")
	public String userOut(@RequestParam String withdrawalreason, @RequestParam String pwd, HttpSession session, HttpServletResponse response , Model model) {
		//회원탈퇴 처리하기
		String userid=(String) session.getAttribute("userid"); //아이디 가져오기
		logger.info("회원탈퇴, 파라미터 pwd={}, userid={}", pwd, userid);
		logger.info("withdrawalreason={}", withdrawalreason);

		String msg="", url="/mypage/myinfo/userout.do";
		
		int result=userService.userGetPwd(userid, pwd); //비밀번호 체크
		logger.info("비밀번호 체크 result={}", result);
		if(result==UserService.LOGIN_OK) { //로그인 되어있으면
			UserVO vo= new UserVO();
			vo.setUserid(userid);
			vo.setWithdrawalreason(withdrawalreason);
			int cnt=userService.deleteUser(vo);
			
			if(cnt>0) {
				msg="회원탈퇴가 완료되었습니다.";
				url="/index.do";
				session.invalidate();
				Cookie ck=new Cookie("ck_userid",userid); //쿠키 제거
				ck.setMaxAge(0);
				ck.setPath("/");
				response.addCookie(ck);
			}else {
				msg="회원탈퇴중 오류가 발생했습니다.!";
				url="/mypage/myinfo/userout.do";
			}
		}else if(result==UserService.PWD_DISAGREE) {
			msg="비밀번호가 일치하지 않습니다!";
			url="/mypage/myinfo/userout.do";
		}else {
			msg="오류발생!";
			url="/mypage/myinfo/userout.do";
		}
		
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		
		return "common/message";
	}
	
	
	
}
