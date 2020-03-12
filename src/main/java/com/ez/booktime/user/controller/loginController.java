package com.ez.booktime.user.controller;

import java.util.List;
import javax.mail.Authenticator;
import javax.mail.MessagingException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.ez.booktime.common.ResetPwdMail;
import com.ez.booktime.favorite.model.FavoriteService;
import com.ez.booktime.favorite.model.FavoriteVO;
import com.ez.booktime.user.model.UserService;
import com.ez.booktime.user.model.UserVO;

@Controller
public class loginController {
	private static final Logger logger 
		= LoggerFactory.getLogger(loginController.class);

	private static final Authenticator Authenticator = null;
	
	@Autowired
	private UserService userService; 
	
	@Autowired
	private ResetPwdMail resetMail;
	
	@Autowired
	private FavoriteService favoriteService;

	@RequestMapping(value="/login/login.do", method = RequestMethod.GET)
	public void login_get() {
		logger.info("로그인 화면");
	}
	
	@RequestMapping(value="/login/login.do", method = RequestMethod.POST)
	public String login_post(@RequestParam String userid,
			@RequestParam String pwd, @RequestParam(required = false) String idSave,
			Model model, HttpServletRequest request, HttpServletResponse response ) { //로그인에 필요한 아이디와 비밀번호 아이디기억여부 받아오기
		logger.info("로그인 처리하기, 파라미터 userid={}, pwd={}",userid, pwd);
		logger.info("idSave={}", idSave);
		
		//serivce유효성 검사를 마침 =>db작업 차례
		int result=userService.userGetPwd(userid, pwd);
		logger.info("로그인 처리 결과 result={}", result);
		
		String msg="", url="/login/login.do";
		if(result==userService.LOGIN_OK) { //로그인 완료시
			UserVO userVo=userService.selectByUserid(userid); //userid로 name조회
			logger.info("조회 결과, userVo.name={}", userVo.getName());
			
			String name=userVo.getName();
			logger.info("조회 결과, name={}", name);
			
			//세션생성(request,response 필요) - 쿠키에 아이디 저장
			HttpSession session=request.getSession();
			session.setAttribute("userid", userid);
			session.setAttribute("name", name);
			
			logger.info("name={}",name );
			
			Cookie ck= new Cookie("ck_userid", userid); //name은 session과 다르게 줄것
			ck.setPath("/");
			if(idSave!=null) { //id저장하기 체크를 한경우
				ck.setMaxAge(1000*24*60*60); //1000일 동안
				response.addCookie(ck);
			}else { //체크 안한경우
				ck.setMaxAge(0); //쿠키제거하깅
				response.addCookie(ck);
			}
			msg+="[ "+userid+" ]님 로그인 되었습니다.";
			url="/index.do";
			
			//비회원였을시 가지고있던 장바구니 목록 옮기기
			FavoriteVO fVo = new FavoriteVO();
			fVo.setUserid("#"+session.getId());
			fVo.setGroup("CART");
			
			List<FavoriteVO> list = favoriteService.selectFavorite(fVo);
			if(list!=null && !list.isEmpty()) {
				int cnt = 0;
				for(FavoriteVO insertVo : list) {
					insertVo.setUserid(userid);
					cnt = favoriteService.insertFavorite(insertVo);
				}
				logger.info("로그인 완료 후 장바구니 옮기기 결과  cnt={}",cnt);
			}
		}else if(result==userService.ID_NONE) { //아이디가 없을 떄
			msg="존재하지 않는 사용자입니다.";
			url="/login/login.do";
		}else if(result==userService.PWD_DISAGREE) { //비번 없을때
			msg="비밀번호가 일치하지 않습니다.";
			url="/login/login.do";
		}else {
			msg="로그인 실패!";
			url="/login/login.do";
		}
				
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		
		return "common/message";
	}
	
	@RequestMapping("/login/logout.do")
	public String logout(HttpSession session) {
		logger.info("로그아웃 처리 성공");
		session.removeAttribute("userid");
		session.removeAttribute("name");
		
		return "redirect:/index.do";
	}
	
	@RequestMapping(value="/login/nonLogin.do", method = RequestMethod.GET)
	public void nonLogin_get() {
		logger.info("비회원 주문조회 화면 보여주기");
	}
	
	@RequestMapping(value="/login/searchID.do", method = RequestMethod.GET)
	public void searchID(){
		logger.info("아이디 찾기 화면");
	}
	
	@RequestMapping(value="/login/searchPWD.do", method = RequestMethod.GET)
	public void searchPWD(){
		logger.info("비밀번호 찾기 화면");
	}
	
	@RequestMapping(value="/login/getId.do",method = RequestMethod.POST)
	public String getId(@RequestParam String name, @RequestParam String email, Model model) {
		logger.info("아이디 찾기 결과, 파라미터 name={}, email={}", name, email);
		
		UserVO vo= new UserVO();
		String result[]=email.split("@");
		vo.setEmail1(result[0]);
		vo.setEmail2(result[1]);
		vo.setName(name);
		logger.info("셋팅된 vo={}", vo);
		
		String userid=userService.selectUserid(vo);
		logger.info("결과 userid={}", userid);
		
		model.addAttribute("userid", userid);
		
		return "login/getId";
	}
	
	//인증번호 페이지 보여주기
	@RequestMapping(value="/login/yesNumber.do", method = RequestMethod.GET)
	public void yesNumber() {
		logger.info("인증번호 페이지 보여주기");
	}
	
	//비밀번호 찾기를 위해 회원정보 조회 후 있으면 인증번호를 받는 곳으로 이동
	@RequestMapping("/login/yesNumber.do")
	public String searchNumber(@RequestParam String userid, @RequestParam String name,
			@RequestParam String email, Model model, HttpServletRequest request, HttpServletResponse response) {
		logger.info("비밀번호 찾기를 위한 회원정보 조회, 파라미터 userid={}, name={}", userid, name);
		logger.info("email={}", email);
		
		UserVO vo= new UserVO();
		vo.setUserid(userid);
		vo.setName(name);
		String result[]=email.split("@");
		vo.setEmail1(result[0]);
		vo.setEmail2(result[1]);
		
		logger.info("셋팅후 vo={}", vo);
		
		int cnt=userService.searchMember(vo);
		logger.info("회원정보 조회 결과 cnt={}", cnt);
		
		HttpSession session=request.getSession();		
		
		String msg="", url="";
		if(cnt>0) {
			session.setAttribute("userid", userid);
			
			String inputEmail=email;
			logger.info("보내는 사람의 주소 inputEmail={}", inputEmail);
			
			try {
				String newPass=resetMail.mailSending(inputEmail);
				logger.info("메일 발송 성공");
				
				session.setAttribute("newpass", newPass); //임시비밀번호 저장해두기
				
			} catch (MessagingException e) {
				e.printStackTrace();
			}
			
			msg="요청하신 임시 비밀번호를 입력하신 이메일로 보내드렸습니다.";
			url="/login/yesNumber.do";
			
		}else {
			msg="잘못된 회원정보 입니다!";
			url="/login/searchPWD.do";
		}
		
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		
		return "common/message";
	}
	
	//비밀번호 변경 페이지
	@RequestMapping(value="/login/updatePwdForm.do", method = RequestMethod.POST)
	public void updatePwdForm() {
		logger.info("비밀번호 변경 폼 보여주기");
	}
	
	//비밀번호 변경 처리
	@RequestMapping(value="/login/updatePwd.do", method = RequestMethod.POST)
	public String updatePwd(@RequestParam String pwd, HttpSession session, Model model) {
		String userid=(String) session.getAttribute("userid");
		logger.info("비밀번호 변경 처리, 파라미터 pwd={}, userid={}", pwd, userid);
		
		UserVO vo= new UserVO();
		vo.setUserid(userid);
		vo.setPwd(pwd);
		
		int cnt=userService.updatePwd(vo);
		String msg="", url="";
		if(cnt>0) {
			msg="비밀번호가 변경되었습니다. 다시 로그인 해주십시오.";
			url="/login/login.do";
		}else {
			msg="비밀번호 변경에 실패했습니다.";
			url="/login/updateForm.do";
		}
		
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		
		return "common/message";
		
		
	}
	
}//loginController
