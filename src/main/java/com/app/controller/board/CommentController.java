package com.app.controller.board;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.app.service.comment.CommentService;

@Controller
@RequestMapping("/board")
public class CommentController {

    @Autowired
    private CommentService commentService;
    
    // 현재 임시 로그인 사용자
    private final Long TEMP_USER_ID = 1L;
    
    // 댓글 작성
    @PostMapping("/{gameAlias}/{pId}/comment")
    public String writeComment(
            @PathVariable("gameAlias") String gameAlias,
            @PathVariable("pId") Long pId,
            @RequestParam("commentContent") String commentContent) {

        // 현재 로그인 기능이 없으므로 임시 사용자 ID
        Long uId = TEMP_USER_ID;

        commentService.insertComment(pId, uId, commentContent);

        // 댓글 작성 후 기존 게시글 상세 페이지로 이동
        return "redirect:/board/" + gameAlias + "/" + pId;
    }
    
    // 댓글 수정
    @PostMapping("/{gameAlias}/{pId}/comment/{cId}/edit")
    public String updateComment(
            @PathVariable("gameAlias") String gameAlias,
            @PathVariable("pId") Long pId,
            @PathVariable("cId") Long cId,
            @RequestParam("commentContent") String commentContent) {

        commentService.updateComment(cId, TEMP_USER_ID, commentContent);
        return "redirect:/board/" + gameAlias + "/" + pId;
    }

    // 댓글 삭제
    @PostMapping("/{gameAlias}/{pId}/comment/{cId}/delete")
    public String deleteComment(
            @PathVariable("gameAlias") String gameAlias,
            @PathVariable("pId") Long pId,
            @PathVariable("cId") Long cId) {

        commentService.deleteComment(cId, TEMP_USER_ID);
        return "redirect:/board/" + gameAlias + "/" + pId;
    }

}
