package com.app.dao.board;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.app.dto.board.GameNameTransferForm;
import com.app.dto.board.PagingPosts;
import com.app.dto.board.Post;

public interface GameBoardDAO {
	List<Post> findPostListByGameAlias(String gameAlias);
	String findGameNameByGameAlias(String gameAlias);
	List<String> findCategoriesByGameAlias(String gameAlias);
	List<GameNameTransferForm> findPopularSixGames();
	List<Post> findTrendPostListByGameAlias(String gameAlias);
	List<Post> findPostListByPagingPosts(PagingPosts pagingPosts);
	int findPostSizeByGameAlias(String gameAlias);
	String findChzzkCategoryNameByGameAlias(@Param("gameAlias") String gameAlias);
}
