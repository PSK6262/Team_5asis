package com.app.controller.board;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

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
    public String writeForm(@PathVariable("gameAlias") String gameAlias, Model model) {
        model.addAttribute("gameAlias", gameAlias);
        model.addAttribute("isEdit", false); 
        model.addAttribute("post", new PostDetail()); // JSP에서 EL 표기 오류를 방지하기 위해 빈 객체 전달

        return "post/post-form";
    }
    
    // 게시글 등록
    @PostMapping("/{gameAlias}/write")
    public String writePost(
            @PathVariable("gameAlias") String gameAlias,
            Post post) {

        // 로그인 기능이 아직 없으므로 임시 사용자
        post.setUid(TEMP_USER_ID);

        postService.insertPost(post, gameAlias);

        return "redirect:/board/" + gameAlias;
    }
    

    // 게시글 상세 조회 (/board/lol/5)
    @GetMapping("/{gameAlias}/{pId}")
    public String postDetail(@PathVariable("gameAlias") String gameAlias, 
    		@PathVariable("pId") Long pId, Model model) {

    	if("all".equals(gameAlias)) {
    		gameAlias = postService.findGameAliasByPostId(pId);
    		return "redirect:/board/"+gameAlias+"/"+pId;
    	}
    	
    	//게시글 상세 데이터 조회
    	PostDetail postDetail = postService.getPostDetail(pId, gameAlias);
    	
        //조회수 1 증가
        postService.increaseViewCount(pId);
        
        // ★현재 사용자 추천 여부 확인 (임시 u_id = 1L 사용)
        Long uId = TEMP_USER_ID; // 추후 로그인 세션 도입 시 session.getAttribute("uId")로 변경
        boolean isLiked = postService.isLiked(pId, uId);

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
			Model model) {

		PostDetail post = postService.getPostDetail(pId, gameAlias);

		if (post == null) {
			return "redirect:/main";
		}

		// 작성자 확인
		if (!TEMP_USER_ID.equals(post.getUid())) {
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
			@RequestParam("category") String category) {

		Long uId = TEMP_USER_ID;

		int result = postService.updatePost(pId, uId, title, content, category);

		return "redirect:/board/" + gameAlias + "/" + pId;
	}

	// 게시글 삭제
	@PostMapping("/{gameAlias}/{pId}/delete")
	public String deletePost(@PathVariable("gameAlias") String gameAlias, @PathVariable("pId") Long pId) {

		Long uId = TEMP_USER_ID;

		postService.deletePost(pId, uId);

		return "redirect:/board/" + gameAlias;
	}
    
    
    
    // 추천 / 추천취소
    @PostMapping("/{pId}/like")
    @ResponseBody
    public Map<String, Object> likePost(@PathVariable Long pId) {
        Map<String, Object> result = new HashMap<>();
        Long tempUid = 1L; 

        try {
            Map<String, Object> likeResult = postService.processLike(pId, tempUid);
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
