package com.app.dto.board;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import lombok.Data;

@Data
public class Comments {
    private Long cid; // PK
    private String content;
    private Integer likeCount;
    private Long pid; // FK , Post
    private Long uid; // FK , User
    private Long parentCId; // NULL 허용
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt; // NULL 허용
    
    private String nickname; //닉네임
    
    private String gameAlias;
    
    private int viewCount;
    
    public String getCreatedAt() {
        if (this.createdAt == null) return null;
        return this.createdAt.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm"));
    }

    public String getUpdatedAt() {
        if (this.updatedAt == null) return null;
        return this.updatedAt.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm"));
    }
    
    
}

