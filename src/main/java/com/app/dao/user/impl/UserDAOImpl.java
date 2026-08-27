package com.app.dao.user.impl;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.app.dao.user.UserDAO;

@Repository
public class UserDAOImpl implements UserDAO {
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	@Override
	public String findNickNameByUid(Long uid) {
		String nickname = sqlSessionTemplate.selectOne("user_mapper.findNickNameByUid",uid);
		return nickname;
	}
}
