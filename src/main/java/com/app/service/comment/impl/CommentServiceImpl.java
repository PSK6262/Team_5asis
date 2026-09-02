package com.app.service.comment.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.app.dao.comment.CommentDAO;
import com.app.dto.board.Comments;
import com.app.service.comment.CommentService;

@Service
public class CommentServiceImpl implements CommentService {

	@Autowired
    private CommentDAO commentDAO;

    @Override
    public void insertComment(Long pId, Long uId, String content, Long parentCId) {

        commentDAO.insertComment(pId, uId, content, parentCId);

    }

    @Override
	public List<Comments> getCommentsByUid(Long loginUserId) {
		return commentDAO.selectCommentByUid(loginUserId);
	}

	@Override
	public void updateComment(Long cId, Long uId, String content) {
		commentDAO.updateComment(cId, uId, content);
		
	}

	@Override
	public void insertReply(Long pId, Long uId, Long parentCId, String content) {
		commentDAO.insertReply(pId, uId, parentCId, content);
		
	}

	@Override
	public void deleteComment(Long cId, Long uId) {
		// 1. 해당 댓글 아래에 달린 대댓글(자식 댓글) 개수 확인
	    int replyCount = commentDAO.countReplies(cId);

	    if (replyCount > 0) {
	        // 2-1. 대댓글이 존재하면 내용만 "삭제된 댓글입니다."로 변경
	        commentDAO.markAsDeleted(cId, uId);
	    } else {
	        // 2-2. 대댓글이 없으면 DB에서 완전히 삭제 (기존 DELETE 쿼리 호출)
	        commentDAO.deleteComment(cId, uId);
	    }
		
	}
    

}
