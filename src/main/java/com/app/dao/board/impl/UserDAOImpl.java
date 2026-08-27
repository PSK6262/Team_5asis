package com.app.dao.impl;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.app.dao.UserDAO;
import com.app.dto.user.UserInfo;

@Repository
public class UserDAOImpl implements UserDAO {
	
	SqlSessionTemplate sqlSessionTemplate;
	
	public UserDAOImpl(SqlSessionTemplate sqlSessionTemplate) {
        this.sqlSessionTemplate = sqlSessionTemplate;
    }

	@Override
	public UserInfo findMyPageByUserId(Long userId) {
		
		return sqlSessionTemplate.selectOne("com.app.dao.UserDAO.findMyPageByUserId",userId);
	}
}
