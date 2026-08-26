package com.app.dto.board;

import java.time.LocalDateTime;
import lombok.Data;

@Data
public class Comments {
    private Long cId; // PK
    private String content;
    private Integer likeCount;
    private Long pId; // FK , Post
    private Long uId; // FK , User
    private Long parentCId; // NULL 허용
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt; // NULL 허용
}

