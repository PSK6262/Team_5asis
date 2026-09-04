package com.app.service.board.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.app.common.CommonCode;
import com.app.dao.board.GameBoardDAO;
import com.app.dao.user.UserDAO;
import com.app.dto.board.GameNameTransferForm;
import com.app.dto.board.PagingPosts;
import com.app.dto.board.Post;
import com.app.dto.board.SearchResult;
import com.app.dto.user.UserInfo;
import com.app.service.board.GameBoardService;

@Service
public class GameBoardServiceImpl implements GameBoardService {

	@Autowired
	GameBoardDAO gameBoardDAO;

	@Autowired
	UserDAO userDAO;

	@Override
	public String findGameNameByGameAlias(String gameAlias) {
		// 게임 약어(주소로 들어오는 값)를 통해서 게임 풀네임을 알아내기
		String gameName = gameBoardDAO.findGameNameByGameAlias(gameAlias.toUpperCase());
		return gameName;
	}

	@Override
	public List<String> findCategoriesByGameAlias(String gameAlias) {
		// 게임 약어를 통해서 해당 게임 게시판에 존재하는 모든 카테고리 찾기 (중복 제거)
		List<String> categories = gameBoardDAO.findCategoriesByGameAlias(gameAlias);
		return categories;
	}

	@Override
	public List<GameNameTransferForm> findPopularSixGames() {
		// 현재 가장 인기있는 6개의 게임 찾기
		List<GameNameTransferForm> popularSixGames = gameBoardDAO.findPopularSixGames();
		return popularSixGames;
	}

	@Override
	public List<Post> findTrendPostListByGameAlias(String gameAlias) {
		// 현재 가장 인기있는 게시글 3개 찾기
		List<Post> selectedTrendPost = gameBoardDAO.findTrendPostListByGameAlias(gameAlias);
		return selectedTrendPost;
	}

	@Override
	public PagingPosts findPostListByPagingPosts(String gameAlias, int pageNum , String category , Integer pSize) {
		
		// pSize = 한 페이지에 몇개 보여줄 것인지 (글 개수)
		// 만약 값이 제대로 들어오지 않았다면? -> 기본값 5
		if (pSize == null || pSize <= 0) {
			// CommonCode.PAGING_SIZE_SMALL = 5 , MEDIUM = 10 , LARGE = 20
			pSize = CommonCode.PAGING_SIZE_SMALL;
			// 만약 전체 게시판이라면 , 2배 해서 10 , 20 , 40
			if (CommonCode.BOARD_TYPE_ALL_ENG.equals(gameAlias)) {
				pSize = pSize * CommonCode.BOARD_TYPE_ALL_MULTIPLIER;
			}
		}
		
		// 게임 약어 , 현재 페이지 , 현재 카테고리 , 한 페이지에서 보여줄 게시글의 숫자
		
		PagingPosts pagingPosts = new PagingPosts(pageNum,gameAlias,pSize,category);
		
		// 위의 정보를 토대로 현재 페이지에서 보여줘야할 정보만 가져온다
		
		List<Post> selectedPagingPost = gameBoardDAO.findPostListByPagingPosts(pagingPosts);
		pagingPosts.setPosts(selectedPagingPost);
		
		// 해당 게임 게시판 + 해당 카테고리의 글이 총 몇개인지 전달
		
		int postSize = gameBoardDAO.findPostSizeByGameAliasAndCategory(gameAlias,category);
		pagingPosts.setPostSize(postSize);
		
		return pagingPosts;
	}

	@Override
	public SearchResult findSearchResultByKeyword(String keyword) {
		
		// 검색 결과 받아오기
		
		SearchResult searchResult = new SearchResult();
		
		// 각 DAO에 요청하여 결과값 저장
		
		List<Post> searchedByTitle = gameBoardDAO.findTitleByKeyword(keyword);
		List<Post> searchedByContent = gameBoardDAO.findContentByKeyword(keyword);
		List<UserInfo> searchedByNickname = gameBoardDAO.findNicknameByKeyword(keyword);
		List<GameNameTransferForm> searchedByBoardName = gameBoardDAO.findGameNameByKeyword(keyword);
		
		searchResult.setSearchedByTitle(searchedByTitle);
		searchResult.setSearchedByContent(searchedByContent);
		searchResult.setSearchedByNickname(searchedByNickname);
		searchResult.setSearchedByBoardName(searchedByBoardName);
		
		return searchResult;
	}

	@Override
	public List<GameNameTransferForm> findAllGames() {
		
		return gameBoardDAO.findAllGames();
		
	}
}