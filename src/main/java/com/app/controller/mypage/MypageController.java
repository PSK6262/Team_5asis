package com.app.controller.mypage;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MypageController {
	
	@GetMapping("/mypage")
	public String main() {
		return "mypage/mypage";
	}
}
