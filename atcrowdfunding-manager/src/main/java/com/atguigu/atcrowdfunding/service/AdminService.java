package com.atguigu.atcrowdfunding.service;

import com.atguigu.atcrowdfunding.bean.TAdmin;
import com.github.pagehelper.PageInfo;

import java.util.Map;

public interface AdminService {

    PageInfo<TAdmin> queryAll(Map<String, Object> paramMap);

    void saveAdmin(TAdmin tAdmin);

    TAdmin getAdminById(Integer id);

    void updateAdmin(TAdmin admin);

    void deleteAdmin(Integer id);

    void deleteBatchByIds(String id);
}
