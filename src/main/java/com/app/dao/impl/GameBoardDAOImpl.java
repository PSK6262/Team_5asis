package com.app.dao.impl;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.app.dao.GameBoardDAO;
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
}
