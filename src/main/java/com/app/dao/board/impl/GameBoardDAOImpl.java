package com.app.dao.board.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.app.dao.board.GameBoardDAO;
import com.app.dto.board.GameNameTransferForm;
import com.app.dto.board.PagingPosts;
import com.app.dto.board.Post;
import com.app.dto.board.SearchResult;
import com.app.dto.user.UserInfo;

@Repository
public class GameBoardDAOImpl implements GameBoardDAO {

	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	@Override
	public List<Post> findPostDetailListByGameAlias(String gameAlias) {
		List<Post> postDetailList = sqlSessionTemplate.selectList("board_mapper.findPostDetailListByGameAlias",gameAlias);
		return postDetailList;
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
		System.out.println(selectedPagingPost+": dao pp ");
		return selectedPagingPost;
	}

	@Override
	public int findPostSizeByGameAliasAndCategory(String gameAlias,String category) {
		Map<String , String> paramMap = new HashMap<>();
		paramMap.put("gameAlias", gameAlias);
		paramMap.put("category", category);
		
		int postSize = sqlSessionTemplate.selectOne("board_mapper.findPostSizeByGameAliasAndCategory",paramMap);
		return postSize;
	}

	@Override
	public String findChzzkCategoryNameByGameAlias(String gameAlias) {
		String chzzkCategoryName = sqlSessionTemplate.selectOne("board_mapper.findChzzkCategoryNameByGameAlias",gameAlias);
		return chzzkCategoryName;
	}

	@Override
	public List<Post> findTitleByKeyword(String keyword){
		List<Post> searchedByTitle = sqlSessionTemplate.selectList("board_mapper.findTitleByKeyword",keyword);
		return searchedByTitle;
	}
	
	@Override
	public List<Post> findContentByKeyword(String keyword){
		List<Post> searchedByContent = sqlSessionTemplate.selectList("board_mapper.findContentByKeyword",keyword);
		return searchedByContent;
	}
	
	@Override
	public List<UserInfo> findNicknameByKeyword(String keyword){
		List<UserInfo> searchedByNickname = sqlSessionTemplate.selectList("board_mapper.findNicknameByKeyword",keyword);
		return searchedByNickname;
	}
	
	@Override
	public List<GameNameTransferForm> findGameNameByKeyword(String keyword){
		List<GameNameTransferForm> searchedByBoardName = sqlSessionTemplate.selectList("board_mapper.findGameNameByKeyword",keyword);
		return searchedByBoardName;
	}
}
