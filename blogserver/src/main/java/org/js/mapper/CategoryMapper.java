package org.js.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.js.bean.Category;

import java.util.List;


@Mapper
public interface CategoryMapper {
    List<Category> getAllCategories(Long Id);

    int deleteCategoryByIds(@Param("ids") String[] ids);

    int updateCategoryById(Category category);

    int addCategory(Category category);
}
