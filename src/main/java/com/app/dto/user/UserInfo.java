package com.app.dto.user;

import java.time.LocalDateTime;
import lombok.Data;

@Data
public class UserInfo {
    private Long uId; // PK
    private String email; // UNIQUE , 중복불가
    private String password;
    private String nickname;
    private LocalDateTime createdAt;
    private Integer status; // FK , UserStatus
    private String profileImageUrl; // NULL 허용
}
