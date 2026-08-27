package com.app.service.impl;

import org.springframework.stereotype.Service;

import com.app.dao.UserDAO;
import com.app.dto.user.UserInfo;
import com.app.service.UserService;

@Service
public class UserServiceImpl implements UserService {

	UserDAO userDAO;
	
	public UserServiceImpl(UserDAO userDao) {
        this.userDAO = userDao;
    }
		
	public UserInfo getMyPageInfo(Long userId) {
		UserInfo user =  userDAO.findMyPageByUserId(userId);
		
		if (user == null) {
            throw new IllegalArgumentException("존재하지 않는 회원 번호입니다: " + userId);
        }
		
		return user;
	}

}
