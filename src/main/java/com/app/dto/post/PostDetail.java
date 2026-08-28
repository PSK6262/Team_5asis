package com.app.dto.post;

import java.sql.Timestamp;
import java.util.List;

import com.app.dto.board.Comments;
import com.app.dto.board.Media;

import lombok.Data;

@Data
public class PostDetail {
	// 게시글 정보
    private Long pid;
    private String title;
    private String content;
    private String category;
    private Long likeCount;
    private Long viewCount;
    private Timestamp createdAt;
    private Timestamp updatedAt;
    
    // 작성자 정보
    private Long uid;
    private String nickname;
    
    // 게임 정보 (NULL 가능)
    private Long gameId;
    private String gameName;
    
    // 연관 목록
    private List<Media> mediaList;
    private List<Comments> commentList;
	

}
