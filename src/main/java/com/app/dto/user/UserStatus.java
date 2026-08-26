package com.app.dto.user;

import lombok.Data;

@Data
public class UserStatus {
    private Integer statusId; // PK
    private String type;
}
