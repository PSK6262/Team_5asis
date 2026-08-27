package com.app.dao.post;

import java.util.List;

import com.app.dto.board.Comments;
import com.app.dto.board.Media;
import com.app.dto.post.PostDetail;

public interface PostDAO {

	void updateViewCount(Long pId);
    PostDetail selectPostDetail(Long pId);
    List<Media> selectMediaListByPId(Long pId);
    List<Comments> selectCommentListByPId(Long pId);

}
