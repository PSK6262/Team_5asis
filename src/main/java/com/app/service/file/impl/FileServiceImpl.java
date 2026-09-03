package com.app.service.file.impl;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.app.dao.file.FileDAO;
import com.app.dto.file.FileInfo;
import com.app.service.file.FileService;

@Service
public class FileServiceImpl implements FileService {

    @Autowired
    private FileDAO fileDAO;

    @Override
    public List<FileInfo> uploadFiles(List<MultipartFile> files, Long pId, String mediaType, String realUploadPath) {
        List<FileInfo> resultList = new ArrayList<>();

        if (files == null || files.isEmpty()) {
            return resultList;
        }

        File saveDir = new File(realUploadPath);
        if (!saveDir.exists()) {
            saveDir.mkdirs();
        }

        int order = 1;
        for (MultipartFile file : files) {
            if (file.isEmpty()) continue;

            // 파일명 중복 방지를 위해 UUID 적용
            String originalFilename = file.getOriginalFilename();
            String uuidStr = UUID.randomUUID().toString();
            String savedFilename = uuidStr + "_" + originalFilename;

            File dest = new File(saveDir, savedFilename);

            try {
                // 1. 물리 파일 저장
                file.transferTo(dest);
                System.out.println(">>> 물리 파일 저장 성공: " + dest.getAbsolutePath());

                // 2. DB 저장을 위한 DTO 생성 (웹 접근 경로를 /resources/upload/ 로 변경)
                String webUrl = "/resources/upload/" + savedFilename;

                FileInfo fileInfo = FileInfo.builder()
                        .mediaUrl(webUrl)
                        .mediaOrder(order++)
                        .pid(pId)
                        .mediaType(mediaType)
                        .build();

                // 3. DB 저장
                fileDAO.insertFile(fileInfo);
                resultList.add(fileInfo);
                System.out.println(">>> DB Insert 성공: " + fileInfo.getMediaUrl());

            } catch (Exception e) {
                // Exception으로 변경하여 DB SQL 에러까지 모두 디버깅 콘솔에 출력
                System.err.println(">>> 파일 업로드/DB 저장 중 예외 발생!");
                e.printStackTrace();
            }
        }

        return resultList;
    }

    @Override
    public List<FileInfo> getFilesByPid(Long pId) {
        return fileDAO.selectFilesByPid(pId);
    }

    @Override
    public boolean deleteFile(Long mId, String realUploadPath) {
        return fileDAO.deleteFileByMid(mId) > 0;
    }
}