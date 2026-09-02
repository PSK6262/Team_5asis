package com.app.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.app.dto.board.GameNameTransferForm;
import com.app.service.board.GameBoardService;

@Controller
public class MainController {
	@Autowired
	GameBoardService gameBoardService;

	@GetMapping("/main")
	public String vasis(Model model, HttpSession session) {
		List<GameNameTransferForm> popularSixGames = gameBoardService.findPopularSixGames();
		model.addAttribute("popularSixGames", popularSixGames);

		// 로그인 사용자 닉네임, 프로필 이미지도 세션에서 꺼내서 전달
		model.addAttribute("nickname", session.getAttribute("nickname"));
		model.addAttribute("profileImg", session.getAttribute("profileImg"));
		return "main";
	}

	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate(); // 세션 전체 무효화
		return "redirect:/main"; // 메인으로 리다이렉트
	}
}