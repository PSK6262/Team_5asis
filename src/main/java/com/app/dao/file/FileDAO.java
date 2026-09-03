package com.app.dao.file;

import java.util.List;

import com.app.dto.file.FileInfo;

public interface FileDAO {
	
	int insertFile(FileInfo fileInfo);
    List<FileInfo> selectFilesByPid(Long pId);
    int deleteFileByMid(Long mId);
    int deleteFilesByPid(Long pId);

}
