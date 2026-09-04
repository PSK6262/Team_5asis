package com.app.dao.user.impl;

import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.app.dao.user.UserDAO;
import com.app.dto.user.UserInfo;

@Repository
public class UserDAOImpl implements UserDAO {
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	
	
	@Override
	public String findNickNameByUid(Long uid) {
		String nickname = sqlSessionTemplate.selectOne("user_mapper.findNickNameByUid",uid);
		return nickname;
	}
	
	@Override
	public UserInfo findMyPageByUserId(Long userId) {
		return sqlSessionTemplate.selectOne("user_mapper.findMyPageByUserId",userId);
	}

	@Override
	public int updatePassword(UserInfo userInfo) {
		int result = sqlSessionTemplate.update("user_mapper.updatePassword", userInfo);
		return result;
	}

	//회원 정보
	@Override
	public void insertUser(UserInfo userInfo) {
		sqlSessionTemplate.insert("user_mapper.insertUser", userInfo);
	}

	//아이디(이메일) 중복체크
	@Override
	public int checkEmailDuplicate(String email) {
		return sqlSessionTemplate.selectOne("user_mapper.checkEmailDuplicate", email);
	}

	//로그인 시 이메일로 DB에서 회원 단일정보 조회
	@Override
	public UserInfo findUserByEmail(String email) {
		return sqlSessionTemplate.selectOne("user_mapper.findUserByEmail", email);
	}

	@Override
	public Map<String, Object> getUserProfile(Long userId) {
		
		return sqlSessionTemplate.selectOne("user_mapper.getUserProfile", userId);
	}

	@Override
	public int insertProfileInfo(Map<String, Object> fileParam) {
		// TODO Auto-generated method stub
		return sqlSessionTemplate.insert("user_mapper.insertProfileInfo", fileParam);
	}
	
	@Override
	public int updateUserProfileImageId(Map<String, Object> userParam) {
		// TODO Auto-generated method stub
		return sqlSessionTemplate.update("user_mapper.updateUserProfileImageId", userParam);
	}
	
	@Override
	public long findUidByUserEmail(String email) {
		Integer uid = sqlSessionTemplate.selectOne("user_mapper.findUidByUserEmail",email);
		if (uid == null) {
			return -1;
		}
		return uid;
	}

	@Override
	public int deleteUsedTokenByTokenID(String token) {
		int result = sqlSessionTemplate.delete("user_mapper.deleteUsedTokenByTokenID", token);
		return result;
	}
	
	@Override
	public int findStatusByUserEmail(String email) {
		int result = sqlSessionTemplate.selectOne("user_mapper.findStatusByUserEmail",email);
		return result;
	}
	
}
