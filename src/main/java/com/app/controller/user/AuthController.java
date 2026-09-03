package com.app.controller.user;

import com.app.service.user.impl.UserMailServiceImpl;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.app.dto.user.UserInfo;
import com.app.service.user.UserMailService;
import com.app.service.user.UserService;

@Controller
@RequestMapping("/user")
public class AuthController {

		@Autowired
	    private UserService userService;
		
		@Autowired
		private UserMailService userMailService;

		@GetMapping("/signup")
	    public String signupForm(HttpSession session) { //이미 로그인한 상태면 메인으로
			if (session.getAttribute("LOGIN_USER_ID") != null) {
				return "redirect:/main";
			}
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
		    
		    userMailService.joinWelcome(userInfo.getEmail());
		    
		    return "redirect:/user/login";	
		}
	
    @GetMapping("/login")
    public String loginform(HttpServletRequest request, HttpSession session, Model model,
    				@CookieValue(value = "rememberEmail", required = false) String rememberEmail) {
    	if (session.getAttribute("LOGIN_USER_ID") != null) {
			return "redirect:/main";
		}
    	
    	//쿠키에 이메일이 저장되어 있으면 jsp 로 전달
    	if (rememberEmail != null) {
    		model.addAttribute("rememberEmail", rememberEmail);
    	}
    	
    	//직전 페이지 URL 가져오기 (게시글 상세페이지 주소 등)
    	String referer = request.getHeader("Referer");
    	
    	//이전 페이지가 있고, 로그인/회원가입 페이지 자체가 아닌 경우에만 세션에 저장
    	if (referer != null && !referer.contains("/user/login") && !referer.contains("/user/signup")) {
    		session.setAttribute("prevPage", referer);
    	}
    	
        return "user/login";
    }

    // 폼 전송 시 처리
    @PostMapping("/login")
    public String login(UserInfo userInfo, HttpSession session, Model model,
    					@RequestParam(value = "rememberId", required = false) String rememberId,
    					HttpServletResponse response) {
        
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
        
        //추가(보안) 세션 저장 전 비밀번호 제거
        loginUser.setPassword(null);
        
        //3) 로그인 성공 시 세션에 유저 정보 등록
        session.setAttribute("LOGIN_USER_ID", loginUser.getUid());
        session.setAttribute("LOGIN_USER", loginUser);
        
        //추가(아이디기억) 쿠키 처리 (7일 보관)
        Cookie cookie = new Cookie("rememberEmail", userInfo.getEmail());
        cookie.setPath("/");	//모든 페이지에서 쿠키 사용가능
        
        if ("Y".equals(rememberId)) {
        	cookie.setMaxAge(60 * 60 * 24 * 7);
        } else {	//체크박스 해제 시 쿠키 즉시 삭제
        	cookie.setMaxAge(0);
        }
        response.addCookie(cookie);	//브라우저에 쿠키 전달
        
        
        //수정(이전페이지가 있으면 거기로, 없으면 메인으로 이동)
        String prevPage = (String) session.getAttribute("prevPage");
        if (prevPage != null) {
        	session.removeAttribute("prevPage");	//사용 후 세션에서 제거
        	return "redirect:" + prevPage;
        }
        
        return "redirect:/main";	//기본값은 메인으로
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
    public String logout(HttpServletRequest request, HttpSession session) {
    	//1) 로그아웃 직전 페이지 경로 가져오기
    	String referer = request.getHeader("Referer");
    		
    	//2) 세션 무효화 (로그아웃 처리)
    	session.invalidate();
    	
    	//3) 직전 페이지 존재 & 마이페이지(로그인전용 화면)가 아닌 경우 원래 페이지로 복귀
    	if (referer != null && !referer.contains("/mypage")) {
    		return "redirect:" + referer;
    	}
    	
    	return "redirect:/main";
    }
    
    
    //비밀번호 찾기 비동기 요청 처리
    @ResponseBody
    @PostMapping("/findPassword")
    public String findPassword(@RequestParam("email") String email) {
    	String password = userService.findPwByEmail(email);
    	
    	userMailService.sendPasswordReset(email);
    	
    	return (password != null) ? "메일을 확인하세요" : "NOT_FOUND";
    }
    
    @GetMapping("/reset")
    public String resetPassword(@RequestParam("email") String email , 
    										 @RequestParam("token") String token , HttpSession session) {
    
    	if(session.getAttribute("LOGIN_USER") != null) {
    		// 이 경우 이미 로그인한 사람이라는것임
    		return "redirect:/board/main";
    	}
    	
    	// email이 존재하고, 토큰이 존재하면? (expired 기간 안이면?)
    	
    	// 여기가 검증 로직 (되었다고 가정)
    	UserInfo loginUser = userService.findUserByEmail(email);
    	session.setAttribute("LOGIN_USER",loginUser);
    	
    	return "redirect:/board/mypage";
    }
}