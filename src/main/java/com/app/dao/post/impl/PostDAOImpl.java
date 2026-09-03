package com.app.dao.post.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.app.dao.post.PostDAO;
import com.app.dto.board.Comments;
import com.app.dto.board.Media;
import com.app.dto.board.Post;
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
	public int insertPost(Post post) {
	    return sql.insert(NAMESPACE + "insertPost", post);
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

	@Override
	public int updatePost(Long pId, Long uId, String title, String content, String category) {
		Map<String, Object> paramMap = new HashMap<>();

	    paramMap.put("pId", pId);
	    paramMap.put("uId", uId);
	    paramMap.put("title", title);
	    paramMap.put("content", content);
	    paramMap.put("category", category);

	    return sql.update(
	            NAMESPACE + "updatePost",
	            paramMap
	    );
	}

	@Override
	public int deletePost(Long pId, Long uId) {
		Map<String, Object> paramMap = new HashMap<>();

	    paramMap.put("pId", pId);
	    paramMap.put("uId", uId);

	    return sql.delete(
	            NAMESPACE + "deletePost",
	            paramMap
	    );
	}
	
	@Override
	public List<Post> selectPostByUid(Long loginUserId) {
		
		return sql.selectList(NAMESPACE + "selectPostByUid", loginUserId);
	}

	@Override
	public List<Post> selectPostByLikeCount(Long loginUserId) {
		// TODO Auto-generated method stub
		return sql.selectList(NAMESPACE + "selectPostByLikeCount", loginUserId);
	}

	@Override
	public String findGameAliasByPostId(Long pId) {
		String gameAlias = sql.selectOne(NAMESPACE + "findGameAliasByPostId",pId);
		return gameAlias;
	}

}
