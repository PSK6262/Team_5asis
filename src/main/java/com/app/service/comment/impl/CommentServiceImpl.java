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
	
	@Transactional // 여러 DB 조작이 일어나므로 트랜잭션 처리 권장
	@Override
	public void deleteComment(Long cId, Long uId) {
	    // 0. 삭제 대상 댓글의 정보를 먼저 조회
	    Comments targetComment = commentDAO.selectCommentById(cId);
	    if (targetComment == null) return;

	    Long parentCId = targetComment.getParentCId();

	    // 1. 해당 댓글 아래에 달린 대댓글(자식 댓글) 개수 확인
	    int replyCount = commentDAO.countReplies(cId);

	    if (replyCount > 0) {
	        // 2-1. 대댓글이 존재하면 내용만 "삭제된 댓글입니다."로 변경
	        commentDAO.markAsDeleted(cId, uId);
	    } else {
	        // 2-2. 대댓글이 없으면 DB에서 완전히 삭제
	        commentDAO.deleteComment(cId, uId);

	        // 3. 만약 삭제한 댓글이 '대댓글'이었을 경우 (parentCId != null), 
	        //    부모 댓글이 '삭제된 댓글입니다.' 상태이고 남은 대댓글이 0개라면 부모 댓글도 삭제
	        if (parentCId != null) {
	            cleanUpParentComment(parentCId);
	        }
	    }
	}

	// 부모 댓글 cleanup 메소드
	private void cleanUpParentComment(Long parentCId) {
	    Comments parent = commentDAO.selectCommentById(parentCId);
	    if (parent == null) return;

	    // 부모 댓글의 남은 대댓글 수 확인
	    int parentReplyCount = commentDAO.countReplies(parentCId);

	    // 부모 댓글이 이미 '삭제된 댓글입니다.' 상태이고, 남아있는 대댓글이 0개라면 완전 삭제
	    if ("삭제된 댓글입니다.".equals(parent.getContent()) && parentReplyCount == 0) {
	        commentDAO.deleteCommentById(parentCId);
	        
	        // 만약 부모 댓글의 부모(상위) 댓글이 또 존재하는 다단계 구조라면 재귀적으로 처리 가능
	        if (parent.getParentCId() != null) {
	            cleanUpParentComment(parent.getParentCId());
	        }
	    }
	}

	@Override
	public Map<String, Object> toggleCommentLike(Long uId, Long cId) {
		Map<String, Object> result = new HashMap<>();

        // 1. 이미 추천했는지 여부 체크
        int count = commentDAO.checkCommentLike(uId, cId);
        boolean isLiked;

        if (count > 0) {
            // 이미 추천한 상태 -> 취소 처리 (-1)
            commentDAO.deleteCommentLike(uId, cId);
            commentDAO.updateCommentLikeCount(cId, -1);
            isLiked = false;
        } else {
            // 추천 안 한 상태 -> 추천 처리 (+1)
            commentDAO.insertCommentLike(uId, cId);
            commentDAO.updateCommentLikeCount(cId, 1);
            isLiked = true;
        }

        // 2. 변경된 최신 추천수 조회
        int updatedLikeCount = commentDAO.getCommentLikeCount(cId);

        result.put("status", "success");
        result.put("isLiked", isLiked);
        result.put("updatedLikeCount", updatedLikeCount);

        return result;
	}
    

}
