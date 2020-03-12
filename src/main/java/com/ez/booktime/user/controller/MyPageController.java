package com.ez.booktime.user.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
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

import com.ez.booktime.api.AladinAPI;
import com.ez.booktime.payment.model.PaymentDateVO;
import com.ez.booktime.payment.model.PaymentDetailVO;
import com.ez.booktime.payment.model.PaymentService;
import com.ez.booktime.payment.model.PaymentVO;
import com.ez.booktime.user.model.UserService;
import com.ez.booktime.user.model.UserVO;

@Controller
public class MyPageController {
	private static final Logger logger
	=LoggerFactory.getLogger(MyPageController.class);
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private PaymentService PaymentService;
	
	@Autowired
	private AladinAPI aladinApi;
	
	@RequestMapping(value="/mypage/mypage.do", method = RequestMethod.GET)
	public void mypage(HttpSession session
			, Model model) {
		String userid=(String)session.getAttribute("userid");
		logger.info("회원정보 화면 보여주기, 파라미터 userid={}",userid);
		
		//유저정보 - 마일리지
		UserVO vo = userService.selectByUserid(userid);
		
		//마지막 주문 내역 5건만 조회하기
		PaymentDateVO pVo = new PaymentDateVO();
	
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date today = new Date();
		pVo.setEndDay(sdf.format(today));
		pVo.setStartDay(today.getYear()+"-01-01");	//올해 1월 1일부터
		pVo.setFirstRecordIndex(0);
		pVo.setRecordCountPerPage(5);
		pVo.setUserid(userid);

		logger.info("마지막 주문내역 조회 파라미터 pVo={}",pVo);
		List<PaymentVO> list = PaymentService.selectPaymentList(pVo);
		
		//디테일정보
		List<Map<String, Object>> detailMapList = new ArrayList<Map<String,Object>>();
		if(list!=null && !list.isEmpty()) {
			for(PaymentVO tempVo:list) {
				List<PaymentDetailVO> dList = tempVo.getDetails();
				
				for(PaymentDetailVO dVo : dList) {
						try {
							Map<String, Object> detailMap = aladinApi.selectBook(dVo.getIsbn());
							
							detailMapList.add(detailMap);
						} catch (Exception e) {
							e.printStackTrace();
						}
				}
			}
		}
		logger.info("마이페이지 메인, userVo={}, paymentList.size={}",vo, list.size());
		logger.info("detailMapList.size={}",detailMapList.size());
		
		model.addAttribute("vo", vo);
		model.addAttribute("list", list);
		model.addAttribute("dList", detailMapList);
	}

	@RequestMapping(value="/mypage/memberInfo.do", method = RequestMethod.GET)
	public void memberInfo() {
		logger.info("마이페이지 화면 보여주기");
	}
	
	@RequestMapping(value="/mypage/myinfo/userout.do", method = RequestMethod.GET)
	public void userout() {
		logger.info("회원탈퇴 화면 보여주기");
	}
	
	@RequestMapping(value="/mypage/myinfo/selectPWD.do", method = RequestMethod.GET)
	public void selectPWD() {
		logger.info("비밀번호 확인 창 보여주기");
	}
	
	@RequestMapping(value="/mypage/myinfo/userInfo.do", method = RequestMethod.GET)
	public void userInfo() {
		logger.info("회원정보 화면 보여주기");
	}
	
	@RequestMapping("/mypage/myinfo/userInfo.do")
	public String UserEdit(HttpSession session, @RequestParam(required = true) String pwd, Model model) {
		String userid=(String) session.getAttribute("userid");
		
		logger.info("비밀번호 확인 후 회원정보 조회 페이지로 이동, 파라미터 pwd={}, userid={}", pwd, userid);
		
		String dbPwd=userService.selectPWD(userid);
		
		String msg="", url="/mypage/myinfo/selectPWD.do";
		if(dbPwd.equals(pwd)) {
			msg="비밀번호 확인";
			url="/mypage/myinfo/userInfo.do";
		}else {
			msg="비밀번호가 다릅니다.";
			url="/mypage/myinfo/selectPWD.do";
		}
		
		UserVO vo=userService.selectByUserid(userid);
		logger.info("회원정보 조회하기 vo={}", vo);
		session.setAttribute("birth", vo.getBirth());
		session.setAttribute("gender", vo.getGender());
		session.setAttribute("email1", vo.getEmail1());
		session.setAttribute("email2", vo.getEmail2());
		session.setAttribute("phone", vo.getPhone());
		session.setAttribute("newaddress", vo.getNewaddress());
		session.setAttribute("addressDetail", vo.getAddressdetail());
		session.setAttribute("zipcode", vo.getZipcode());
		session.setAttribute("parseladdress", vo.getParseladdress());
		
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		
		return "common/message";
	}
	
	//회원정보 수정(이메일, 전화번호, 주소, 비밀번호 )
		@RequestMapping(value="/mypage/myinfo/editUser.do", method = RequestMethod.POST)
		public String editUser(HttpSession session,
				@RequestParam String pwd,
				@RequestParam(required = false) String hp1,
				@RequestParam(required = false) String hp2,
				@RequestParam(required = false) String hp3,
				@RequestParam(required = false) String email1,
				@RequestParam(required = false) String email2,
				@RequestParam(required = false) String zipcode,
				@RequestParam(required = false) String newaddress,
				@RequestParam(required = false) String parseladdress,
				@RequestParam(required = false) String addressdetail,
				Model model) {
			
			UserVO vo= new UserVO();
			
			String userid=(String) session.getAttribute("userid");
			
			logger.info("userid={}", userid);
			logger.info("파라미터 넘어오나 확인 pwd={}, hp1={}",pwd, hp1);
			logger.info("파라미터 넘어오나 확인 hp2={}, hp3={}",hp2, hp3);
			logger.info("파라미터 넘어오나 확인 email1={}, email2={}",email1, email2);
			logger.info("파라미터 넘어오나 확인 zipcode={}", zipcode);
			logger.info("파라미터 넘어오나 확인 newaddress={}, parseladdress={}",newaddress, parseladdress);
			logger.info("파라미터 넘어오나 확인 addressdetail={}", parseladdress);
			
			String phone=hp1+"-"+hp2+"-"+hp3;
			
			vo.setPhone(phone);
			vo.setEmail1(email1);
			vo.setEmail2(email2);
			
			vo.setAddressdetail(addressdetail);
			vo.setNewaddress(newaddress);
			vo.setParseladdress(parseladdress);
			vo.setZipcode(zipcode);
			
			logger.info("셋팅된 vo={}", vo);
			
			String dbpwd=userService.selectPWD(userid); //비밀번호 찾아서 유효성 검사실시
			
			String msg="", url="";
			if(dbpwd.equals(pwd)) {
				vo.setPwd(dbpwd);
				vo.setUserid(userid);
				int cnt=userService.updateUser(vo);
				logger.info("회원정보 수정 결과 cnt={}", cnt);
				msg="회원정보 수정 완료!";
				url="/mypage/myinfo/selectPWD.do";
			}else {
				msg="비밀번호가 일치하지 않습니다.";
				url="/mypage/myinfo/userInfo.do";
			}
			
			model.addAttribute("msg", msg);
			model.addAttribute("url", url);
			
			return "common/message";
	}
		
	@RequestMapping("/mypage/myinfo/editPwd.do")
	public String editPwd(HttpSession session, @RequestParam String originPwd,
			@RequestParam String newPwd, Model model,
			HttpServletResponse response) {
		String userid=(String) session.getAttribute("userid");
		
		logger.info("비밀번호 수정 파라미터 originPwd={}, userid={}", originPwd, userid);
		logger.info("새 비밀번호 파라미터 newPwd={}", newPwd);
		
		UserVO vo= new UserVO();
		
		String dbpwd=userService.selectPWD(userid);
		
		String msg="", url="";
		if(dbpwd.equals(originPwd)) { //현재 비밀번호 맞는지 체크
			vo.setUserid(userid);
			vo.setPwd(newPwd);
			int cnt=userService.updatePwd(vo); //새로운 비번으로 업데이트
			logger.info("업데이트 후 vo={} 결과 cnt={}", vo, cnt);
			msg="비밀번호가 변경되었습니다. 다시 로그인해주십시오.";
			url="/login/login.do";
			session.invalidate();
			Cookie ck= new Cookie("ck_userid", userid);
			ck.setMaxAge(0);
			ck.setPath("/");
			response.addCookie(ck);
		}else {
			msg="비밀번호가 일치하지 않습니다!";
			url="/mypage/myinfo/userInfo.do";
		}
		
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		
		return "common/message";
	}
}
