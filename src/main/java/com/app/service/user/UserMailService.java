package com.app.service.user;

public interface UserMailService {
 	 public void joinWelcome(String userEmail);
	 void sendPasswordReset(String userEmail);
}
