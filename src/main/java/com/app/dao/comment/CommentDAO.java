package com.app.dao.comment;

import java.util.List;

import com.app.dto.board.Comments;
import com.app.dto.board.Post;

public interface CommentDAO {
	
	void insertComment(Long pId, Long uId, String content);

	List<Comments> selectCommentByUid(Long loginUserId);
	
	void deleteComment(Long cId, Long uId);

	void updateComment(Long cId, Long uId, String content);
	
	
}
