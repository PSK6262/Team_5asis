package com.app.dto.board;

import lombok.Data;

@Data
public class LikeHistory {
    private Long likeId; // PK
    private Long pid; // FK , Post ,Null 허용
    private Long uid; // FK , User
    private Long cid; // FK , Comments , Null 허용
}
