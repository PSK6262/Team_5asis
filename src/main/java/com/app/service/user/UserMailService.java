package com.app.service.user;

public interface UserMailService {
 	 public void joinWelcome(String userEmail);
	 public void sendPasswordReset(String userEmail);
	 public boolean verifyResetToken(String email, String token);
}
