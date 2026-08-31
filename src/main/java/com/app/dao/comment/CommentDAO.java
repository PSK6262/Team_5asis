package com.app.dao.comment;

public interface CommentDAO {
	
	void insertComment(Long pId, Long uId, String content);

}
