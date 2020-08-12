package org.js.controller;


import org.apache.ibatis.annotations.Param;
import org.js.bean.Category;
import org.js.bean.Comment;
import org.js.bean.RespBean;
import org.js.service.CommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/comment")
public class CommentController {

    @Autowired
    CommentService commentService;

    @RequestMapping(value = "/{aid}", method = RequestMethod.GET)
    public List<Comment> getCommentByArticleId(@PathVariable Long aid) {
        List<Comment> comments = commentService.getCommentByArticleId(aid);
        return comments;
    }

    @RequestMapping(value = "/", method = RequestMethod.POST)
    public RespBean addComment(Comment comment) {
        int result = commentService.addComment(comment);
        if (result == 1) {
            return new RespBean("success", "添加成功!");
        }
        return new RespBean("error", "添加失败!");
    }

}
