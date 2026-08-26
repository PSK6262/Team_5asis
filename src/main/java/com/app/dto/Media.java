package com.app.dto;

import lombok.Data;

@Data
public class Media {
    private String mediaUrl; // PK
    private Integer mediaOrder;
    private Long pId; // FK , Post
    private String mediaType;
}
