package com.app.dto.board;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import lombok.Data;

@Data
public class Post {
    private Long pid; // PK
    private String title;
    private String content;
    private Long uid; // FK , UserInfo
    private Integer likeCount;
    private String category;
    private Long gameId;
    private Integer viewCount;
    
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt; // NULL 허용
    
    public String getCreatedAt() {
        if (this.createdAt == null) return null;
        return this.createdAt.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
    }

    public String getUpdatedAt() {
        if (this.updatedAt == null) return null;
        return this.updatedAt.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
    }
    
    // JOIN용
    private String nickname;
    private String gameName;
    private String gameAlias;
    private String chzzkGameName;
    // join이나 , select시 , 5개를 가져왔다면 5개가 1,2,3,4,5와 같이 순서로 나타나게
    private Long rownum; 
}
