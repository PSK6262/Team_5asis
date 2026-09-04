package com.app.controller.board;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
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
import org.springframework.web.multipart.MultipartFile;

import com.app.dto.board.GameNameTransferForm;
import com.app.dto.board.Post;
import com.app.dto.file.FileInfo;
import com.app.dto.post.PostDetail;
import com.app.dto.user.UserInfo;
import com.app.service.board.GameBoardService;
import com.app.service.file.FileService;
import com.app.service.post.PostService;
import com.app.service.user.UserService;

@Controller
@RequestMapping("/board")
public class PostController {

	@Autowired
	private PostService postService;

	@Autowired
	private FileService fileService;

	@Autowired
	private GameBoardService gameBoardService;

	@Autowired
	private UserService userService;


	///사이드바에 필요한 games, nickname, profileImage가 Model에 자동으로 추가

	@ModelAttribute
	public void addSidebarAttributes(Model model, HttpSession session) {
	    // 1. 전체 게임 목록
	    List<GameNameTransferForm> allGames = gameBoardService.findAllGames();
	    model.addAttribute("games", allGames);

	    // 2. 로그인 사용자 프로필 정보
	    UserInfo loginUser = (UserInfo) session.getAttribute("LOGIN_USER");
	    Long loginUserId = (Long) session.getAttribute("LOGIN_USER_ID");

	    if (loginUser != null && loginUserId != null) {
	        Map<String, Object> profileImage = userService.getUserProfile(loginUserId);
	        model.addAttribute("loginUser", loginUser);
	        model.addAttribute("nickname", loginUser.getNickname());
	        model.addAttribute("profileImage", profileImage);
	    } else {
	        // 비로그인 Guest 상태: Map 형태로 맞추어 JSP에서 URL_FILE_PATH 키로 접근 가능하게 설정
	        Map<String, Object> guestProfile = new HashMap<>();
	        guestProfile.put("URL_FILE_PATH", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRhhyGGwgPL45lqvy3D15y74Heh7azl2cOLI7CPnHb6jw&s=10");

	        model.addAttribute("nickname", "Guest");
	        model.addAttribute("profileImage", guestProfile);
	    }
	}

	// 게시글 작성 페이지 (/board/lol/write)
	@GetMapping("/{gameAlias}/write")
	public String writeForm(@PathVariable("gameAlias") String gameAlias, Model model, HttpSession session) {

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
	public String writePost(@PathVariable("gameAlias") String gameAlias, Post post,
			@RequestParam(value = "attachedFiles", required = false) List<MultipartFile> attachedFiles,
			HttpServletRequest request, HttpSession session) {

		// 디버깅용: 파일 수신 여부 로그 확인
		if (attachedFiles != null) {
			System.out.println("업로드된 파일 개수: " + attachedFiles.size());
			for (MultipartFile file : attachedFiles) {
				System.out.println("파일명: " + file.getOriginalFilename() + " / 크기: " + file.getSize());
			}
		} else {
			System.out.println("attachedFiles가 null입니다.");
		}

		UserInfo loginUser = (UserInfo) session.getAttribute("LOGIN_USER");
		if (loginUser == null) {
			return "redirect:/user/login";
		}

		post.setUid(loginUser.getUid());

		// 1. 게시글 DB 저장
		postService.insertPost(post, gameAlias);
		Long pId = post.getPid();

		// 2. 일반 첨부파일 업로드 처리
		if (attachedFiles != null && !attachedFiles.isEmpty()) {
			String realPath = request.getServletContext().getRealPath("/resources/upload");
			fileService.uploadFiles(attachedFiles, pId, "FILE", realPath);
		}

		return "redirect:/board/" + gameAlias + "/" + pId;
	}

	// 게시글 상세 조회 (/board/lol/5)
	@GetMapping("/{gameAlias}/{pId}")
	public String postDetail(@PathVariable("gameAlias") String gameAlias, @PathVariable("pId") Long pId, Model model,
			HttpSession session) {

		if ("all".equals(gameAlias)) {
			gameAlias = postService.findGameAliasByPostId(pId);
			return "redirect:/board/" + gameAlias + "/" + pId;
		}

		// 1. 게시글 상세 데이터 조회
		PostDetail postDetail = postService.getPostDetail(pId, gameAlias);

		if (postDetail == null) {
			return "redirect:/main";
		}

		// 2. 해당 게시글의 첨부파일 목록 DB 조회
		List<FileInfo> fileList = fileService.getFilesByPid(pId);

		// 3. 조회수 1 증가
		postService.increaseViewCount(pId);

		// 4. 현재 로그인 사용자 추천 여부 확인
		UserInfo loginUser = (UserInfo) session.getAttribute("LOGIN_USER");
		boolean isLiked = false;
		if (loginUser != null) {
			isLiked = postService.isLiked(pId, loginUser.getUid());
		}

		model.addAttribute("post", postDetail);
		model.addAttribute("gameAlias", gameAlias);
		model.addAttribute("isLiked", isLiked);
		model.addAttribute("fileList", fileList);

		return "post/post-detail";
	}

	// 게시글 수정 페이지 GET
	@GetMapping("/{gameAlias}/{pId}/edit")
	public String editForm(@PathVariable("gameAlias") String gameAlias, @PathVariable("pId") Long pId, Model model,
			HttpSession session) {

		UserInfo loginUser = (UserInfo) session.getAttribute("LOGIN_USER");
		if (loginUser == null) {
			return "redirect:/user/login";
		}

		PostDetail post = postService.getPostDetail(pId, gameAlias);

		if (post == null) {
			return "redirect:/main";
		}

		if (!loginUser.getUid().equals(post.getUid())) {
			return "redirect:/board/" + gameAlias + "/" + pId;
		}

		// 기존에 등록되어 있는 첨부파일 목록 조회 후 전달
		List<FileInfo> existingFiles = fileService.getFilesByPid(pId);
		model.addAttribute("existingFiles", existingFiles);

		model.addAttribute("post", post);
		model.addAttribute("gameAlias", gameAlias);
		model.addAttribute("isEdit", true);

		return "post/post-form";
	}

	// 게시글 수정 POST
	@PostMapping("/{gameAlias}/{pId}/edit")
	public String editPost(@PathVariable("gameAlias") String gameAlias, @PathVariable("pId") Long pId,
			@RequestParam("title") String title, @RequestParam("content") String content,
			@RequestParam("category") String category,
			@RequestParam(value = "attachedFiles", required = false) List<MultipartFile> attachedFiles,
			@RequestParam(value = "deleteFileMids", required = false) List<Long> deleteFileMids,
			HttpServletRequest request, HttpSession session) {

		UserInfo loginUser = (UserInfo) session.getAttribute("LOGIN_USER");
		if (loginUser == null) {
			return "redirect:/user/login";
		}

		// 1. 게시글 텍스트 수정
		postService.updatePost(pId, loginUser.getUid(), title, content, category);

		String realPath = request.getServletContext().getRealPath("/resources/upload");

		// 2. 삭제 체크한 기존 파일 DB 삭제
		if (deleteFileMids != null && !deleteFileMids.isEmpty()) {
			for (Long mId : deleteFileMids) {
				fileService.deleteFile(mId, realPath);
			}
		}

		// 3. 수정 시 새로 첨부한 파일 업로드 처리
		if (attachedFiles != null && !attachedFiles.isEmpty()) {
			boolean hasValidFile = attachedFiles.stream().anyMatch(f -> !f.isEmpty());
			if (hasValidFile) {
				fileService.uploadFiles(attachedFiles, pId, "FILE", realPath);
			}
		}

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
	public Map<String, Object> likePost(@PathVariable Long pId, HttpSession session) {

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