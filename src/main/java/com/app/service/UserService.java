package com.app.service;

import com.app.dto.user.UserInfo;

public interface UserService {
	UserInfo getMyPageInfo(Long userId);
}
