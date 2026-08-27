package com.app.dao;

import java.util.List;

import com.app.dto.board.Post;

public interface GameBoardDAO {
	List<Post> findPostListByGameAlias(String gameAlias);
	String findGameNameByGameAlias(String gameAlias);
	List<String> findCategoriesByGameAlias(String gameAlias);
}
