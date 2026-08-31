package com.app.dao.user.impl;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.app.dao.user.UserDAO;
import com.app.dto.user.UserInfo;

@Repository
public class UserDAOImpl implements UserDAO {
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	@Autowired // ⭐ 이 주입 코드가 있어야 sqlSession을 쓸 수 있습니다!
    SqlSessionTemplate sqlSession;
	
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
	public void updatePassword(UserInfo userInfo) {
		// TODO Auto-generated method stub
	 sqlSession.update("user_mapper.updatePassword", userInfo);
	}

	@Override
	public void updateNickname(UserInfo userInfo) {
		// TODO Auto-generated method stub
		sqlSession.update("user_mapper.updateNickname", userInfo);
		
	}
}
