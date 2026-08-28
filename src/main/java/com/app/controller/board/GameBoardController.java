package com.app.controller.board;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.app.dto.board.GameNameTransferForm;
import com.app.dto.board.PagingPosts;
import com.app.dto.board.Post;
import com.app.service.board.GameBoardService;
import com.app.service.user.UserService;

@Controller
@RequestMapping("/board")
public class GameBoardController {
	
	@Autowired
	GameBoardService gameBoardService;
	
	@Autowired
	UserService userService;
	
	@GetMapping("/{gameAlias}")
	public String gameBoard(@PathVariable String gameAlias, Model model , 
										 @RequestParam(defaultValue = "1" , required=false) int page ,
										 @RequestParam(defaultValue="전체", required=false) String category) {

		String gameName = gameBoardService.findGameNameByGameAlias(gameAlias);
		
		System.out.println("pA : " + gameAlias + " pN : " +page + " ctg : " + category);
		// 전체 List 불러오기
		//List<Post> selectedPost = gameBoardService.findPostListByGameAlias(gameAlias);
		
		// Paging 된 List 불러오기
		PagingPosts pagingPosts = gameBoardService.findPostListByPagingPosts(gameAlias,page,category);
		if(page < 0 || page > pagingPosts.getPostSize()) {
			return "redirect:/board/" + gameAlias  + "?page=1";
		}
		List<Post> selectedTrendPost = gameBoardService.findTrendPostListByGameAlias(gameAlias);
		pagingPosts.setPosts(gameBoardService.addNicknameToPostList(pagingPosts.getPosts()));
		
		List<String> categories = gameBoardService.findCategoriesByGameAlias(gameAlias);
		List<GameNameTransferForm> popularSixGames = gameBoardService.findPopularSixGames();
		
		
		if(pagingPosts.getPosts() == null || pagingPosts.getPosts().isEmpty()) {
			return "redirect:/main";
		}
		
		model.addAttribute("categories",categories);
		model.addAttribute("gameAlias",gameAlias);
		model.addAttribute("pagingPosts",pagingPosts);
		model.addAttribute("gameName",gameName);
		model.addAttribute("popularSixGames",popularSixGames);
		model.addAttribute("selectedTrendPost",selectedTrendPost);
		return "board/gameBoard";
	}
}
