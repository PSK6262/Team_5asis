package com.app.service.user;

import com.app.dto.user.UserInfo;

public interface UserService {
	public String findNickNameByUid(Long uid);
	UserInfo getMyPageInfo(Long userId);
	
	//회원가입: DB에 신규 회원가입 등록
	void signup(UserInfo userInfo);
	public void updatePassword(UserInfo userInfo);
	
	public void updateNickname(UserInfo userInfo);
	
	//회원가입: 이메일 중복 확인 (중복:1, 사용가능:0)
	int checkEmailDuplicate(String email);
	//로그인: 이메일/비밀번호 검증 및 로그인 성공유저 정보 반환
	UserInfo login(UserInfo userInfo);
	
	//이메일로 비밀번호 찾기
	String findPwByEmail(String email);
}