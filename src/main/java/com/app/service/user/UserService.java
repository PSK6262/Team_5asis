package com.app.service.user;

import com.app.dto.user.UserInfo;

public interface UserService {
	public String 	findNickNameByUid(Long uid);
	UserInfo getMyPageInfo(Long userId);
	
	void signup(UserInfo userInfo);
	public void updatePassword(UserInfo userInfo);
	
	public void updateNickname(UserInfo userInfo);
	int checkEmailDuplicate(String email);
}