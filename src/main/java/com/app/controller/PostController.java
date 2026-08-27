package com.app.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.app.dto.post.PostDetail;
import com.app.service.post.PostService;

@Controller
@RequestMapping("/post")
public class PostController {

    @Autowired
    private PostService postService;

    // 게시글 작성 페이지
    @GetMapping("/write")
    public String writeForm() {
        return "post/write";
    }

    // 게시글 상세 조회 (/post/12)
    @GetMapping("/{pId}")
    public String postDetail(@PathVariable("pId") Long pId, Model model) {
    	
        //조회수 1 증가
        postService.increaseViewCount(pId);

        //게시글 상세 데이터 조회
        PostDetail postDetail = postService.getPostDetail(pId);

        if (postDetail == null) {
            return "redirect:/main"; // 존재하지 않는 게시글일 경우 메인으로 이동
        }

        model.addAttribute("post", postDetail);
        return "post/post-detail";
    }
}
