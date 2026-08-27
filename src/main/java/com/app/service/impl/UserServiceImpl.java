package com.app.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.app.dao.UserDAO;
import com.app.service.UserService;

@Service
public class UserServiceImpl implements UserService {

	@Autowired
	UserDAO userDAO;
	
	@Override
	public String findNickNameByUid(Long uid) {
		String nickname = userDAO.findNickNameByUid(uid);
		return nickname;
	}
}
