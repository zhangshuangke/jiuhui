package com.bgs.boot0828.service;

import com.bgs.boot0828.pojo.User;

public interface UserService {
    User login(String usercode, String password);
}
