package com.app.util;
import javax.mail.internet.MimeMessage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Component;

@Component
@PropertySource("classpath:config/smtp.properties") // smtp.properties 파일을 읽어옵니다.
public class SendMail {

    @Autowired
    private JavaMailSender mailSender;

    // properties 파일에서 발신자(본인) 이메일 주소를 가져옵니다.
    @Value("${mail.username}")
    private String fromEmail;

    public boolean send(String toEmail, String title, String content) {
        try {
            MimeMessage message = mailSender.createMimeMessage();
            
            // 두 번째 인자 true는 멀티파트(HTML, 첨부파일 등) 메시지 포맷을 허용함을 의미합니다.
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");

            helper.setFrom(fromEmail);          // 보내는 사람 (properties에서 가져온 값)
            helper.setTo(toEmail);              // 받는 사람
            helper.setSubject(title);           // 메일 제목
            helper.setText(content, true);      // 메일 본문 (true 지정 시 내부 HTML 코드가 작동함)

            // 실제 SMTP 서버를 통해 전송
            mailSender.send(message);
            System.out.println("[SendMail] 메일 발송 성공 -> " + toEmail);
            return true;
            
        } catch (Exception e) {
            System.err.println("[SendMail] 메일 발송 실패: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
}