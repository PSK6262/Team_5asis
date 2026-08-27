package com.app.controller.board;

import javax.servlet.http.HttpSession;


import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.app.dto.user.UserInfo;
import com.app.service.user.UserService;



@Controller
public class MypageController {
	
	UserService userService;
	
	public MypageController(UserService userService) {
	    this.userService = userService;
	}
	
	
	@GetMapping("/mypage")
	public String getMyPage(HttpSession session, Model model) {
		
		if (session.getAttribute("LOGIN_USER_ID") == null) {
	        session.setAttribute("LOGIN_USER_ID", 3L); // 1번 회원이 로그인했다고 가정
	    }
		
        Long loginUserId = (Long) session.getAttribute("LOGIN_USER_ID");

        if (loginUserId == null) {
            return "redirect:/main";
        }

        UserInfo myInfo = userService.getMyPageInfo(loginUserId);
        
        model.addAttribute("user", myInfo);

        return "board/mypage";
    }
}
