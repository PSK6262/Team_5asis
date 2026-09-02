package com.app.service.board.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.app.dao.board.GameBoardDAO;
import com.app.dao.comment.CommentDAO;
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

	@Autowired
	CommentDAO commentDAO;
	
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
		
		int postSize = gameBoardDAO.findPostSizeByGameAliasAndCategory(gameAlias,category);
		pagingPosts.setPostSize(postSize);
		
		for(int i=0;i<selectedPagingPost.size();i++) {
			Long pid = selectedPagingPost.get(i).getPid();
			Long commentSize = commentDAO.countCommentsByPostId(pid);
			selectedPagingPost.get(i).setCommentCount(commentSize);
		}
		
		return pagingPosts;
	}

	@Override
	public SearchResult findSearchResultByKeyword(String keyword) {
		SearchResult searchResult = new SearchResult();
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