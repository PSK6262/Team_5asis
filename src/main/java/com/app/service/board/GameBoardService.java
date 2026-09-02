package com.app.service.board;

import java.util.List;

import org.springframework.stereotype.Service;

import com.app.dto.board.GameNameTransferForm;
import com.app.dto.board.PagingPosts;
import com.app.dto.board.Post;
import com.app.dto.board.SearchResult;

@Service
public interface GameBoardService {
	List<Post> findPostDetailListByGameAlias(String gameAlias);
	String findGameNameByGameAlias(String gameAlias);	
	List<String> findCategoriesByGameAlias(String gameAlias);
	List<GameNameTransferForm> findPopularSixGames();
	List<Post> findTrendPostListByGameAlias(String gameAlias);
	PagingPosts findPostListByPagingPosts(String gameAlias, int pageNum , String category , int pSize);
	SearchResult findSearchResultByKeyword(String keyword);
	
	// 게임 전체 리스트 가져오기
	
	List<GameNameTransferForm> findAllGames();
	
}