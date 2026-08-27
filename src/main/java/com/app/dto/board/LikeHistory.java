package com.app.dto.board;

import lombok.Data;

@Data
public class LikeHistory {
    private Long likeId; // PK
    private Long pId; // FK , Post ,Null 허용
    private Long uId; // FK , User
    private Long cId; // FK , Comments , Null 허용
}
