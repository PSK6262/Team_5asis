package com.app.dto.board;

import java.time.LocalDateTime;
import lombok.Data;

@Data
public class Post {
    private Long pid; // PK
    private String title;
    private String content;
    private Long uId; // FK , UserInfo
    private Integer likeCount;
    private String category;
    private Long gameId;
    private Integer viewCount;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt; // NULL 허용
}
