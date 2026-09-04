package com.app.service.user;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.web.multipart.MultipartFile;

import com.app.dto.user.UserInfo;

public interface UserService {
	public String findNickNameByUid(Long uid);
	UserInfo getMyPageInfo(Long userId);
	
	//회원가입: DB에 신규 회원가입 등록
	void signup(UserInfo userInfo);
	public int updatePassword(UserInfo userInfo);
	
	public void updateNickname(UserInfo userInfo);
	
	boolean deleteUser(UserInfo userInfo, HttpSession session);
	
	//회원가입: 이메일 중복 확인 (중복:1, 사용가능:0)
	int checkEmailDuplicate(String email);
	//로그인: 이메일/비밀번호 검증 및 로그인 성공유저 정보 반환
	UserInfo login(UserInfo userInfo);
	
	//이메일로 비밀번호 찾기
	String findPwByEmail(String email);
	
	Map<String, Object> getUserProfile(Long userId);
	void updateProfileImage(Long loginUserId, MultipartFile uploadFile, HttpServletRequest request);
	
	public UserInfo findUserByEmail(String email);
	public int deleteUsedTokenByTokenID(String token);
}