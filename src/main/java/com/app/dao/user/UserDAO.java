package com.app.dao.user;

import com.app.dto.user.UserInfo;

public interface UserDAO {
	public String 	findNickNameByUid(Long uid);	
	public UserInfo findMyPageByUserId(Long userId);
}
