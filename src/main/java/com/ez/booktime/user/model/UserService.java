package com.ez.booktime.user.model;

import java.util.List;
import java.util.Map;

//github.com/named791/booktime
import com.ez.booktime.mileage.model.MileageVO;

public interface UserService {
	//로그인 관련 상수
	public static final int LOGIN_OK=1; 
	public static final int ID_NONE=2; 
	public static final int PWD_DISAGREE=3;
	
	int insertUser(UserVO userVo);
	boolean chkUserid(String userid);
	int userGetPwd(String userid, String pwd);
	UserVO selectByUserid(String userid);
	int deleteUser(UserVO userVo);
	String selectPWD(String userid);
	int updateMileage(MileageVO vo);
	
	String selectByEmail(UserVO userVo); //이메일로 회원찾기
	int resetPwd(UserVO userVo); //기존 비밀번호를 임시 비밀번호로 변경
	List<UserVO> selectAllUser(); //모든 회원정보 조회

	int updateUser2(UserVO userVo);
	
	int updateUser(UserVO userVo); //회원정보 수정
	int updatePwd(UserVO userVo); //비밀번호 변경
	int searchMember(UserVO userVo);
	
	String selectUserid(UserVO userVo); //아이디 찾기
	List<Map<String, Object>>selectEmails();
	int returnMember(String userid);
}
