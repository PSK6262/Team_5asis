package com.app.service.file;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.app.dto.file.FileInfo;

public interface FileService {
	
	// 다중 파일 업로드 및 DB 저장
    List<FileInfo> uploadFiles(List<MultipartFile> files, Long pId, String mediaType, String uploadPath);
    
    // 게시글 첨부파일 목록 조회
    List<FileInfo> getFilesByPid(Long pId);
    
    // 파일 삭제
    boolean deleteFile(Long mId, String uploadPath);

}
