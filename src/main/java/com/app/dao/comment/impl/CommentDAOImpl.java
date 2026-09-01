package com.app.dao.comment.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.app.dao.comment.CommentDAO;
import com.app.dto.board.Comments;

@Repository
public class CommentDAOImpl implements CommentDAO {
	
	@Autowired
    private SqlSessionTemplate sql;

	private final String NAMESPACE = "CommentMapper.";

	@Override
	public void insertComment(Long pId, Long uId, String content) {
		
		Map<String, Object> paramMap = new HashMap<>();

        paramMap.put("pId", pId);
        paramMap.put("uId", uId);
        paramMap.put("content", content);

        sql.insert(NAMESPACE + "insertComment", paramMap);
		
	}
	
	@Override
	public List<Comments> selectCommentByUid(Long loginUserId) {
		
		return sql.selectList(NAMESPACE + "selectCommentByUid", loginUserId);
	}

}
