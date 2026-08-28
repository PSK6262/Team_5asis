package com.app.dao.board.impl;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.app.dao.board.GameBoardDAO;
import com.app.dto.board.GameNameTransferForm;
import com.app.dto.board.PagingPosts;
import com.app.dto.board.Post;

@Repository
public class GameBoardDAOImpl implements GameBoardDAO {

	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	@Override
	public List<Post> findPostListByGameAlias(String gameAlias) {
		List<Post> postList = sqlSessionTemplate.selectList("board_mapper.findPostListByGameAlias",gameAlias);
		return postList;
	}

	@Override
	public String findGameNameByGameAlias(String gameAlias) {
		String gameName = sqlSessionTemplate.selectOne("board_mapper.findGameNameByGameAlias", gameAlias);
		return gameName;
	}

	@Override
	public List<String> findCategoriesByGameAlias(String gameAlias) {
		List<String> categories = sqlSessionTemplate.selectList("board_mapper.findCategoriesByGameAlias",gameAlias);
		return categories;
	}

	@Override
	public List<GameNameTransferForm> findPopularSixGames() {
		List<GameNameTransferForm> popularSixGames = sqlSessionTemplate.selectList("board_mapper.findPopularSixGames");
		return popularSixGames;
	}

	@Override
	public List<Post> findTrendPostListByGameAlias(String gameAlias) {
		List<Post> selectedTrendPost = sqlSessionTemplate.selectList("board_mapper.findTrendPostListByGameAlias",gameAlias);
		return selectedTrendPost;
	}

	@Override
	public List<Post> findPostListByPagingPosts(PagingPosts pagingPosts) {
		List<Post> selectedPagingPost = sqlSessionTemplate.selectList("board_mapper.findPostListByPagingPosts",pagingPosts);
		return selectedPagingPost;
	}

	@Override
	public int findPostSizeByGameAlias(String gameAlias) {
		int postSize = sqlSessionTemplate.selectOne("board_mapper.findPostSizeByGameAlias",gameAlias);
		return postSize;
	}
}
