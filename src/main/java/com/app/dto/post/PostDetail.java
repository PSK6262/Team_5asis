package com.app.dto.post;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
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
    
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt; // NULL 허용
    
    public String getCreatedAt() {
        if (this.createdAt == null) return null;
        return this.createdAt.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm"));
    }

    public String getUpdatedAt() {
        if (this.updatedAt == null) return null;
        return this.updatedAt.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm"));
    }
    
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
