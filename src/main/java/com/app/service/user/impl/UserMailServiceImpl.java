package com.app.service.user.impl;

import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;

import com.app.dao.user.UserDAO;
import com.app.dao.user.UserMailDAO;
import com.app.service.user.UserMailService;
import com.app.util.SendMail;

public class UserMailServiceImpl implements UserMailService {

	@Autowired
    private SendMail sendMail; // 작성한 SendMail 컴포넌트 주입
	
	@Autowired
	private UserDAO userDAO;
	
	@Autowired
	private UserMailDAO userMailDAO;

	@Override
    public void joinWelcome(String userEmail) {
		String title = "[5ASIS] 웰컴 탑승 완료! 5ASIS에 오신 것을 환영합니다! 🎮";
		String content = "<!DOCTYPE html>"
		               + "<html lang='ko'>"
		               + "<head>"
		               + "    <meta charset='UTF-8'>"
		               + "    <meta name='viewport' content='width=device-width, initial-scale=1.0'>"
		               + "</head>"
		               + "<body style='margin: 0; padding: 0; background-color: #f4f6f8; font-family: \"Malgun Gothic\", \"Apple SD Gothic Neo\", sans-serif;'>"
		               + "    <table border='0' cellpadding='0' cellspacing='0' width='100%' style='background-color: #f4f6f8; padding: 40px 10px;'>"
		               + "        <tr>"
		               + "            <td align='center'>"
		               + "                <table border='0' cellpadding='0' cellspacing='0' width='100%' style='max-width: 600px; background-color: #ffffff; border-radius: 8px; box-shadow: 0 4px 10px rgba(0,0,0,0.05); overflow: hidden;'>"
		               + "                    <!-- 상단 헤더 영역 -->"
		               + "                    <tr>"
		               + "                        <td style='padding: 40px 40px 20px 40px; background-color: #2F80ED; text-align: left;'>"
		               + "                            <h1 style='margin: 0; color: #ffffff; font-size: 28px; font-weight: bold; letter-spacing: -1px;'>5ASIS</h1>"
		               + "                        </td>"
		               + "                    </tr>"
		               + "                    <!-- 본문 영역 -->"
		               + "                    <tr>"
		               + "                        <td style='padding: 40px; color: #333333; font-size: 15px; line-height: 1.6;'>"
		               + "                            <h2 style='margin: 0 0 20px 0; color: #1a1a1a; font-size: 22px; font-weight: bold;'>반갑습니다, 모험가님! ⚔️</h2>"
		               + "                            <p style='margin: 0 0 15px 0;'>게이머들의 쉼터, <strong>5ASIS</strong>의 새로운 동료가 되신 것을 진심으로 환영합니다!</p>"
		               + "                            <p style='margin: 0 0 35px 0; color: #555555;'>5ASIS에서는 최신 게임 정보, 따끈따끈한 공략, 그리고 함께 플레이할 든든한 파티원들을 언제든지 만나보실 수 있습니다. 지금 바로 커뮤니티로 입장해 보세요!</p>"
		               + "                            "
		               + "                            <table border='0' cellpadding='0' cellspacing='0' width='100%' style='margin-bottom: 30px;'>"
		               + "                                <tr>"
		               + "                                    <td style='padding: 15px 0; border-bottom: 1px solid #f0f0f0;'>"
		               + "                                        <strong style='color: #2F80ED; font-size: 15px;'>🔥 실시간 트렌드 & 공략 보기</strong>"
		               + "                                        <p style='margin: 5px 0 0 0; color: #666666; font-size: 14px;'>지금 가장 핫한 게임 이슈와 유저들이 직접 작성한 꿀팁 공략을 확인하세요.</p>"
		               + "                                    </td>"
		               + "                                </tr>"
		               + "                                <tr>"
		               + "                                    <td style='padding: 15px 0; border-bottom: 1px solid #f0f0f0;'>"
		               + "                                        <strong style='color: #2F80ED; font-size: 15px;'>👥 함께할 파티원 모집하기</strong>"
		               + "                                        <p style='margin: 5px 0 0 0; color: #666666; font-size: 14px;'>혼자 하는 게임은 이제 그만! 나와 성향이 맞는 길드와 팀원을 찾아보세요.</p>"
		               + "                                    </td>"
		               + "                                </tr>"
		               + "                            </table>"
		               + "                            "
		               + "                            <!-- 버튼 영역 -->"
		               + "                            <table border='0' cellpadding='0' cellspacing='0' width='100%' style='margin: 40px 0;'>"
		               + "                                <tr>"
		               + "                                    <td align='center'>"
		               + "                                        <a href='https://your-domain.com' target='_blank' style='background-color: #2F80ED; color: #ffffff; padding: 14px 35px; text-decoration: none; border-radius: 6px; font-weight: bold; font-size: 16px; display: inline-block; box-shadow: 0 4px 6px rgba(47, 128, 237, 0.2);'>입장하기</a>"
		               + "                                    </td>"
		               + "                                </tr>"
		               + "                            </table>"
		               + "                            <p style='margin: 40px 0 0 0; color: #555555;'>그럼 5ASIS에서 즐거운 모험 되세요!<br><strong style='color: #1a1a1a;'>5ASIS 팀</strong></p>"
		               + "                        </td>"
		               + "                    </tr>"
		               + "                    <!-- 푸터 영역 -->"
		               + "                    <tr>"
		               + "                        <td style='padding: 30px 40px; background-color: #fafafa; border-top: 1px solid #eeeeee; text-align: left;'>"
		               + "                            <p style='margin: 0 0 8px 0; font-size: 12px; color: #999999; line-height: 1.4;'>"
		               + "                                본 메일은 시스템에 의해 자동으로 발송되는 발신전용 메일입니다."
		               + "                            </p>"
		               + "                            <p style='margin: 0; font-size: 11px; color: #b0b0b0;'>"
		               + "                                © 5ASIS. All rights reserved."
		               + "                            </p>"
		               + "                        </td>"
		               + "                    </tr>"
		               + "                </table>"
		               + "            </td>"
		               + "        </tr>"
		               + "    </table>"
		               + "</body>"
		               + "</html>";
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
        String title = "[5ASIS] 비밀번호 재설정 안내 메일입니다. 🔑";
        String content = "<!DOCTYPE html>"
                + "<html lang='ko'>"
                + "<head>"
                + "    <meta charset='UTF-8'>"
                + "    <meta name='viewport' content='width=device-width, initial-scale=1.0'>"
                + "</head>"
                + "<body style='margin: 0; padding: 0; background-color: #f4f6f8; font-family: \"Malgun Gothic\", \"Apple SD Gothic Neo\", sans-serif;'>"
                + "    <table border='0' cellpadding='0' cellspacing='0' width='100%' style='background-color: #f4f6f8; padding: 40px 10px;'>"
                + "        <tr>"
                + "            <td align='center'>"
                + "                <table border='0' cellpadding='0' cellspacing='0' width='100%' style='max-width: 600px; background-color: #ffffff; border-radius: 8px; box-shadow: 0 4px 10px rgba(0,0,0,0.05); overflow: hidden;'>"
                + "                    <!-- 상단 헤더 영역 -->"
                + "                    <tr>"
                + "                        <td style='padding: 40px 40px 20px 40px; background-color: #2F80ED; text-align: left;'>"
                + "                            <h1 style='margin: 0; color: #ffffff; font-size: 28px; font-weight: bold; letter-spacing: -1px;'>5ASIS</h1>"
                + "                        </td>"
                + "                    </tr>"
                + "                    <!-- 본문 영역 -->"
                + "                    <tr>"
                + "                        <td style='padding: 40px; color: #333333; font-size: 15px; line-height: 1.6;'>"
                + "                            <h2 style='margin: 0 0 20px 0; color: #1a1a1a; font-size: 22px; font-weight: bold;'>비밀번호 재설정 안내 🔑</h2>"
                + "                            <p style='margin: 0 0 15px 0;'>안녕하세요, 모험가님. 계정의 비밀번호 재설정 요청에 따라 발송된 메일입니다.</p>"
                + "                            <p style='margin: 0 0 10px 0; color: #d93025; font-weight: bold;'>⚠️ 해당 링크는 보안을 위해 발송 후 5분 동안만 유효합니다.</p>"
                + "                            <p style='margin: 0 0 35px 0; color: #555555;'>시간이 만료되기 전에 아래의 <strong>비밀번호 변경하기</strong> 버튼을 클릭하여 새 비밀번호를 설정해 주세요.</p>"
                + "                            "
                + "                            <!-- 버튼 영역 (CTA) -->"
                + "                            <table border='0' cellpadding='0' cellspacing='0' width='100%' style='margin: 30px 0;'>"
                + "                                <tr>"
                + "                                    <td align='center'>"
                + "                                        <a href='" + resetUrl + "' target='_blank' style='background-color: #2F80ED; color: #ffffff; padding: 14px 35px; text-decoration: none; border-radius: 6px; font-weight: bold; font-size: 16px; display: inline-block; box-shadow: 0 4px 6px rgba(47, 128, 237, 0.2);'>비밀번호 변경하기</a>"
                + "                                    </td>"
                + "                                </tr>"
                + "                            </table>"
                + "                            "
                + "                            <p style='font-size: 13px; color: #888888; margin: 30px 0 20px 0; padding: 15px; background-color: #fafafa; border-radius: 6px;'>"
                + "                                ※ 5분이 지나 링크가 만료된 경우, 비밀번호 찾기를 처음부터 다시 진행해 주셔야 합니다.<br>"
                + "                                ※ 본인이 요청하지 않았다면 이 메일을 무시하셔도 됩니다. 기존 비밀번호는 그대로 유지됩니다."
                + "                            </p>"
                + "                            "
                + "                            <p style='margin: 40px 0 0 0; color: #555555;'>감사합니다.<br><strong style='color: #1a1a1a;'>5ASIS 팀</strong></p>"
                + "                        </td>"
                + "                    </tr>"
                + "                    <!-- 푸터 영역 -->"
                + "                    <tr>"
                + "                        <td style='padding: 30px 40px; background-color: #fafafa; border-top: 1px solid #eeeeee; text-align: left;'>"
                + "                            <p style='margin: 0 0 8px 0; font-size: 12px; color: #999999; line-height: 1.4;'>"
                + "                                본 메일은 시스템에 의해 자동으로 발송되는 발신전용 메일입니다."
                + "                            </p>"
                + "                            <p style='margin: 0; font-size: 11px; color: #b0b0b0;'>"
                + "                                © 5ASIS. All rights reserved."
                + "                            </p>"
                + "                        </td>"
                + "                    </tr>"
                + "                </table>"
                + "            </td>"
                + "        </tr>"
                + "    </table>"
                + "</body>"
                + "</html>";

        // 4. 발송
        boolean isSuccess = sendMail.send(userEmail, title, content);
        
        if (isSuccess) {
            System.out.println("발송 성공 -> 토큰값: " + token);
            long uid = userDAO.findUidByUserEmail(userEmail);
            userMailDAO.insertPasswordToken(uid, token);
           
        } else {
            System.out.println("발송 실패");
        }
	}
    @Override
    public boolean verifyResetToken(String email, String token) {
        System.out.println("[Service] 토큰 유효성 검증 시작 -> 이메일: " + email + ", 토큰: " + token);
        
        // DAO에게 데이터 대조 처리를 위임합니다.
        boolean isValid = userMailDAO.checkValidToken(email, token);
       
        if (isValid) {
            System.out.println("[Service] 검증 통과: 유효한 토큰입니다.");
            return true;
        } else {
            System.out.println("[Service] 검증 실패: 잘못된 접근이거나 5분 만료된 토큰입니다.");
            return false;
        }
    }
}
