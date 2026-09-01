package com.app.service.post.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.app.dao.post.PostDAO;
import com.app.dto.board.Comments;
import com.app.dto.board.Media;
import com.app.dto.board.Post;
import com.app.dto.post.PostDetail;
import com.app.service.post.PostService;

@Service
public class PostServiceImpl implements PostService {

    @Autowired
    private PostDAO postDAO;

    
    
    @Override
    public void increaseViewCount(Long pId) {
    	postDAO.updateViewCount(pId);
    }

    @Override
    public PostDetail getPostDetail(Long pId, String gameAlias) {
        // DAO로 전달할 파라미터 Map 생성
        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("gameAlias", gameAlias);
        paramMap.put("pId", pId);

        // Map을 전달하여 조인 검증된 게시글 조회
        PostDetail postDetail = postDAO.selectPostDetail(paramMap);

        if (postDetail != null) {
            List<Media> mediaList = postDAO.selectMediaListByPId(pId);
            postDetail.setMediaList(mediaList);

            List<Comments> commentList = postDAO.selectCommentListByPId(pId);
            postDetail.setCommentList(commentList);
        }

        return postDetail;
    }

	@Override
	public int insertPost(Post post, String gameAlias) {
		Map<String, Object> paramMap = new HashMap<>();

		paramMap.put("title", post.getTitle());
	    paramMap.put("content", post.getContent());
	    paramMap.put("uId", post.getUid());
	    paramMap.put("category", post.getCategory());
	    paramMap.put("gameAlias", gameAlias);

	    return postDAO.insertPost(paramMap);
	}

	@Override
	public List<Post> getPostByUid(Long loginUserId) {
		
		return postDAO.selectPostByUid(loginUserId);
	}

	@Override
	public List<Post> selectPostByLikeCount(Long loginUserId) {
		// TODO Auto-generated method stub
		return postDAO.selectPostByUid(loginUserId);
	}
}
