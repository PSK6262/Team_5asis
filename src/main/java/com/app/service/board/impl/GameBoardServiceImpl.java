package com.app.service.board.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.app.dao.board.GameBoardDAO;
import com.app.dao.user.UserDAO;
import com.app.dto.board.GameNameTransferForm;
import com.app.dto.board.PagingPosts;
import com.app.dto.board.Post;
import com.app.dto.board.SearchResult;
import com.app.service.board.GameBoardService;

@Service
public class GameBoardServiceImpl implements GameBoardService {

	@Autowired
	GameBoardDAO gameBoardDAO;

	@Autowired
	UserDAO userDAO;

	@Override
	public List<Post> findPostDetailListByGameAlias(String gameAlias) {
		List<Post> postList = gameBoardDAO.findPostDetailListByGameAlias(gameAlias);
		return postList;
	}

	@Override
	public String findGameNameByGameAlias(String gameAlias) {
		String gameName = gameBoardDAO.findGameNameByGameAlias(gameAlias.toUpperCase());
		return gameName;
	}

	@Override
	public List<String> findCategoriesByGameAlias(String gameAlias) {
		List<String> categories = gameBoardDAO.findCategoriesByGameAlias(gameAlias);
		return categories;
	}

	@Override
	public List<GameNameTransferForm> findPopularSixGames() {
		List<GameNameTransferForm> popularSixGames = gameBoardDAO.findPopularSixGames();
		return popularSixGames;
	}

	@Override
	public List<Post> findTrendPostListByGameAlias(String gameAlias) {
		List<Post> selectedTrendPost = gameBoardDAO.findTrendPostListByGameAlias(gameAlias);
		return selectedTrendPost;
	}

	@Override
	public PagingPosts findPostListByPagingPosts(String gameAlias, int pageNum , String category , int pSize) {
		PagingPosts pagingPosts = new PagingPosts();
		pagingPosts.setCurrentPage(pageNum);
		pagingPosts.setGameAlias(gameAlias);
		pagingPosts.setSize(pSize);
		pagingPosts.setCategory(category);
		
		List<Post> selectedPagingPost = gameBoardDAO.findPostListByPagingPosts(pagingPosts);
		pagingPosts.setPosts(selectedPagingPost);
		
		int postSize = gameBoardDAO.findPostSizeByGameAlias(gameAlias);
		pagingPosts.setPostSize(postSize);
		
		return pagingPosts;
	}

	@Override
	public SearchResult findSearchResultByKeyword(String keyword) {
		SearchResult searchResult = gameBoardDAO.findSearchResultByKeyword(keyword);
		
		List<Post> searchedByTitle = searchResult.getSearchedByTitle();
		searchResult.setSearchedByTitle(searchedByTitle);
		List<Post> searchedByContent = searchResult.getSearchedByContent();
		searchResult.setSearchedByContent(searchedByContent);
		return searchResult;
	}
}