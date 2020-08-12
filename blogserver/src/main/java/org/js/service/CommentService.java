package org.js.service;

import org.js.bean.Category;
import org.js.bean.Comment;
import org.js.mapper.CommentMapper;
import org.js.utils.Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.sql.Timestamp;
import java.util.List;

@Service
@Transactional
public class CommentService {
    @Autowired
    CommentMapper commentMapper;

    public List<Comment> getCommentByArticleId(Long id){

        return commentMapper.getCommentByArticleId(id);
    }

    public int addComment(Comment comment) {
        comment.setPublishDate(new Timestamp(System.currentTimeMillis()));
        comment.setUid(Util.getCurrentUser().getId());
        return commentMapper.addComment(comment);
    }


}
