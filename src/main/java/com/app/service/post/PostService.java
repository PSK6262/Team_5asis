package com.app.service.post;

import java.util.List;
import java.util.Map;

import com.app.dto.board.Post;
import com.app.dto.post.PostDetail;

public interface PostService {
    void increaseViewCount(Long pId);
    PostDetail getPostDetail(Long pId, String gameAlias);
    int insertPost(Post post, String gameAlias);
    List<Post> getPostByUid(Long loginUserId);
    List<Post> selectPostByLikeCount(Long loginUserId);
    
    boolean isLiked(Long pId, Long uId);
	Map<String, Object> processLike(Long pId, Long uId);
	
	int updatePost(Long pId, Long uId, String title, String content, String category);
	int deletePost(Long pId, Long uId);
	
	
}
