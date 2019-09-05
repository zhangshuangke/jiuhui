package com.bgs.boot0828.service.impl;

import com.bgs.boot0828.mapper.UserMapper;
import com.bgs.boot0828.pojo.User;
import com.bgs.boot0828.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;


@Service
public class UserServiceImpl implements UserService {
    @Resource
    private UserMapper userMapper;


    @Override
    public User login(String usercode, String password) {
        return userMapper.login(usercode,password);
    }
}
