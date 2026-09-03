package com.app.dao.file.impl;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.app.dao.file.FileDAO;
import com.app.dto.file.FileInfo;

@Repository
public class FileDAOImpl implements FileDAO {
	
	@Autowired
    private SqlSessionTemplate sql;

    private final String NAMESPACE = "FileMapper.";

    @Override
    public int insertFile(FileInfo fileInfo) {
        return sql.insert(NAMESPACE + "insertFile", fileInfo);
    }

    @Override
    public List<FileInfo> selectFilesByPid(Long pId) {
        return sql.selectList(NAMESPACE + "selectFilesByPid", pId);
    }

    @Override
    public int deleteFileByMid(Long mId) {
        return sql.delete(NAMESPACE + "deleteFileByMid", mId);
    }

    @Override
    public int deleteFilesByPid(Long pId) {
        return sql.delete(NAMESPACE + "deleteFilesByPid", pId);
    }

}
