package com.ez.booktime.user.model;

import java.util.List;
import java.util.Map;

import com.ez.booktime.mileage.model.MileageVO;

public interface UserDAO {
	int insertUser(UserVO userVo); //회원등록
	int chkUserid(String userid);//아이디 중복확인
	String userGetPwd(String userid); //비밀번호 체크
	UserVO selectByUserid(String userid);
	int deleteUser(UserVO userVo);
	String selectPWD(String userid);
	
	int updateMileage(MileageVO vo);
	
	String selectByEmail(UserVO userVo); //이메일로 회원찾기
	int resetPwd(UserVO userVo); //기존 비밀번호를 임시 비밀번호로 변경
	List<UserVO> selectAllUser(); //모든 회원정보 조회
	int updateUser2(UserVO userVo);
	
	int updateUser(UserVO userVo);
	int updatePwd(UserVO userVo);
	int searchMember(UserVO userVo);
	
	String selectUserid(UserVO userVo);
	List<Map<String, Object>>selectEmails();
	int returnMember(String userid);
}
