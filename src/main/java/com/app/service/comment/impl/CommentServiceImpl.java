package com.app.service.comment.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.app.dao.comment.CommentDAO;
import com.app.dto.board.Comments;
import com.app.service.comment.CommentService;

@Service
public class CommentServiceImpl implements CommentService {

	@Autowired
    private CommentDAO commentDAO;

    @Override
    public void insertComment(Long pId, Long uId, String content) {

        commentDAO.insertComment(pId, uId, content);

    }

    @Override
	public List<Comments> getCommentsByUid(Long loginUserId) {
		return commentDAO.selectCommentByUid(loginUserId);
	}

}
