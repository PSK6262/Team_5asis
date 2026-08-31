package com.app.service.post;

import java.util.List;

import com.app.dto.board.Post;
import com.app.dto.post.PostDetail;

public interface PostService {
    void increaseViewCount(Long pId);
    PostDetail getPostDetail(Long pId, String gameAlias);
    int insertPost(Post post, String gameAlias);
    List<Post> getPostByUid(Long loginUserId);
	
}
