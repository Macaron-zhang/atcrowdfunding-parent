package com.atguigu.atcrowdfunding.service;

import com.atguigu.atcrowdfunding.bean.TRole;
import com.github.pagehelper.PageInfo;

import java.util.List;
import java.util.Map;

public interface RoleService {

    PageInfo<TRole> queryAll(Map<String,Object> params);

    void saveRole(TRole role);


    void updateRoleById(TRole tRole);

    void deleteRoleById(Integer id);
}
