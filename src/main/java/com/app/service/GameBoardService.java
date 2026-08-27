package com.app.service;

import java.util.List;

import com.app.dto.board.Post;

public interface GameBoardService {
	List<Post> findPostListByGameAlias(String gameAlias);
	String findGameNameByGameAlias(String gameAlias);
}