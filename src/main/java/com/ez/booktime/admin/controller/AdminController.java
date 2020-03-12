package com.ez.booktime.admin.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ez.booktime.api.ImPortAPI;
import com.ez.booktime.common.EmailForm;
import com.ez.booktime.common.EmailSender;
import com.ez.booktime.mileage.model.MileageVO;
import com.ez.booktime.payment.model.PaymentDateVO;
import com.ez.booktime.payment.model.PaymentService;
import com.ez.booktime.payment.model.PaymentVO;
import com.ez.booktime.user.model.UserService;
import com.ez.booktime.user.model.UserVO;

@Controller
@RequestMapping("/admin")
public class AdminController {
	private static final Logger logger
	=LoggerFactory.getLogger(AdminController.class);
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private PaymentService paymentService;
	
	@Autowired
	private ImPortAPI imPortApi;
	
	@Autowired
	private EmailSender mailSender;
	
	@Autowired
	private EmailForm form;
	
	@RequestMapping(value="/adminLogin.do", method=RequestMethod.GET)
	public void adminLogin_get() {
		logger.info("관리자 로그인 화면 보여주기");
	}
	
	@RequestMapping(value="/adminLogin.do", method=RequestMethod.POST)
	public String adminLogin_post(@RequestParam String userid,
			@RequestParam String pwd, @RequestParam(required = false) String idSave,
			Model model, HttpServletRequest request, HttpServletResponse response) {
		logger.info("로그인 처리하기, 파라미터 userid={}, pwd={}",userid, pwd);
		logger.info("idSave={}", idSave);

		int result=userService.userGetPwd(userid, pwd);
		logger.info("로그인 처리 결과 result={}", result);
		
		
		UserVO userVo=userService.selectByUserid(userid);
		String grade=userVo.getGrade();
		
		String msg="", url="/login/login.do";
		if(result==userService.LOGIN_OK) {
			
			HttpSession session=request.getSession();
			session.setAttribute("useridA", userid);

			Cookie ck= new Cookie("ck_useridA", userid);
			ck.setPath("/");
			if(idSave!=null) { //id저장
				ck.setMaxAge(1000*24*60*60); 
				response.addCookie(ck);
			}else { 
				ck.setMaxAge(0); 
				response.addCookie(ck);
			}
			
			if(grade.equals("A")) {
				msg+="[ "+userid+" ]님 로그인 되었습니다.";
				url="/admin/adminMain.do";
			}else {
				msg="관리자 아이디가 아닙니다.";
				url="/admin/adminLogin.do";
			}
		}else if(result==userService.ID_NONE) { //아이디가 없을 떄
			msg="존재하지 않는 관리자입니다.";
			url="/admin/adminLogin.do";
		}else if(result==userService.PWD_DISAGREE) { //비번 없을때
			msg="비밀번호가 일치하지 않습니다.";
			url="/admin/adminLogin.do";
		}else {
			msg="로그인 실패!";
			url="/admin/adminLogin.do";
		}
				
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		
		return "common/message";
	}
	
	@RequestMapping("/adminLogout.do")
	public String logout(HttpSession session) {
		logger.info("로그아웃 처리 성공");
		session.removeAttribute("useridA");
		
		return "redirect:/admin/adminLogin.do";
	}
	
	@RequestMapping(value="/adminJoin.do", method=RequestMethod.GET)
	public void adminJoin() {
		logger.info("관리자 등록 화면 보여주기");
	}
	
	@RequestMapping("/adminMember.do")
	public void adminMember(Model model) {
		logger.info("관리자 회원관리 화면 보여주기");
		
		List<UserVO> list=userService.selectAllUser();
		logger.info("리스트 크기={}",list.size());
		model.addAttribute("list",list);
	}
	
	@RequestMapping("/adminEvent.do")
	public void adminEvent() {
		logger.info("관리자 이벤트관리 화면 보여주기");
	}
	
	@RequestMapping("/adminCart.do")
	public void adminCart(@ModelAttribute PaymentDateVO vo
			,Model model) {
		logger.info("관리자 주문관리 화면 보여주기, 파라미터 vo={}",vo);
		
		//주문 리스트
		List<PaymentVO> list = paymentService.selectPaymentList(vo);
		
		
		model.addAttribute("list", list);
	}
	
	@RequestMapping("/adminCartEdit.do")
	@ResponseBody
	public int adminCart(@ModelAttribute PaymentVO pVo
			, @ModelAttribute MileageVO mVo) {
		List<PaymentVO> voList = pVo.getVoList();
		List<MileageVO> mList = mVo.getmList();
		
		logger.info("관리자, 주문상태 변경 처리, 파라미터 voList={}, mList={}",voList,mList);
		int cnt = 0;
		
		//진행상태 업데이트
		if(voList!=null && mList!=null && !voList.isEmpty() && !mList.isEmpty()) {
			for(int i=0;i<voList.size();i++) {
				PaymentVO vo = voList.get(i);
				MileageVO voM = mList.get(i);
				
				if(vo.getPayNo()!=null && !vo.getPayNo().isEmpty()) {
					
					if(vo.getProgress().equals("환불 처리됨")) {
						boolean bool = false;
						try {
							String payNo = vo.getPayNo();
							if(payNo.length()<12) {	//payNo가 12자리여야하는데 DB에 들어가면서 앞의 0이 사라짐, 12자리만큼 채워넣기
								String str = "";
								for(int p=0;p<12-payNo.length();p++) {
									str += "0";
								}
								
								payNo = str+payNo;
							}
							
							bool = imPortApi.cancel_Payment(payNo);
							
							if(!bool) {
								cnt += 40000;	//아임포트 테스트모드에서 하루지난 거래내역은 취소가 안됨
								paymentService.updateProgress(vo, voM);
								continue;
							}else {
								
							}
						} catch (Exception e) {
							e.printStackTrace();
						}
					}
					
					cnt += paymentService.updateProgress(vo, voM);
				}
			}
		}
		
		return cnt;
	}
	
	@RequestMapping("/mailing.do")
	public void mailing(Model model) {
		logger.info("관리자 메일링 팝업 띄우기");
		List<Map<String, Object>> list = userService.selectEmails();
		logger.info("관리자 메일링, 메일 list.size={}", list.size());
		
		List<String> arr = new ArrayList<String>();
		for(Map<String, Object> map : list) {
			arr.add((String) map.get("email"));
		}
		
		model.addAttribute("list", list);
		model.addAttribute("arr", arr);
	}
}
