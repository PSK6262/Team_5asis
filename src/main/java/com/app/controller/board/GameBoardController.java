package com.app.controller.board;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.app.common.CommonCode;
import com.app.dto.api.ChzzkApiResponse;
import com.app.dto.board.GameNameTransferForm;
import com.app.dto.board.PagingPosts;
import com.app.dto.board.Post;
import com.app.dto.board.SearchKeywordForm;
import com.app.dto.board.SearchResult;
import com.app.service.api.ChzzkApiService;
import com.app.service.board.GameBoardService;
import com.app.service.user.UserService;

@Controller
@RequestMapping("/board")
public class GameBoardController {
	
	@Autowired
	GameBoardService gameBoardService;
	
	@Autowired
	UserService userService;
	
	@Autowired
	ChzzkApiService chzzkApiService;
	
	@GetMapping("/{gameAlias}")
	public String gameBoard(@PathVariable String gameAlias, Model model , 
										 @RequestParam(defaultValue = "1" , required=false) int page ,
										 @RequestParam(defaultValue ="전체", required=false) String category ,
										 @RequestParam(required=false) Integer pSize) {

		if(pSize == null || pSize <= 0) {
			pSize = CommonCode.PAGING_SIZE_SMALL;
		}
		
		String gameName = gameBoardService.findGameNameByGameAlias(gameAlias);
		
		System.out.println("alias : " + gameAlias + " page : " +page + " ctg : " + category + " pSize : " + pSize);
		// 전체 List 불러오기
		//List<Post> selectedPost = gameBoardService.findPostListByGameAlias(gameAlias);
		
		// Paging 된 List 불러오기
		PagingPosts pagingPosts = gameBoardService.findPostListByPagingPosts(gameAlias,page,category,pSize);
		
		if(gameName == null || gameName.isEmpty()) { 
			System.out.println("gamename empty");
			return "redirect:/main"; 
		}
		if(page < 0 || page > pagingPosts.getPostSize()) { 
			System.out.println("page empty");
			return "redirect:/board/" + gameAlias  + "?page=1"; 
		}
		List<Post> selectedTrendPost = gameBoardService.findTrendPostListByGameAlias(gameAlias);
		//pagingPosts.setPosts(gameBoardService.addNicknameToPostList(pagingPosts.getPosts()));
		
		List<String> categories = gameBoardService.findCategoriesByGameAlias(gameAlias);
		List<GameNameTransferForm> popularSixGames = gameBoardService.findPopularSixGames();
		
		// api로 방송 썸네일 가져오기
		List<ChzzkApiResponse> chzzkApiResponse = chzzkApiService.getChzzkApiResponseByGameAlias(gameAlias);
		if(chzzkApiResponse != null) {
			model.addAttribute("chzzkApiResponse",chzzkApiResponse);
		}
		model.addAttribute("categories",categories);
		model.addAttribute("gameAlias",gameAlias);
		model.addAttribute("pagingPosts",pagingPosts);
		model.addAttribute("gameName",gameName);
		model.addAttribute("popularSixGames",popularSixGames);
		model.addAttribute("selectedTrendPost",selectedTrendPost);
		
		return "board/gameBoard";
	}
	
	@GetMapping("/search")
	public String search(@RequestParam(value = "keyword" , required = false) String keyword ,
								  @RequestParam(value = "type" , defaultValue="all" , required = false) String type ,
								  Model model) {
	
		List<GameNameTransferForm> popularSixGames = gameBoardService.findPopularSixGames();
		model.addAttribute("popularSixGames",popularSixGames);
		model.addAttribute("keyword",keyword);
		SearchKeywordForm searchKeywordForm = new SearchKeywordForm();
		searchKeywordForm.setKeyword(keyword);
		searchKeywordForm.setType(type);
		
		SearchResult searchResult = gameBoardService.findSearchResultByKeyword(keyword);
		model.addAttribute("searchResult",searchResult);
		model.addAttribute("searchKeywordForm",searchKeywordForm);
		
		return "board/search";
	}
}
