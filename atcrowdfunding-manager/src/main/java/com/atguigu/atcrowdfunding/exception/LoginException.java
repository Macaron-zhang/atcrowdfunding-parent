package com.atguigu.atcrowdfunding.exception;

/**
 * 自定义：登录异常类
 */
public class LoginException extends RuntimeException {
    public LoginException(){}
    public LoginException(String msg){
        super(msg);
    }
}
