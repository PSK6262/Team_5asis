package com.app.controller.board;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.app.dto.board.Comments;
import com.app.dto.board.Post;
import com.app.dto.user.UserInfo;
import com.app.service.board.GameBoardService;
import com.app.service.comment.CommentService;
import com.app.service.post.PostService;
import com.app.service.user.UserService;



@Controller
@RequestMapping("/board")
public class MypageController {
	
	UserService userService;
	
	@Autowired
	GameBoardService GameBoardService;
	
	@Autowired
	PostService postService;
	
	@Autowired
	CommentService commentService;
	
	public MypageController(UserService userService) {
	    this.userService = userService;
	}
	
	
	@GetMapping("/mypage")
	public String getMyPage(@RequestParam(value = "category", required = false, defaultValue = "ALL") String category, 
			HttpSession session, Model model) {

        Long loginUserId = (Long) session.getAttribute("LOGIN_USER_ID");

        if (loginUserId == null) {
            return "redirect:/main";
        }

        UserInfo myInfo = userService.getMyPageInfo(loginUserId);
        
        model.addAttribute("user", myInfo);
        
        List<Post> myPostList = postService.getPostByUid(loginUserId);
        
        model.addAttribute("myPostList", myPostList);
        
		
		  List<Comments> commentList = commentService.getCommentsByUid(loginUserId);
		  model.addAttribute("commentList", commentList);
		  
		  
		 List<Post> postList = postService.selectPostByLikeCount(loginUserId);
		 
		 model.addAttribute("postList", postList);
		 
		 Map<String, Object> profileImage = userService.getUserProfile(loginUserId);
	        model.addAttribute("profileImage", profileImage);
		 
	        return "/board/mypage";
    }
	
	@PostMapping("/mypage/update-password")
	public String updatePassword(UserInfo userInfo, HttpSession session) {
		
		Long userId = (Long) session.getAttribute("LOGIN_USER_ID");
	    if (userId == null) {
	        return "redirect:/main";
	    }
	    
	    userInfo.setUid(userId);
		
	
		
		System.out.println("변경된 비밀번호: " + userInfo.getPassword());
		
		userService.updatePassword(userInfo);
		
		return "redirect:/board/mypage";
	}
	
	@PostMapping("/mypage/update-nickname")
	public String updateNickname(UserInfo userInfo, HttpSession session) {
		
		Long userId = (Long) session.getAttribute("LOGIN_USER_ID");
	    if (userId == null) {
	        return "redirect:/main";
	    }
	    
	    userInfo.setUid(userId);
		
	
		
		System.out.println("변경된 닉네임: " + userInfo.getNickname());
		
		userService.updateNickname(userInfo);
		
		return "redirect:/board/mypage";
	}
	
	@PostMapping("/mypage/update-profile-img")
	public String updateProfileImg(@RequestParam("uploadFile") MultipartFile uploadFile,
	                               HttpSession session,
	                               HttpServletRequest request) {
	    
	    Long loginUserId = (Long) session.getAttribute("LOGIN_USER_ID");
	    if (loginUserId == null) {
	        return "redirect:/main";
	    }

	    // Service 계층의 프로필 업데이트 메서드 호출 (Long 타입 ID와 파일 전달)
	    userService.updateProfileImage(loginUserId, uploadFile, request);
	    
	    return "redirect:/board/mypage";
	}
}