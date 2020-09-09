package com.atguigu.atcrowdfunding.controller;


import com.atguigu.atcrowdfunding.bean.TAdmin;
import com.atguigu.atcrowdfunding.service.AdminService;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class AdminController {

    @Autowired
    private AdminService adminService;

    @RequestMapping("/admin/deleteBatchAdmin")
    public String deleteBatchAdmin(String id,Integer pageNum,String condition){
        adminService.deleteBatchByIds(id);
        return "redirect:/admin/index?pageNum="+pageNum+"&condition="+condition;
    }

    @RequestMapping("/admin/deleteAdmin")
    public String deleteAdmin(Integer id,Integer pageNum,String condition){
        adminService.deleteAdmin(id);
        return "redirect:/admin/index?pageNum="+pageNum+"&condition="+condition;
    }


    @RequestMapping("/admin/updateAdmin")
    public String Update(Integer pageNum,TAdmin admin){
        System.out.println(admin);
        adminService.updateAdmin(admin);
        return "redirect:/admin/index?pageNum="+pageNum;
    }


    @RequestMapping("/admin/toUpdate")
    public String toUpdate(Integer id,Model model){
        TAdmin admin = adminService.getAdminById(id);
//        System.out.println(admin);
        model.addAttribute("admin",admin);
        return "admin/update";
    }

    @RequestMapping("/admin/saveAdmin")
    public String saveAdmin(TAdmin tAdmin){
        adminService.saveAdmin(tAdmin);
        //return "redirect:/admin/index?pageNum="+Integer.MAX_VALUE; //根据分页合理化，当跳转一个不存在的页时，会自动去到最后一页
        return "redirect:/admin/index";
    }

    @RequestMapping("/admin/toAdd")
    public String toAdd(){
        System.out.println("跳转新增页面");
        return "admin/add";
    }

    @RequestMapping("/admin/index")
    public String queryAll(@RequestParam(value = "pageNum",required = false,defaultValue = "1") Integer pageNum,
                           @RequestParam(value = "pageSize",required = false,defaultValue = "2") Integer pageSize,
                           @RequestParam(value = "condition",required = false,defaultValue = "") String condition,
                           Model model){
        // 1、开启分页功能
        // 注意参数传递： 将数据通过ThreadLocal绑定到当前线程上，传递给后续流程（dao）使用。
        PageHelper.startPage(pageNum, pageSize);

        // 2、防止查询条件，为了方便以后多条件筛选，所以使用Map来装筛选条件
        Map<String,Object> paramMap = new HashMap<>();
        paramMap.put("condition",condition);

        // 3、调用Service服务，查询所有用户信息
        PageInfo<TAdmin> pageInfo = adminService.queryAll(paramMap);

        // 4、将分页类对象放入Request域，方便转发页面使用数据
        model.addAttribute("pageInfo",pageInfo);
        return "admin/index";
    }
}
