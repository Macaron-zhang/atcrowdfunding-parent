package com.atguigu.atcrowdfunding.start_listenter;

import com.atguigu.atcrowdfunding.util.Const;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

/**
 * 自定义监听器：希望在服务器启动时，将上下文路径存放点到application域中。
 * jsp页面可以使用el表达式获取使用。${PATH}
 */
public class StartListener implements ServletContextListener {
    @Override
    public void contextInitialized(ServletContextEvent servletContextEvent) {
        System.out.println("contextInitialized");
        ServletContext servletContext = servletContextEvent.getServletContext();
        String contextPath = servletContext.getContextPath();
        servletContext.setAttribute(Const.PATH,contextPath);
    }

    @Override
    public void contextDestroyed(ServletContextEvent servletContextEvent) {
        System.out.println("contextDestroyed");
    }
}
