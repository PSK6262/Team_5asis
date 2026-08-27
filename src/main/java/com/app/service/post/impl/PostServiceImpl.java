package com.app.service.post.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.app.dao.post.PostDAO;
import com.app.dto.board.Comments;
import com.app.dto.board.Media;
import com.app.dto.post.PostDetail;
import com.app.service.post.PostService;

@Service
public class PostServiceImpl implements PostService {

    @Autowired
    private PostDAO postDAO;

    @Override
    public void increaseViewCount(Long pId) {
    	postDAO.updateViewCount(pId);
    }

    @Override
    public PostDetail getPostDetail(Long pId) {
        PostDetail postDetail = postDAO.selectPostDetail(pId);

        if (postDetail != null) {
            List<Media> mediaList = postDAO.selectMediaListByPId(pId);
            postDetail.setMediaList(mediaList);

            List<Comments> commentList = postDAO.selectCommentListByPId(pId);
            postDetail.setCommentList(commentList);
        }

        return postDetail;
    }
}
