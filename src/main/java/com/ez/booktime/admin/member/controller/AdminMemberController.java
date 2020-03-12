package com.ez.booktime.admin.member.controller;

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

import com.ez.booktime.mileage.model.MileageService;
import com.ez.booktime.mileage.model.MileageVO;
import com.ez.booktime.user.model.UserService;
import com.ez.booktime.user.model.UserVO;

@Controller
@RequestMapping("/admin")
public class AdminMemberController {
	private static final Logger logger
	=LoggerFactory.getLogger(AdminMemberController.class);
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private MileageService mileageService;
	
	//관리자 등록하기
	@RequestMapping(value="/adminJoin.do", method=RequestMethod.POST)
	public String adminJoin_post(@ModelAttribute UserVO userVo,@RequestParam String hp1,
			@RequestParam String hp2, @RequestParam String hp3, @RequestParam String email3,
			@RequestParam String pwd1,
			Model model) {
		userVo.setPwd(pwd1);
		
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
		
		logger.info("파라미터 저장후 userVo={}", userVo);
		
		int cnt=userService.insertUser(userVo);
		String msg="", url="/admin/adminLogin.do";
		if(cnt>0) {
			msg="관리자 등록이 완료되었습니다.";
		}else {
			msg="관리자 등록에 실패했습니다!";
		}
		
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		
		return "/common/message";
	}
	
	//관리자 등록할 때 아이디 중복확인하는 Ajax
	@RequestMapping("/ajaxCheckId.do")
	@ResponseBody
	public boolean ajaxCheckId(@RequestParam String userid) {
		logger.info("아이디 중복확인, 파라미터 userid={}", userid);
		
		boolean result=userService.chkUserid(userid);
		logger.info("아이디 중복확인 결과, result={}", result);

		
		boolean bool=false;
		if(result==false) {
			bool=true; //이미 존재
		}else if(result==true) {
			bool=false;	//사용가능
		}
		return bool;		
	}
	
	@RequestMapping("/memberReturn.do")
	public String memberReturn(@RequestParam String userid
			,Model model) {
		logger.info("멤버 복귀 처리 파라미터 userid={}",userid);
		
		int cnt = userService.returnMember(userid);
		String msg = "탈퇴에서 복귀하였습니다.", url="/admin/memberEditForm.do?userid="+userid+"&mode=reload";
		if(cnt<0) {
			msg = "복귀 처리중 에러가 발생하였습니다.";
		}
		
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		
		return "common/message";
	}
	
	@RequestMapping(value="/memberEditForm.do", method=RequestMethod.GET)
	public void memberEditForm_get(@RequestParam String userid,
			Model model) {
		logger.info("회원 수정");
		
		UserVO userVo=new UserVO();
		userVo=userService.selectByUserid(userid);
		
		logger.info("회원정보 조회 결과, userVo={}", userVo);
		
		model.addAttribute("userVo", userVo);
		
	}
	
	@RequestMapping(value="/memberEditForm.do", method=RequestMethod.POST)
	public String memberEditForm_post(
			@RequestParam(required = false) String userid,
			@RequestParam(required = false) String pwd,
			@RequestParam(required = false) String phone,
			@RequestParam(required = false) String email1,
			@RequestParam(required = false) String email2,
			@RequestParam(required = false) String zipcode,
			@RequestParam(required = false) String newaddress,
			@RequestParam(required = false) String parseladdress,
			@RequestParam(required = false) String addressdetail,
			@RequestParam(defaultValue = "0") int mileage,
			@RequestParam(required = false) String reason,
			Model model) {
		
		UserVO userVo= new UserVO();
		
		logger.info("userid={}",userid);
		logger.info("pwd={}",pwd);
		logger.info("phone={}",phone);
		logger.info("email1={}, email2={}",email1, email2);
		logger.info("zipcode={}", zipcode);
		logger.info("newaddress={}, parseladdress={}",newaddress, parseladdress);
		logger.info("addressdetail={}", parseladdress);
		logger.info("mileage={}, reason={}", mileage, reason);
		
		userVo.setUserid(userid);
		userVo.setPwd(pwd);
		userVo.setPhone(phone);
		userVo.setEmail1(email1);
		userVo.setEmail2(email2);
		
		userVo.setAddressdetail(addressdetail);
		userVo.setNewaddress(newaddress);
		userVo.setParseladdress(parseladdress);
		userVo.setZipcode(zipcode);
		
		MileageVO mVo = new MileageVO();
		if(mileage!=0 && reason!=null && !reason.isEmpty()) {
			userVo.setMileage(mileage);
			
			mVo.setUserid(userid);
			mVo.setReason(reason);
			mVo.setPayNo("");
			
			if(mileage<0) {
				mVo.setUsePoint(mileage*-1);
			}else if(mileage>0) {
				mVo.setSavingPoint(mileage);
			}
			
			logger.info("mVO={}", mVo);
		}
		
		logger.info("userVo={}", userVo);
		
		String msg="", url="";

		int cnt=userService.updateUser(userVo);
		logger.info("회원정보 수정 결과 cnt={}", cnt);
	
		if(cnt>0) {	
			if(mileage!=0 && reason!=null && !reason.isEmpty()) {
				cnt = mileageService.insertMileage(mVo);
			}	
			
			msg="회원정보 수정 완료!";
			url="/admin/memberEditForm.do?userid="+userid;
			
			if(cnt<0) {
				msg="회원정보 수정 실패!";
				url="/admin/memberEditForm.do?userid="+userid;
			}
		}else {
			msg="회원정보 수정 실패!";
			url="/admin/memberEditForm.do?userid="+userid;
		}
		
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		
		return "common/message";
		
	}
	
	@RequestMapping(value="/withdrowForm.do",method=RequestMethod.GET)
	public void withdrowForm_get() {
		logger.info("회원 탈퇴");
	}
	
	@RequestMapping(value="/withdrowForm.do",method=RequestMethod.POST)
	public String withdrowForm_post(@RequestParam String reason,
			@RequestParam String userid,
			Model model) {
		//회원탈퇴 처리하기

				logger.info("userid={}", userid);
				logger.info("reason={}", reason);
				
				String withdrawalreason=reason;
				
				
				UserVO userVo=new UserVO();
				userVo.setUserid(userid);
				userVo.setWithdrawalreason(withdrawalreason);
				
				String msg="", url="/admin/withdrowForm.do?mode=close";
				int cnt=userService.deleteUser(userVo);
				if(cnt>0) {
					msg="회원을 탈퇴 시켰습니다.";
				}else {
					msg="회원탈퇴가 실패했습니다";
				}
				
				model.addAttribute("msg", msg);
				model.addAttribute("url", url);
				
				return "common/message";
	}
}
