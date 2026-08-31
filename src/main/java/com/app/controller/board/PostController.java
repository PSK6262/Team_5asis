package com.app.controller.board;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.app.dto.board.Post;
import com.app.dto.post.PostDetail;
import com.app.service.post.PostService;

@Controller
@RequestMapping("/board")
public class PostController {

    @Autowired
    private PostService postService;

    //게시글 작성 페이지 (/board/lol/write)
    @GetMapping("/{gameAlias}/write")
    public String writeForm(@PathVariable("gameAlias") String gameAlias,
            Model model) {

        model.addAttribute("gameAlias", gameAlias);

        return "post/write";
    }
    
    // 게시글 등록
    @PostMapping("/{gameAlias}/write")
    public String writePost(
            @PathVariable("gameAlias") String gameAlias,
            Post post) {

        // 로그인 기능이 아직 없으므로 임시 사용자
        post.setUid(1L);

        postService.insertPost(post, gameAlias);

        return "redirect:/board/" + gameAlias;
    }
    

    // 게시글 상세 조회 (/board/lol/5)
    @GetMapping("/{gameAlias}/{pId}")
    public String postDetail(@PathVariable("gameAlias") String gameAlias, 
    		@PathVariable("pId") Long pId, Model model) {
    	
    	System.out.println(">>> 요청받은 gameAlias: " + gameAlias + ", pId: " + pId);

    	//게시글 상세 데이터 조회
    	PostDetail postDetail = postService.getPostDetail(pId, gameAlias);
    	 
        System.out.println(">>> 조회 결과 postDetail: " + postDetail);
    	
        //조회수 1 증가
        postService.increaseViewCount(pId);

        if (postDetail == null) {
        	// 해당 게임 게시판에 속한 글이 아닐 경우
            return "redirect:/main";
        }

        model.addAttribute("post", postDetail);
        model.addAttribute("gameAlias", gameAlias);
        
        return "post/post-detail";
    }
}
