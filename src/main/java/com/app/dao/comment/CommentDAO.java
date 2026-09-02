package com.app.dao.comment;

import java.util.List;

import com.app.dto.board.Comments;

public interface CommentDAO {
	
	void insertComment(Long pId, Long uId, String content, Long parentCId);

	List<Comments> selectCommentByUid(Long loginUserId);
	
	void deleteComment(Long cId, Long uId);

	void updateComment(Long cId, Long uId, String content);

	void insertReply(Long pId, Long uId, Long parentCId, String content);

	int countReplies(Long cId);
	void markAsDeleted(Long cId, Long uId);
	
	Comments selectCommentById(Long cId);
	void deleteCommentById(Long cId);

	Long countCommentsByPostId(Long pid);
	
	int checkCommentLike(Long uId, Long cId);
    void insertCommentLike(Long uId, Long cId);
    void deleteCommentLike(Long uId, Long cId);
    void updateCommentLikeCount(Long cId, int amount);
    int getCommentLikeCount(Long cId);
	
	
}
