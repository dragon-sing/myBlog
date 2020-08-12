package org.js.service;

import org.js.bean.Category;
import org.js.mapper.CategoryMapper;
import org.js.utils.Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.sql.Timestamp;
import java.util.List;

/**
 * 文集的处理函数
 */
@Service
@Transactional
public class CategoryService {
    @Autowired
    CategoryMapper categoryMapper;

    public List<Category> getAllCategories() {

        return categoryMapper.getAllCategories(Util.getCurrentUser().getId());
    }

    public boolean deleteCategoryByIds(String ids) {
        String[] split = ids.split(",");
        int result = categoryMapper.deleteCategoryByIds(split);
        return result == split.length;
    }

    public int updateCategoryById(Category category) {
        return categoryMapper.updateCategoryById(category);
    }

    public int addCategory(Category category) {
        category.setDate(new Timestamp(System.currentTimeMillis()));
        category.setUid(Util.getCurrentUser().getId());
        return categoryMapper.addCategory(category);
    }
}
