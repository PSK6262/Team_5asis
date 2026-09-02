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
	public void insertComment(Long pId, Long uId, String content, Long parentCId) {
		
		Map<String, Object> paramMap = new HashMap<>();

        paramMap.put("pId", pId);
        paramMap.put("uId", uId);
        paramMap.put("content", content);
        paramMap.put("parentCId", parentCId);

        sql.insert(NAMESPACE + "insertComment", paramMap);
		
	}
	
	@Override
	public List<Comments> selectCommentByUid(Long loginUserId) {
		
		return sql.selectList(NAMESPACE + "selectCommentByUid", loginUserId);
	}

	@Override
	public void deleteComment(Long cId, Long uId) {
		Map<String, Object> paramMap = new HashMap<>();

        paramMap.put("cId", cId);
        paramMap.put("uId", uId);

        sql.update(NAMESPACE + "deleteComment", paramMap);
		
	}

	@Override
	public void updateComment(Long cId, Long uId, String content) {
		Map<String, Object> paramMap = new HashMap<>();

        paramMap.put("cId", cId);
        paramMap.put("uId", uId);
        paramMap.put("content", content);

        sql.insert(NAMESPACE + "updateComment", paramMap);
		
	}

	@Override
	public void insertReply(Long pId, Long uId, Long parentCId, String content) {
		Map<String, Object> paramMap = new HashMap<>();

	    paramMap.put("pId", pId);
	    paramMap.put("uId", uId);
	    paramMap.put("parentCId", parentCId);
	    paramMap.put("content", content);

	    sql.insert(NAMESPACE + "insertReply", paramMap);
		
	}
	
	@Override
	public int countReplies(Long cId) {
	    return sql.selectOne(NAMESPACE + "countReplies", cId);
	}

	@Override
	public void markAsDeleted(Long cId, Long uId) {
	    Map<String, Object> paramMap = new HashMap<>();
	    paramMap.put("cId", cId);
	    paramMap.put("uId", uId);
	    sql.update(NAMESPACE + "markAsDeleted", paramMap);
	}
	
	@Override
	public Comments selectCommentById(Long cId) {
	    return sql.selectOne(NAMESPACE + "selectCommentById", cId);
	}

	@Override
	public void deleteCommentById(Long cId) {
	    sql.delete(NAMESPACE + "deleteCommentById", cId);
	}
	
	@Override
    public int checkCommentLike(Long uId, Long cId) {
        Map<String, Object> params = new HashMap<>();
        params.put("uId", uId);
        params.put("cId", cId);
        return sql.selectOne(NAMESPACE + "checkCommentLike", params);
    }

    @Override
    public void insertCommentLike(Long uId, Long cId) {
        Map<String, Object> params = new HashMap<>();
        params.put("uId", uId);
        params.put("cId", cId);
        sql.insert(NAMESPACE + "insertCommentLike", params);
    }

    @Override
    public void deleteCommentLike(Long uId, Long cId) {
        Map<String, Object> params = new HashMap<>();
        params.put("uId", uId);
        params.put("cId", cId);
        sql.delete(NAMESPACE + "deleteCommentLike", params);
    }

    @Override
    public void updateCommentLikeCount(Long cId, int amount) {
        Map<String, Object> params = new HashMap<>();
        params.put("cId", cId);
        params.put("amount", amount);
        sql.update(NAMESPACE + "updateCommentLikeCount", params);
    }

    @Override
    public int getCommentLikeCount(Long cId) {
        return sql.selectOne(NAMESPACE + "getCommentLikeCount", cId);
    }

	@Override
	public Long countCommentsByPostId(Long pid) {
		Long commentCount = sql.selectOne(NAMESPACE + "countCommentsByPostId",pid);
		return commentCount;
	}

}
