package com.app.service.user.impl;

import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;

import com.app.dao.user.UserDAO;
import com.app.service.user.UserMailService;
import com.app.util.SendMail;

public class UserMailServiceImpl implements UserMailService {

	@Autowired
    private SendMail sendMail; // 작성한 SendMail 컴포넌트 주입
	
	@Autowired
	private UserDAO userDAO;

	@Override
    public void joinWelcome(String userEmail) {
        String title = "[5asis] 회원가입을 환영합니다!";
        String content = "<h3>안녕하세요!</h3>"
                       + "<p>5asis 가입이 완료되었습니다.</p>"
                       + "<p>프로젝트 테스트.</p>";

        boolean isSuccess = sendMail.send(userEmail, title, content);
        
        if (isSuccess) {
            System.out.println("서비스 단: 메일 발송 로직 처리 완료");
        } else {
            System.out.println("서비스 단: 메일 발송 중 예외 발생");
        }
    }
	@Override
	public void sendPasswordReset(String userEmail) {
        // 1. 핵심 기능: 무작위 UUID 토큰 생성
        String token = UUID.randomUUID().toString();
        
        // 2. 테스트용 복귀 URL 구성
        String resetUrl = "http://192.168.0.66:8080/user/reset?email=" + userEmail + "&token=" + token;

        // 3. UI 스타일을 전부 뺀 최소한의 본문 구성
        String title = "[5asis] 비밀번호 재설정 링크입니다.";
        String content = "안녕하세요. 비밀번호 재설정 요청 메일입니다.\n\n"
                       + "아래 링크를 클릭하면 비밀번호 변경 페이지로 이동합니다.\n"
                       + "<a href='" + resetUrl + "'>" + resetUrl + "</a>";

        // 4. 발송
        boolean isSuccess = sendMail.send(userEmail, title, content);
        
        if (isSuccess) {
            System.out.println("발송 성공 -> 토큰값: " + token);
            
            long uid = userDAO.findUidByUserEmail(userEmail);
            
        } else {
            System.out.println("발송 실패");
        }
	}
}
