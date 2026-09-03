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
		
		// 나중에 DAO에 회원가입 메서드가 만들어지면 아래 주석을 풀고 연결!
		userDAO.insertUser(userInfo);
	}

	@Override
	public void updatePassword(UserInfo userInfo) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public int checkEmailDuplicate(String email) {
		return userDAO.checkEmailDuplicate(email);
	}
	
	
	@Override
	public void updateNickname(UserInfo userInfo) {
	    // 팀원이 컨트롤러에서 호출해서 임시로 껍데기만 만들어둠
	    // 나중에 DAO 쿼리 연결 예정
	}

	//로그인 검증 처리
	@Override
	public UserInfo login(UserInfo userInfo) {
		//1) 클라이언트가 입력한 이메일로 DB에서 회원정보 조회
		UserInfo dbUser = userDAO.findUserByEmail(userInfo.getEmail());
		
		//2) 조회된 회원정보가 존재하고, 비밀번호가 일치하는지 검증
		if (dbUser != null && dbUser.getPassword().equals(userInfo.getPassword())) {
			return dbUser;
		}
		
		//3) 아이디가 없거나 비밀번호가 틀린 경우
		return null;
	}

	//이메일로 비밀번호 찾기
	@Override
	public String findPwByEmail(String email) {
		UserInfo user = userDAO.findUserByEmail(email);
		if (user != null) {
			return user.getPassword();
		}
		return null;
	}
	
	
	@Override
	public UserInfo findUserByEmail(String email) {
		UserInfo user = userDAO.findUserByEmail(email);
		return user;
	}
}
