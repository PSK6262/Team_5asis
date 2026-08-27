package com.app.service;

import java.util.List;

import com.app.dto.board.Post;

public interface GameBoardService {
	List<Post> findPostListByGameAlias(String gameAlias);
	String findGameNameByGameAlias(String gameAlias);	
	List<Post> addNicknameToPostList(List<Post> postList);
	// 게시판별 카테고리 전부 가져오기
	List<String> findCategoriesByGameAlias(String gameAlias);
}