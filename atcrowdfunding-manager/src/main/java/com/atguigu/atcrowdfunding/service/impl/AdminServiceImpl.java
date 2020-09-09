package com.atguigu.atcrowdfunding.service.impl;

import com.atguigu.atcrowdfunding.bean.TAdmin;
import com.atguigu.atcrowdfunding.bean.TAdminExample;
import com.atguigu.atcrowdfunding.dao.TAdminMapper;
import com.atguigu.atcrowdfunding.service.AdminService;
import com.atguigu.atcrowdfunding.util.Const;
import com.atguigu.atcrowdfunding.util.DateUtil;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Service
public class AdminServiceImpl implements AdminService {

    @Autowired
    private TAdminMapper tAdminMapper;

    @Override
    public PageInfo<TAdmin> queryAll(Map<String, Object> paramMap) {
        // 1、获取条件参数
        TAdminExample example = new TAdminExample();
        String condition = (String) paramMap.get("condition");
        // 2、如果条件为空则直接查询全部；
        //    如果筛选条件不为空，查询时要模糊查询：以or的关系分别匹配Loginacct和username和email字段
        if(!paramMap.isEmpty()){
            example.createCriteria().andLoginacctLike("%" + condition + "%");
            TAdminExample.Criteria criteria2 = example.createCriteria().andEmailLike("%" + condition + "%");
            TAdminExample.Criteria criteria3 = example.createCriteria().andUsernameLike("%" + condition + "%");
            example.or(criteria2);
            example.or(criteria3);
        }
        // 3、倒叙查询，方便在添加新的用户后，刷新页面时直接可以看到
        //    也可以在添加功能的Controller部分，添加新用户后，直接跳转最后一页
        example.setOrderByClause("createtime DESC");

        List<TAdmin> tAdmins = tAdminMapper.selectByExample(example);

        // 4、分页
        PageInfo<TAdmin> pageInfo = new PageInfo<>(tAdmins,5);

        return pageInfo;
    }

    @Override
    public void saveAdmin(TAdmin tAdmin) {
        //设置默认的密码和创建日期
        tAdmin.setUserpswd(Const.DEFALUT_PASSWORD);
        tAdmin.setCreatetime(DateUtil.getFormatTime());
        tAdminMapper.insertSelective(tAdmin);
    }

    @Override
    public TAdmin getAdminById(Integer id) {
        TAdmin admin = tAdminMapper.selectByPrimaryKey(id);
        return admin;
    }

    @Override
    public void updateAdmin(TAdmin admin) {
        tAdminMapper.updateByPrimaryKeySelective(admin);    //动态SQL  属性为null的属性不参与update语句。
    }

    @Override
    public void deleteAdmin(Integer id) {
        tAdminMapper.deleteByPrimaryKey(id);
    }

    @Override
    public void deleteBatchByIds(String id) {
        List<Integer> idList = new ArrayList<>();
        if(!id.isEmpty()){
            String[] split = id.split(",");
            for(int i = 0;i <split.length;i++){
                Integer value = Integer.parseInt(split[i]);
                idList.add(value);
            }
        }
        TAdminExample example = new TAdminExample();
        TAdminExample.Criteria criteria = example.createCriteria();
        criteria.andIdIn(idList);       //   delete from t_admin where id in (1,2,3,4,5)
        tAdminMapper.deleteByExample(example);
    }

}
