package com.app.service.comment;

import java.util.List;

import com.app.dto.board.Comments;
import com.app.dto.board.Post;

public interface CommentService {
    
	// 댓글 등록
    void insertComment(Long pId, Long uId, String content, Long parentCId);

	List<Comments> getCommentsByUid(Long loginUserId);

    // 댓글 수정 (수정할 댓글 ID, 수정할 내용, 작성자 확인용 uId)
    void updateComment(Long cId, Long uId, String content);

    // 댓글 삭제 (삭제할 댓글 ID, 작성자/권한 확인용 uId)
    void deleteComment(Long cId, Long uId);
    
    // 대댓글 등록
    void insertReply(Long pId, Long uId, Long parentCId, String content);

}
