package com.app.service.board.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.app.dao.board.GameBoardDAO;
import com.app.dao.user.UserDAO;
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
		String gameName = gameBoardDAO.findGameNameByGameAlias(gameAlias);
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
}