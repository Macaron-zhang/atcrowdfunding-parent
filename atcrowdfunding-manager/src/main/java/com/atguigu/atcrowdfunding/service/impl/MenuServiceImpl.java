package com.atguigu.atcrowdfunding.service.impl;

import com.atguigu.atcrowdfunding.bean.TAdmin;
import com.atguigu.atcrowdfunding.bean.TAdminExample;
import com.atguigu.atcrowdfunding.bean.TMenu;
import com.atguigu.atcrowdfunding.dao.TAdminMapper;
import com.atguigu.atcrowdfunding.dao.TMenuMapper;
import com.atguigu.atcrowdfunding.exception.LoginException;
import com.atguigu.atcrowdfunding.service.MenuService;
import com.atguigu.atcrowdfunding.util.Const;
import com.atguigu.atcrowdfunding.util.MD5Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class MenuServiceImpl implements MenuService {

    @Autowired
    private TAdminMapper tAdminMapper;

    @Autowired
    private TMenuMapper tMenuMapper;

    @Override
    public TAdmin getAdminByLogin(String loginacct, String userpswd) {
        TAdminExample example = new TAdminExample();
        example.createCriteria().andLoginacctEqualTo(loginacct);
        List<TAdmin> tAdmins = tAdminMapper.selectByExample(example);
        // 1、获取到这个未知的List后，先判断是否获取到用户，
        // 如果为null或者长度为0，则未无该用户的信息，抛出包含”用户名称不存在“的异常信息
        if(tAdmins == null || tAdmins.size()==0){
            throw new LoginException(Const.LOGIN_LOGINACCT_ERROR);
        }
        TAdmin tAdmin = tAdmins.get(0);
        // 2、如果存在改用户信息，则判断用户输入的密码是否正确
        // 将用户密码使用MD5加密后，与数据库的用户密码比对
        // 如果不正确，抛出包含”用户密码不正确“的异常信息
        if(!tAdmin.getUserpswd().equals(MD5Util.digest(userpswd))){
            throw new LoginException(Const.LOGIN_USERPSWD_ERROR);
        }
        // 3、如果上面两关都过了，说明用户登录信息正确，给Controller层返回用户信息
        return tAdmin;
    }

    @Override
    public List<TMenu> listAllMenu() {

        List<TMenu> tMenus = tMenuMapper.selectByExample(null);

        List<TMenu> parentMenu = new ArrayList<>();     //一个用来存父菜单的List，它包含子菜单List属性
        Map<Integer,TMenu> map = new HashMap<>();       //用来匹配父菜单的子菜单Map，Integer应该是父菜单的id，TMenu是父菜单

        for(TMenu menu:tMenus){
            if(menu.getPid()==0){
                parentMenu.add(menu);       //将父菜单从原始List分离出来，加入parentList
                map.put(menu.getId(),menu);     //以父菜单的Id号作为Key，父菜单自己作为Value
            }
        }

        for(TMenu menu:tMenus){
            if(menu.getPid()!=0){
                Integer id = menu.getPid();     //获取子菜单对应的父菜单id
                map.get(id).getChildren().add(menu);    //组合父子关系
            }
        }

        return parentMenu;      // 返回所有父，但是，每一个父都带着自己孩子返回
    }
}
