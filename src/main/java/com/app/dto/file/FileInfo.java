package com.app.dto.file;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class FileInfo {
    private Long mid;
    private String mediaUrl;
    private Integer mediaOrder;
    private Long pid;
    private String mediaType; // "IMAGE" 또는 "FILE"
}
