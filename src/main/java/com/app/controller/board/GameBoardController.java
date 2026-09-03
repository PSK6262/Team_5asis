package com.app.controller.board;

import java.util.List;

import javax.servlet.http.HttpSession;

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
import com.app.dto.user.UserInfo;
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
	public String gameBoard(@PathVariable String gameAlias, Model model,
			@RequestParam(defaultValue = "1", required = false) int page,
			@RequestParam(defaultValue = "전체", required = false) String category,
			@RequestParam(required = false) Integer pSize, HttpSession session) {
		
		// 들어온 gameAlias parameter를 통해서 게임 이름을 확인
		// 해당되는게 없으면 null이 나올 것
		String gameName = gameBoardService.findGameNameByGameAlias(gameAlias);

		// 통합 게시판 클릭한 경우(gameAlias가 all인 경우 , gameName = null이다 ) , 
		// 특정 게임의 이름이 아니라 "전체"라고 보낸다 -> 라이브 방송 등 출력X
		if (CommonCode.BOARD_TYPE_ALL_ENG.equalsIgnoreCase(gameAlias)) {
			// null이던 값을 바꿔줌(바로 아래 if에 걸려서 return되지 않도록)
			gameName = CommonCode.BOARD_TYPE_ALL_KOR;
		}
		// 잘못된 parameter를 통해 들어온 경우 차단
		if (gameName == null || gameName.isEmpty()) {
			return "redirect:/main";
		}

		// pSize 만큼 잘라서 Posts를 가져오는 서비스 , 현재 페이지( 1,2,3페이지.. )
		// 현재 게임 ( lol , pubg ... ) , 현재 카테고리 ( 전체 , 자유 , 구인 ... ) 을 필터링하여 가져온다 
		PagingPosts pagingPosts = gameBoardService.findPostListByPagingPosts(gameAlias, page, category, pSize);

		// 페이지를 가져왔는데, 페이지가 0보다 작거나 전체 페이지 크기보다 크면 잘못된 것
		if (page < 0 || page > pagingPosts.getPostSize()) {
			return "redirect:/board/" + gameAlias + "?page=1";
		}
		
		// 지금 가장 인기있는 게시글 3개를 가져옴 -> 조회수 + 좋아요 * 10의 합으로 내림차순
		List<Post> selectedTrendPost = gameBoardService.findTrendPostListByGameAlias(gameAlias);
		
		// 지금 접속한 게임 페이지의 카테고리를 전부 가져옴
		List<String> categories = gameBoardService.findCategoriesByGameAlias(gameAlias);

		// 인기 게임 게시판 TOP 6를 출력하는 서비스
		List<GameNameTransferForm> popularSixGames = gameBoardService.findPopularSixGames();
		
		// 치지직 API를 통해서 Response를 받는 서비스
		List<ChzzkApiResponse> chzzkApiResponse = chzzkApiService.getChzzkApiResponseByGameAlias(gameAlias);
		
		// 치지직 API 정상 작동 ( 에러처리는 서비스에서 해서 온다 , 문제가 있을 시 EMPTY ARRAY )
		model.addAttribute("chzzkApiResponse", chzzkApiResponse);

		// 로그인한 유저가 있는지 찾는다
		UserInfo loginUser = (UserInfo)session.getAttribute("LOGIN_USER");
		
		// 로그인한 유저가 있는 경우
		if (loginUser != null) {
			model.addAttribute("loginUser", loginUser);
		}

		model.addAttribute("categories", categories);
		model.addAttribute("gameAlias", gameAlias);
		model.addAttribute("pagingPosts", pagingPosts);
		model.addAttribute("gameName", gameName);
		model.addAttribute("boardTypeAll",CommonCode.BOARD_TYPE_ALL_KOR);
		model.addAttribute("popularSixGames", popularSixGames);
		model.addAttribute("selectedTrendPost", selectedTrendPost);

		return "board/gameBoard";
	}

	@GetMapping("/search")
	public String search(@RequestParam(value = "keyword", required = false) String keyword ,
								 @RequestParam(value = "type", defaultValue = CommonCode.BOARD_TYPE_ALL_ENG, required = false) String type ,
								 Model model) {

		// 인기 게임 게시판 TOP 6를 출력하는 서비스
		List<GameNameTransferForm> popularSixGames = gameBoardService.findPopularSixGames();
		model.addAttribute("popularSixGames", popularSixGames);
		model.addAttribute("keyword", keyword);
		
		// /board/search?type=all&keyword=롤
		// type은 각각 전체, 사용자 , 내용 , 제목 , 게시판이 존재
		SearchKeywordForm searchKeywordForm = new SearchKeywordForm();
		searchKeywordForm.setKeyword(keyword);
		searchKeywordForm.setType(type);

		// keyword를 가지고
		// 제목으로 검색한 값 , 내용으로 검색한 값 
		// 닉네임으로 검색한 값 , 게시판 이름으로 검색한 값을 담는다. 
		SearchResult searchResult = gameBoardService.findSearchResultByKeyword(keyword);
		model.addAttribute("searchResult", searchResult);
		model.addAttribute("searchKeywordForm", searchKeywordForm);

		return "board/search";
	}
}
