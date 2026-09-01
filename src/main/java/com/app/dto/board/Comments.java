package com.app.dto.board;

import java.time.LocalDateTime;
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
    
    
}

