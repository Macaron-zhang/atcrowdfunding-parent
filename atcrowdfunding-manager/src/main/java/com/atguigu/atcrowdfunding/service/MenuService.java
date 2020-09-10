package com.atguigu.atcrowdfunding.service;

import com.atguigu.atcrowdfunding.bean.TAdmin;
import com.atguigu.atcrowdfunding.bean.TMenu;

import java.util.List;


public interface MenuService {

//    根据用户名和用户密码获取用户
    TAdmin getAdminByLogin(String loginacct,String userpswd);

    List<TMenu> listAllMenu();

    //不分子父节点
    List<TMenu> loadTree();
}
