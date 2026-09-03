package com.app.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.app.dto.board.GameNameTransferForm;
import com.app.dto.user.UserInfo;
import com.app.service.board.GameBoardService;

@Controller

public class MainController {

	@Autowired

	GameBoardService gameBoardService;

	@GetMapping("/main")

	public String vasis(Model model, HttpSession session) {

		List<GameNameTransferForm> popularSixGames = gameBoardService.findPopularSixGames();

		model.addAttribute("popularSixGames", popularSixGames);

		List<GameNameTransferForm> allGames = gameBoardService.findAllGames();

		model.addAttribute("games", allGames);

		// 로그인 사용자 닉네임, 프로필 이미지도 세션에서 꺼내서 전달

		UserInfo loginUser = (UserInfo) session.getAttribute("LOGIN_USER");

		if (loginUser != null) {

			String nickname = loginUser.getNickname();

			String profileImg = loginUser.getProfileImageUrl();

			model.addAttribute("loginUser", loginUser);

			model.addAttribute("nickname", nickname);

			model.addAttribute("profileImg", profileImg);

			System.out.println("닉네임: " + nickname);

		} else {

			// 로그인 안 된 상태 처리

			model.addAttribute("nickname", "Guest");

			model.addAttribute("profileImg",
					"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRhhyGGwgPL45lqvy3D15y74Heh7azl2cOLI7CPnHb6jw&s=10");

		}

		return "main";

	}
}