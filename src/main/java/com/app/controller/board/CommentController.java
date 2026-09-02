package com.app.controller.board;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.app.dto.user.UserInfo;
import com.app.service.comment.CommentService;

@Controller
@RequestMapping("/board")
public class CommentController {

    @Autowired
    private CommentService commentService;
    
    // 댓글 작성
    @PostMapping("/{gameAlias}/{pId}/comment")
    public String writeComment(
            @PathVariable("gameAlias") String gameAlias,
            @PathVariable("pId") Long pId,
            @RequestParam("commentContent") String commentContent,
            HttpSession session) {

    	// 로그인 처리 시 세션에 저장해둔 Key 가져오기
        UserInfo loginUser = (UserInfo) session.getAttribute("LOGIN_USER");
        if (loginUser == null) {
            return "redirect:/user/login"; // 비로그인 시 로그인 페이지로 리다이렉트
        }

        commentService.insertComment(pId, loginUser.getUid(), commentContent, null);

        // 댓글 작성 후 기존 게시글 상세 페이지로 이동
        return "redirect:/board/" + gameAlias + "/" + pId;
    }
    
    // 댓글 수정
    @PostMapping("/{gameAlias}/{pId}/comment/{cId}/edit")
    public String updateComment(
            @PathVariable("gameAlias") String gameAlias,
            @PathVariable("pId") Long pId,
            @PathVariable("cId") Long cId,
            @RequestParam("commentContent") String commentContent,
            HttpSession session) {
    	
    	UserInfo loginUser = (UserInfo) session.getAttribute("LOGIN_USER");
        if (loginUser == null) {
            return "redirect:/user/login";
        }

        commentService.updateComment(cId, loginUser.getUid(), commentContent);

        return "redirect:/board/" + gameAlias + "/" + pId;
    }

    // 댓글 삭제
    @PostMapping("/{gameAlias}/{pId}/comment/{cId}/delete")
    public String deleteComment(
            @PathVariable("gameAlias") String gameAlias,
            @PathVariable("pId") Long pId,
            @PathVariable("cId") Long cId,
            HttpSession session) {
    	
    	UserInfo loginUser = (UserInfo) session.getAttribute("LOGIN_USER");
        if (loginUser == null) {
            return "redirect:/user/login";
        }

        commentService.deleteComment(cId, loginUser.getUid());

        return "redirect:/board/" + gameAlias + "/" + pId;
    }
    
    // 대댓글 작성
    @PostMapping("/{gameAlias}/{pId}/comment/{parentCId}/reply")
    public String writeReply(
            @PathVariable("gameAlias") String gameAlias,
            @PathVariable("pId") Long pId,
            @PathVariable("parentCId") Long parentCId,
            @RequestParam("commentContent") String commentContent,
            HttpSession session) {

    	UserInfo loginUser = (UserInfo) session.getAttribute("LOGIN_USER");
        if (loginUser == null) {
            return "redirect:/user/login";
        }

        commentService.insertComment(pId, loginUser.getUid(), commentContent, parentCId);

        return "redirect:/board/" + gameAlias + "/" + pId;
    }
    
    @PostMapping("/{gameAlias}/{pId}/comment/{cId}/like")
    @ResponseBody
    public Map<String, Object> toggleCommentLike(
            @PathVariable("gameAlias") String gameAlias,
            @PathVariable("pId") Long pId,
            @PathVariable("cId") Long cId,
            HttpSession session) {

    	Map<String, Object> response = new HashMap<>();
        UserInfo loginUser = (UserInfo) session.getAttribute("LOGIN_USER");

        if (loginUser == null) {
            response.put("status", "require_login");
            return response;
        }

        return commentService.toggleCommentLike(loginUser.getUid(), cId);
    }
    

}
