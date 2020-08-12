package org.js.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.js.bean.Comment;

import java.util.List;

@Mapper
public interface CommentMapper {

    List<Comment> getCommentByArticleId(Long Aid);

    int addComment(Comment category);
}
