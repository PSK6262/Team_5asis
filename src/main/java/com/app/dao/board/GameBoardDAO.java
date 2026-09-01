package com.app.dao.board;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.app.dto.board.GameNameTransferForm;
import com.app.dto.board.PagingPosts;
import com.app.dto.board.Post;
import com.app.dto.board.SearchResult;

public interface GameBoardDAO {
	List<Post> findPostDetailListByGameAlias(String gameAlias);
	String findGameNameByGameAlias(String gameAlias);
	List<String> findCategoriesByGameAlias(String gameAlias);
	List<GameNameTransferForm> findPopularSixGames();
	List<Post> findTrendPostListByGameAlias(String gameAlias);
	List<Post> findPostListByPagingPosts(PagingPosts pagingPosts);
	int findPostSizeByGameAliasAndCategory(String gameAlias, String category);
	String findChzzkCategoryNameByGameAlias(@Param("gameAlias") String gameAlias);
	SearchResult findSearchResultByKeyword(String keyword);
}
