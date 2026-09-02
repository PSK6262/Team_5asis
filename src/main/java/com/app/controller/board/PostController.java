package com.app.controller.board;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.app.dto.board.Post;
import com.app.dto.post.PostDetail;
import com.app.dto.user.UserInfo;
import com.app.service.post.PostService;

@Controller
@RequestMapping("/board")
public class PostController {

    @Autowired
    private PostService postService;
    
    // 현재 임시 로그인 사용자
    private final Long TEMP_USER_ID = 1L;

    //게시글 작성 페이지 (/board/lol/write)
    @GetMapping("/{gameAlias}/write")
    public String writeForm(@PathVariable("gameAlias") String gameAlias, 
    		Model model,
    		HttpSession session) {
    	
    	UserInfo loginUser = (UserInfo) session.getAttribute("LOGIN_USER");
        if (loginUser == null) {
            return "redirect:/user/login";
        }
        
        model.addAttribute("gameAlias", gameAlias);
        model.addAttribute("isEdit", false); 
        model.addAttribute("post", new PostDetail()); // JSP에서 EL 표기 오류를 방지하기 위해 빈 객체 전달

        return "post/post-form";
    }
    
    // 게시글 등록
    @PostMapping("/{gameAlias}/write")
    public String writePost(
            @PathVariable("gameAlias") String gameAlias,
            Post post,
            HttpSession session) {

    	UserInfo loginUser = (UserInfo) session.getAttribute("LOGIN_USER");
        if (loginUser == null) {
            return "redirect:/user/login";
        }

        // 세션에서 로그인한 유저의 uid 세팅
        post.setUid(loginUser.getUid());

        postService.insertPost(post, gameAlias);

        return "redirect:/board/" + gameAlias;
    }
    

    // 게시글 상세 조회 (/board/lol/5)
    @GetMapping("/{gameAlias}/{pId}")
    public String postDetail(@PathVariable("gameAlias") String gameAlias, 
    		@PathVariable("pId") Long pId, 
    		Model model,
    		HttpSession session) {

    	//게시글 상세 데이터 조회
    	PostDetail postDetail = postService.getPostDetail(pId, gameAlias);
    	
        //조회수 1 증가
        postService.increaseViewCount(pId);
        
        // 현재 로그인 사용자 추천 여부 확인 (비로그인 상태면 false)
        UserInfo loginUser = (UserInfo) session.getAttribute("LOGIN_USER");
        boolean isLiked = false;
        if (loginUser != null) {
            isLiked = postService.isLiked(pId, loginUser.getUid());
        }

        if (postDetail == null) {
        	// 해당 게임 게시판에 속한 글이 아닐 경우
            return "redirect:/main";
        }

        model.addAttribute("post", postDetail);
        model.addAttribute("gameAlias", gameAlias);
        model.addAttribute("isLiked", isLiked);
        
        return "post/post-detail";
    }

	// 게시글 수정 페이지
	@GetMapping("/{gameAlias}/{pId}/edit")
	public String editForm(@PathVariable("gameAlias") String gameAlias, 
			@PathVariable("pId") Long pId, 
			Model model,
			HttpSession session) {
		
		UserInfo loginUser = (UserInfo) session.getAttribute("LOGIN_USER");
        if (loginUser == null) {
            return "redirect:/user/login";
        }

		PostDetail post = postService.getPostDetail(pId, gameAlias);

		if (post == null) {
			return "redirect:/main";
		}

		// 본인 작성자 검증 (로그인한 유저와 게시글 작성자 uId 비교)
        if (!loginUser.getUid().equals(post.getUid())) {
            return "redirect:/board/" + gameAlias + "/" + pId;
        }

		model.addAttribute("post", post);
		model.addAttribute("gameAlias", gameAlias);
		model.addAttribute("isEdit", true); 

        return "post/post-form";

	}

	// 게시글 수정
	@PostMapping("/{gameAlias}/{pId}/edit")
	public String editPost(@PathVariable("gameAlias") String gameAlias, 
			@PathVariable("pId") Long pId,
			@RequestParam("title") String title, 
			@RequestParam("content") String content,
			@RequestParam("category") String category,
			HttpSession session) {

		UserInfo loginUser = (UserInfo) session.getAttribute("LOGIN_USER");
        if (loginUser == null) {
            return "redirect:/user/login";
        }

        int result = postService.updatePost(pId, loginUser.getUid(), title, content, category);

		return "redirect:/board/" + gameAlias + "/" + pId;
	}

	// 게시글 삭제
	@PostMapping("/{gameAlias}/{pId}/delete")
	public String deletePost(@PathVariable("gameAlias") String gameAlias, @PathVariable("pId") Long pId,
			HttpSession session) {

		UserInfo loginUser = (UserInfo) session.getAttribute("LOGIN_USER");
		if (loginUser == null) {
			return "redirect:/user/login";
		}

		postService.deletePost(pId, loginUser.getUid());

		return "redirect:/board/" + gameAlias;
	}
    
    
    
    // 추천 / 추천취소
    @PostMapping("/{pId}/like")
    @ResponseBody
    public Map<String, Object> likePost(@PathVariable Long pId,
    		HttpSession session) {
    	
    	Map<String, Object> result = new HashMap<>();
        UserInfo loginUser = (UserInfo) session.getAttribute("LOGIN_USER");

        // 비로그인 사용자 추천 시 JSON으로 거부 응답 전송
        if (loginUser == null) {
            result.put("status", "require_login");
            result.put("message", "로그인이 필요한 서비스입니다.");
            return result;
        }

        try {
            Map<String, Object> likeResult = postService.processLike(pId, loginUser.getUid());
            result.put("status", "success");
            result.put("isLiked", likeResult.get("isLiked"));
            result.put("updatedLikeCount", likeResult.get("updatedLikeCount"));
        } catch (Exception e) {
            e.printStackTrace();
            result.put("status", "error");
        }

        return result;
    }
}
