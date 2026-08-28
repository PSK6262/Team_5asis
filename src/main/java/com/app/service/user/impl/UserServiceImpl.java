package com.app.service.user.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.app.dao.user.UserDAO;
import com.app.dto.user.UserInfo;
import com.app.service.user.UserService;

@Service
public class UserServiceImpl implements UserService {

	@Autowired
	UserDAO userDAO;
	
	@Override
	public String findNickNameByUid(Long uid) {
		String nickname = userDAO.findNickNameByUid(uid);
		return nickname;
	}
	
	@Override
	public UserInfo getMyPageInfo(Long userId) {
		UserInfo user =  userDAO.findMyPageByUserId(userId);
		
		if (user == null) {
            throw new IllegalArgumentException("존재하지 않는 회원 번호입니다: " + userId);
        }
		
		return user;
	}
	
	
	@Override
	public void signup(UserInfo userInfo) {
		// 컨트롤러에서 넘어온 데이터 확인용 로그
		System.out.println("====== UserService 단 도착 ======");
		System.out.println("가입 이메일: " + userInfo.getEmail());
		
		// 나중에 DAO에 회원가입 메서드가 만들어지면 아래 주석을 풀고 연결해 주세요!
		// userDAO.insertUser(userInfo); 
	}
	
}
