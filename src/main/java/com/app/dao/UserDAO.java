package com.app.dao;

import com.app.dto.user.UserInfo;

public interface UserDAO {
	

	UserInfo findMyPageByUserId(Long userId);
}
