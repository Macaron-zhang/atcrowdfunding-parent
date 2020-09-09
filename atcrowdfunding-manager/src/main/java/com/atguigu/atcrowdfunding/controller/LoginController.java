package com.atguigu.atcrowdfunding.controller;


import com.atguigu.atcrowdfunding.bean.TAdmin;
import com.atguigu.atcrowdfunding.bean.TMenu;
import com.atguigu.atcrowdfunding.exception.LoginException;
import com.atguigu.atcrowdfunding.service.MenuService;
import com.atguigu.atcrowdfunding.util.Const;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;

import java.util.List;


@Controller
public class LoginController {
    @Autowired
    private MenuService menuService;

    @RequestMapping("/logout")
    public String logout(HttpSession session){
        if(session != null){
            session.invalidate();   //清空Session内的数据
        }
        return "redirect:/login.jsp";       //回到登陆页面
    }

    @RequestMapping("/main")
    public String main(HttpSession session){
        System.out.println("你来到main.jsp了");
        //加载数据库中菜单表数据，在成功页面上动态显示菜单
        //暂时不考虑不同用户对菜单拥有的不同权限，直接查询所有菜单。
        //集合中存放是所有的父菜单
        //由于在显示父时候，还需要显示子菜单？在父菜单对象中增加一个孩子集合属性，来存储父的孩子

    //优化：这个获取的意义在于：一旦一个用户登陆后，它的权限是不变的，所以菜单不需要每次加载main页面请求的时候都查一次数据库，所以进行判断
        List<TMenu> menuList = (List<TMenu>) session.getAttribute("menuList");
        //如果是第一次登陆，则就行菜单的查询和回显
        //注意：应该放到Session域，而不是request域里，因为菜单是个多次出现的公共部件，Session域更合适
        if(menuList==null){
            List<TMenu> allMenu= menuService.listAllMenu();
            System.out.println(allMenu);
            session.setAttribute("menuList",allMenu);
        }
        return "main";  //视图解析，转发
    }


    @RequestMapping("/login")
    public String login(String loginacct, String userpswd, HttpSession session, Model md){
        try {
            //1、如果被调用的Service没有给它抛异常，或者服务本身未报错，则说明登录的用户存在
            //2、将它放入Session域中，方便跳转页面使用
            TAdmin adminByLogin = menuService.getAdminByLogin(loginacct, userpswd);
            session.setAttribute(Const.LOGIN_ADMIN,adminByLogin);
            //return "main"; //视图解析，转发  ; 问题：表单重复提交，重复登录系统
            //return "forward:/main"; //直接转发，不用拼前缀，后缀
            return "redirect:main";     //重定向是为了解决表单重复提交的问题
        } catch (LoginException e) {
            e.printStackTrace();
            md.addAttribute("excMsg",e.getMessage());
            return "forward:/login.jsp";
        }catch (Exception e) {
            e.printStackTrace();
            md.addAttribute("excMsg","系统出现问题,请稍后再试");
            return "forward:/login.jsp";
        }
    }
}
