package com.app.dao.user;

public interface UserMailDAO {
	 public void insertPasswordToken(long uid, String token);
	 boolean checkValidToken(String email, String token);
}
