package com.app.dao.post;

import java.util.List;
import java.util.Map;

import com.app.dto.board.Comments;
import com.app.dto.board.Media;
import com.app.dto.board.Post;
import com.app.dto.post.PostDetail;

public interface PostDAO {

	void updateViewCount(Long pId);
    PostDetail selectPostDetail(Map<String, Object> paramMap);
    List<Media> selectMediaListByPId(Long pId);
    List<Comments> selectCommentListByPId(Long pId);
    int insertPost(Map<String, Object> paramMap);
    
	List<Post> selectPostByUid(Long loginUserId);
	List<Post> selectPostByLikeCount(Long userId);
		
	
    

}
