package com.app.service.comment.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.app.dao.comment.CommentDAO;
import com.app.service.comment.CommentService;

@Service
public class CommentServiceImpl implements CommentService {

	@Autowired
    private CommentDAO commentDAO;

    @Override
    public void insertComment(Long pId, Long uId, String content) {

        commentDAO.insertComment(pId, uId, content);

    }

}
