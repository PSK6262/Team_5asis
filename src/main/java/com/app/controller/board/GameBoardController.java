package com.app.controller.board;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.app.dto.board.Post;
import com.app.service.GameBoardService;

@Controller
@RequestMapping("/board")
public class GameBoardController {
	
	@Autowired
	GameBoardService gameBoardService;
	
	@GetMapping("/{gameAlias}")
	public String gameBoard(@PathVariable String gameAlias, Model model) {
		
		gameAlias = gameAlias.toUpperCase();
		
		String gameName = gameBoardService.findGameNameByGameAlias(gameAlias);
		List<Post> selectedPost = gameBoardService.findPostListByGameAlias(gameAlias);
		
		if(selectedPost == null || selectedPost.isEmpty()) {
			return "redirect:/main";
		}
		model.addAttribute("selectedPost",selectedPost);
		model.addAttribute("gameName",gameName);
		
		return "board/gameBoard";
	}
}
