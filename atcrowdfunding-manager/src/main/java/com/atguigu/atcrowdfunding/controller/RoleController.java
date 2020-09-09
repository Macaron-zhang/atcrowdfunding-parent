package com.atguigu.atcrowdfunding.controller;

import com.atguigu.atcrowdfunding.bean.TRole;
import com.atguigu.atcrowdfunding.service.RoleService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

//角色控制Controller
@Controller
public class RoleController {

    @Autowired
    RoleService roleService;

    @ResponseBody
    @RequestMapping("/role/deleteRoleById")
    public String deleteRoleById(Integer id){
        roleService.deleteRoleById(id);
        return "ok";
    }

    @ResponseBody
    @RequestMapping("/role/updateRoleById")
    public String updateRoleById(TRole tRole){
        roleService.updateRoleById(tRole);
        return "ok";
    }

    @ResponseBody
    @RequestMapping("/role/addRole")
    public String saveRole(TRole role){
        roleService.saveRole(role);
        return "ok";
    }


    @RequestMapping("/role/index")
    public String loadIndex(){

        return "role/index";
    }


    //异步查询数据
    @ResponseBody
    @RequestMapping("/role/loadData")
    public PageInfo<TRole> queryAll(@RequestParam(value = "pageNum",required = false,defaultValue = "1") Integer pageNum,
                           @RequestParam(value = "pageSize",required = false,defaultValue = "2") Integer pageSize,
                           @RequestParam(value = "condition",required = false,defaultValue = "") String condition){
        //通过ThreadLocal将数据绑定到当前线程上
        PageHelper.startPage(pageNum,pageSize);
        Map<String,Object> params = new HashMap<>();
        params.put("condition",condition.trim());
        PageInfo<TRole> t_role =  roleService.queryAll(params);
//        md.addAttribute("result",t_role);
        return t_role;      //直接将数据返回，通过消息转换器生成json串
    }

}
