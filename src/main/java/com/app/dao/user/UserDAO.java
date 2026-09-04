package com.app.dao.user;

import java.util.Map;

import com.app.dto.user.UserInfo;

public interface UserDAO {
	public String 	findNickNameByUid(Long uid);	
	public UserInfo findMyPageByUserId(Long userId);
	
	public void updatePassword(UserInfo userInfo);
	
	// 회원가입: 유저 정보 등록 추가
	public void insertUser(UserInfo userInfo);
	// 이메일 중복체크
	public int checkEmailDuplicate(String email);
	UserInfo findUserByEmail(String email);	
	Map<String, Object> getUserProfile(Long userId);
	int insertProfileInfo(Map<String, Object> fileParam);
	int updateUserProfileImageId(Map<String, Object> userParam);
	public long findUidByUserEmail(String email);
}
