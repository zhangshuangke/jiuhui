package com.bgs.boot0828.mapper;

import com.bgs.boot0828.pojo.User;
import org.apache.ibatis.annotations.Param;

public interface UserMapper {
    User login(@Param("usercode") String usercode,@Param("password") String password);
}
