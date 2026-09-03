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
        // Post DTO의 gameAlias 필드에 설정
        post.setGameAlias(gameAlias);

        // Map 대신 post 객체를 직접 전달해야 insert 후 post.getPid()에 ID가 들어옴
        return postDAO.insertPost(post);
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

	@Override
	public int updatePost(Long pId, Long uId, String title, String content, String category) {
		return postDAO.updatePost(
	            pId,
	            uId,
	            title,
	            content,
	            category
	    );
	}

	@Override
	public int deletePost(Long pId, Long uId) {
		
		return postDAO.deletePost(pId, uId);
		
	}
	
	@Override
	public List<Post> getPostByUid(Long loginUserId) {
		return postDAO.selectPostByUid(loginUserId);
	}

	@Override
	public List<Post> selectPostByLikeCount(Long loginUserId) {
		// TODO Auto-generated method stub
		return postDAO.selectPostByLikeCount(loginUserId);
	}

	@Override
	public String findGameAliasByPostId(Long pId) {
		String gameAlias = postDAO.findGameAliasByPostId(pId);
		return gameAlias;
	}

}
