package com.atguigu.atcrowdfunding.service.impl;

import com.atguigu.atcrowdfunding.bean.TRole;
import com.atguigu.atcrowdfunding.bean.TRoleExample;
import com.atguigu.atcrowdfunding.dao.TRoleMapper;
import com.atguigu.atcrowdfunding.service.RoleService;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.management.relation.Role;
import java.util.List;
import java.util.Map;

@Service
public class RoleServiceImpl implements RoleService {

    @Autowired
    TRoleMapper tRoleMapper;


    @Override
    public void deleteRoleById(Integer id) {
        tRoleMapper.deleteByPrimaryKey(id);
    }

    @Override
    public PageInfo<TRole> queryAll(Map<String,Object> params) {
        TRoleExample tRoleExample = new TRoleExample();
        String  condition = (String) params.get("condition");
        if(!params.isEmpty()){
            tRoleExample.createCriteria().andNameLike("%"+condition+"%");
        }
//        tRoleExample.setOrderByClause("id DESC");
        List<TRole> tRoles = tRoleMapper.selectByExample(tRoleExample);
        PageInfo<TRole> tRolePageInfo = new PageInfo<>(tRoles, 5);
        return tRolePageInfo;
    }

    @Override
    public void saveRole(TRole role) {
        tRoleMapper.insertSelective(role);
    }

    @Override
    public void updateRoleById(TRole tRole) {
        tRoleMapper.updateByPrimaryKeySelective(tRole);
    }
}
