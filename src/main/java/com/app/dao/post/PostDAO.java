package com.app.dao.post;

import java.util.List;
import java.util.Map;

import com.app.dto.board.Comments;
import com.app.dto.board.Media;
import com.app.dto.post.PostDetail;

public interface PostDAO {

	void updateViewCount(Long pId);
    PostDetail selectPostDetail(Map<String, Object> paramMap);
    List<Media> selectMediaListByPId(Long pId);
    List<Comments> selectCommentListByPId(Long pId);
    int insertPost(Map<String, Object> paramMap);
    
    int checkLikeHistory(Map<String, Object> map);
    void insertLikeHistory(Map<String, Object> map);
    void updateLikeCount(Long pId);
    int getLikeCount(Long pId);
    
    void deleteLikeHistory(Map<String, Object> map);
    void decreaseLikeCount(Long pId);
    
	int updatePost(Long pId, Long uId, String title, String content, String category);
	int deletePost(Long pId, Long uId);

}
