package com.app.controller.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.app.dto.user.UserInfo;
import com.app.service.user.UserService;

@Controller
@RequestMapping("/user")
public class AuthController {
	
		@Autowired
	    private UserService userService;

		@GetMapping("/signup")
	    public String signupForm() {
	    	return "user/signup";
	    }
	    
		@PostMapping("/signup")
		public String signupProcess(UserInfo userInfo) {
		    
		    System.out.println("====== 회원가입 폼 데이터 수신 확인 ======");
		    System.out.println("가입 이메일: " + userInfo.getEmail());
		    System.out.println("가입 비밀번호: " + userInfo.getPassword());
		    System.out.println("가입 닉네임: " + userInfo.getNickname());
		    System.out.println("==========================================");
		        
		    userService.signup(userInfo);
		    
		    return "redirect:/user/login";	
		}
	
	
	// http://192.168.0.66:8080/user/login (localhost:8080/user/login)
    @GetMapping("/login")
    public String loginform() {
        return "user/login";
    }

    // 폼 전송 시 처리
    @PostMapping("/login")
    public String loginTest(
            @RequestParam("userId") String userId,
            @RequestParam("userPw") String userPw) {
        
        System.out.println("====== 로그인 요청 수신 ======");
        System.out.println("아이디: " + userId);
        System.out.println("비밀번호: " + userPw);
        System.out.println("=============================");

        return "user/login";
    }
    
 
    
    
}