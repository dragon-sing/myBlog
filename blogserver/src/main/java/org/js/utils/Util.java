package org.js.utils;

import org.js.bean.User;
import org.springframework.security.core.context.SecurityContextHolder;

/**
 * 得到当前的用户
 */
public class Util {
    public static User getCurrentUser() {
        User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        return user;
    }
}
