package com.app.service.post;

import com.app.dto.post.PostDetail;

public interface PostService {
    void increaseViewCount(Long pId);
    PostDetail getPostDetail(Long pId, String gameAlias);
}
