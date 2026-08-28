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
import com.app.service.board.GameBoardService;

@Service
public class GameBoardServiceImpl implements GameBoardService {

	@Autowired
	GameBoardDAO gameBoardDAO;

	@Autowired
	UserDAO userDAO;

	@Override
	public List<Post> findPostListByGameAlias(String gameAlias) {
		List<Post> postList = gameBoardDAO.findPostListByGameAlias(gameAlias);
		return postList;
	}

	@Override
	public String findGameNameByGameAlias(String gameAlias) {
		String gameName = gameBoardDAO.findGameNameByGameAlias(gameAlias.toUpperCase());
		return gameName;
	}

	@Override
	public List<Post> addNicknameToPostList(List<Post> postList) {
		for (int i = 0; i < postList.size(); i++) {
			postList.get(i).setNickname(userDAO.findNickNameByUid(postList.get(i).getUid()));
		}
		return postList;
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
		selectedTrendPost = addNicknameToPostList(selectedTrendPost);
		return selectedTrendPost;
	}

	@Override
	public PagingPosts findPostListByPagingPosts(String gameAlias, int pageNum) {
		PagingPosts pagingPosts = new PagingPosts();
		pagingPosts.setCurrentPage(pageNum);
		pagingPosts.setGameAlias(gameAlias);
		pagingPosts.setSize(CommonCode.PAGING_SIZE);
		List<Post> selectedPagingPost = gameBoardDAO.findPostListByPagingPosts(pagingPosts);
		pagingPosts.setPosts(selectedPagingPost);
		int postSize = gameBoardDAO.findPostSizeByGameAlias(gameAlias);
		pagingPosts.setPostSize(postSize);
		
		return pagingPosts;
	}
}