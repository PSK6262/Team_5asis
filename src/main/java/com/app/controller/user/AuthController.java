package com.app.controller.user;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

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
	
    @GetMapping("/login")
    public String loginform() {
        return "user/login";
    }

    // 폼 전송 시 처리
    @PostMapping("/login")
    public String login(UserInfo userInfo, HttpSession session, Model model) {
        
        System.out.println("====== 로그인 요청 수신 ======");
        System.out.println("아이디: " + userInfo.getEmail());
        System.out.println("비밀번호: " + userInfo.getPassword());
        System.out.println("=============================");

       //1) 서비스에 로그인 검증 요청
        UserInfo loginUser = userService.login(userInfo);
        
        //2) 일치하는 회원이 없을 시
        if (loginUser == null) {
        	model.addAttribute("loginError", "아이디 또는 비밀번호가 일치하지 않습니다.");
        	return "user/login";	//다시 로그인 화면으로
        }
        
        //3) 로그인 성공 시 세션에 유저 정보 등록
        session.setAttribute("LOGIN_USER_ID", loginUser.getUid());
        session.setAttribute("LOGIN_USER", loginUser);
        
        return "redirect:/main";	//메인경로
    }
    
    //이메일 중복체크
    @ResponseBody
    @PostMapping("/checkEmail")
    public int checkEmail(@RequestParam("email") String email) {
    	int result = userService.checkEmailDuplicate(email);
    	return result;
    }
    
    // 로그아웃 처리
    @GetMapping("/logout")
    public String logout(HttpSession session) {
    	session.invalidate(); //세션 초기화
    	return "redirect:/user/login";
    }
    
    
    //비밀번호 찾기 비동기 요청 처리
    @ResponseBody
    @PostMapping("/findPassword")
    public String findPassword(@RequestParam("email") String email) {
    	String password = userService.findPwByEmail(email);
    	return (password != null) ? password : "NOT_FOUND";
    }
    
}