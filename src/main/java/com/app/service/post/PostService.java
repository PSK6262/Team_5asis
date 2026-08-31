package com.app.service.post;

import java.util.Map;

import com.app.dto.board.Post;
import com.app.dto.post.PostDetail;

public interface PostService {
    void increaseViewCount(Long pId);
    PostDetail getPostDetail(Long pId, String gameAlias);
    int insertPost(Post post, String gameAlias);
    
    int increaseLike(Long pId, Long uId);
    boolean isLiked(Long pId, Long uId);
	Map<String, Object> processLike(Long pId, Long uId);
}
