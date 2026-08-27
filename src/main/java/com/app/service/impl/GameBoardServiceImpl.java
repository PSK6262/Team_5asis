package com.app.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.app.dao.GameBoardDAO;
import com.app.dto.board.Post;
import com.app.service.GameBoardService;

@Service
public class GameBoardServiceImpl implements GameBoardService {	
	
	@Autowired
	GameBoardDAO gameBoardDAO;
	
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
}