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
	public int increaseLike(Long pId, Long uId) {
		Map<String, Object> map = new HashMap<>();
        map.put("pId", pId);
        map.put("uId", uId);

        // 1. 중복 추천 여부 검증
        int count = postDAO.checkLikeHistory(map);
        if (count > 0) {
            throw new IllegalStateException("ALREADY_LIKED");
        }

        // 2. 이력 추가 및 추천수 증가
        postDAO.insertLikeHistory(map);
        postDAO.updateLikeCount(pId);

        // 3. 최신 추천수 반환
        return postDAO.getLikeCount(pId);
	}

	@Override
	public boolean isLiked(Long pId, Long uId) {
		if (uId == null) return false;
	    
	    Map<String, Object> map = new HashMap<>();
	    map.put("pId", pId);
	    map.put("uId", uId);
	    
	    return postDAO.checkLikeHistory(map) > 0;
	}
	
	// 추천 및 추천 취소 처리
	@Override
    public Map<String, Object> processLike(Long pId, Long uId) {
        Map<String, Object> map = new HashMap<>();
        map.put("pId", pId);
        map.put("uId", uId);

        int count = postDAO.checkLikeHistory(map);
        boolean isLiked;

        if (count > 0) {
            // 이미 추천함 -> 추천 취소
            postDAO.deleteLikeHistory(map);
            postDAO.decreaseLikeCount(pId);
            isLiked = false;
        } else {
            // 추천 안 함 -> 추천 추가
            postDAO.insertLikeHistory(map);
            postDAO.updateLikeCount(pId);
            isLiked = true;
        }

        int updatedLikeCount = postDAO.getLikeCount(pId);

        Map<String, Object> result = new HashMap<>();
        result.put("isLiked", isLiked);
        result.put("updatedLikeCount", updatedLikeCount);
        return result;
    }
}
