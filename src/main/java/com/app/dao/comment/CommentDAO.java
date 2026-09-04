package com.app.dao.comment;

import java.util.List;

import com.app.dto.board.Comments;

public interface CommentDAO {
	
	void insertComment(Long pId, Long uId, String content, Long parentCId);

	List<Comments> selectCommentByUid(Long loginUserId);

	void insertReply(Long pId, Long uId, Long parentCId, String content);
	
	void deleteComment(Long cId, Long uId, boolean isAdmin);
	void markAsDeleted(Long cId, Long uId, boolean isAdmin);
	void updateComment(Long cId, Long uId, String content, boolean isAdmin);

	int countReplies(Long cId);
	
	Comments selectCommentById(Long cId);
	void deleteCommentById(Long cId);

	Long countCommentsByPostId(Long pid);
	
	int checkCommentLike(Long uId, Long cId);
    void insertCommentLike(Long uId, Long cId);
    void deleteCommentLike(Long uId, Long cId);
    void updateCommentLikeCount(Long cId, int amount);
    int getCommentLikeCount(Long cId);
	
	
}
