package org.js.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.js.bean.Role;

import java.util.List;


@Mapper
public interface RolesMapper {
    int addRoles(@Param("roles") String[] roles, @Param("uid") Long uid);

    List<Role> getRolesByUid(Long uid);
}
