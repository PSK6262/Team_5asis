package com.app.dao.post.impl;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.app.dao.post.PostDAO;
import com.app.dto.board.Comments;
import com.app.dto.board.Media;
import com.app.dto.post.PostDetail;

@Repository
public class PostDAOImpl implements PostDAO {

    @Autowired
    private SqlSessionTemplate sql;

    // XML 파일의 <mapper namespace="PostMapper">와 일치해야 함
    private final String NAMESPACE = "PostMapper.";

    @Override
    public void updateViewCount(Long pId) {
        sql.update(NAMESPACE + "updateViewCount", pId);
    }

//    @Override
//    public PostDetail selectPostDetail(Long pId) {
//        return sql.selectOne(NAMESPACE + "selectPostDetail", pId);
//    }

    @Override
    public List<Media> selectMediaListByPId(Long pId) {
        return sql.selectList(NAMESPACE + "selectMediaListByPId", pId);
    }

    @Override
    public List<Comments> selectCommentListByPId(Long pId) {
        return sql.selectList(NAMESPACE + "selectCommentListByPId", pId);
    }

	@Override
	public PostDetail selectPostDetail(Map<String, Object> paramMap) {
		return sql.selectOne("PostMapper.selectPostDetail", paramMap);
	}

	@Override
	public int insertPost(Map<String, Object> paramMap) {
		return sql.insert(NAMESPACE + "insertPost", paramMap);
	}

	@Override
    public int checkLikeHistory(Map<String, Object> map) {
        return sql.selectOne(NAMESPACE + "checkLikeHistory", map);
    }

    @Override
    public void insertLikeHistory(Map<String, Object> map) {
        sql.insert(NAMESPACE + "insertLikeHistory", map);
    }

    @Override
    public void updateLikeCount(Long pId) {
        sql.update(NAMESPACE + "updateLikeCount", pId);
    }

    @Override
    public int getLikeCount(Long pId) {
        return sql.selectOne(NAMESPACE + "getLikeCount", pId);
    }
    
    @Override
    public void deleteLikeHistory(Map<String, Object> map) {
        sql.delete(NAMESPACE + "deleteLikeHistory", map);
    }

    @Override
    public void decreaseLikeCount(Long pId) {
        sql.update(NAMESPACE + "decreaseLikeCount", pId);
    }
}
