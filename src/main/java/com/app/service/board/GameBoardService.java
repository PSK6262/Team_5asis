package com.app.service.board;

import java.util.List;

import com.app.dto.board.GameNameTransferForm;
import com.app.dto.board.PagingPosts;
import com.app.dto.board.Post;
import com.app.dto.board.SearchResult;

public interface GameBoardService {
	List<Post> findPostDetailListByGameAlias(String gameAlias);
	String findGameNameByGameAlias(String gameAlias);	
	List<String> findCategoriesByGameAlias(String gameAlias);
	List<GameNameTransferForm> findPopularSixGames();
	List<Post> findTrendPostListByGameAlias(String gameAlias);
	PagingPosts findPostListByPagingPosts(String gameAlias, int pageNum , String category , int pSize);
	SearchResult findSearchResultByKeyword(String keyword);
}