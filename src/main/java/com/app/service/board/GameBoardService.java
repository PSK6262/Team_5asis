package com.app.service.board;

import java.util.List;

import com.app.dto.board.GameNameTransferForm;
import com.app.dto.board.PagingPosts;
import com.app.dto.board.Post;
import com.app.dto.board.SearchResult;

public interface GameBoardService {
	List<Post> findPostListByGameAlias(String gameAlias);
	String findGameNameByGameAlias(String gameAlias);	
	List<Post> addNicknameToPostList(List<Post> postList);
	List<Post> addGameNameToPostList(List<Post> postList);
	List<Post> addGameAliasToPostList(List<Post> postList);
	// 게시판별 카테고리 전부 가져오기
	List<String> findCategoriesByGameAlias(String gameAlias);
	List<GameNameTransferForm> findPopularSixGames();
	List<Post> findTrendPostListByGameAlias(String gameAlias);
	PagingPosts findPostListByPagingPosts(String gameAlias, int pageNum , String category);
	SearchResult findSearchResultByKeyword(String keyword);
}