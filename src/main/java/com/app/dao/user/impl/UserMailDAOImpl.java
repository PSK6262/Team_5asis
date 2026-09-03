package com.app.dao.user.impl;

import java.util.HashMap;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.app.dao.user.UserMailDAO;

@Repository
public class UserMailDAOImpl implements UserMailDAO {
    
	@Autowired
    private SqlSessionTemplate sqlSessionTemplate;

    @Override
    public void insertPasswordToken(int uid, String token) {
        Map<String, Object> params = new HashMap<>();
        params.put("uid", uid);
        params.put("token", token);
        
        // com.app.mapper.UserMailMapper.insertPasswordToken 호출
        sqlSessionTemplate.insert("user_mapper.insertPasswordToken", params);
    }
}
