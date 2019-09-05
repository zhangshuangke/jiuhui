package com.bgs.boot0828;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
@MapperScan("com.bgs.boot0828.mapper")
public class Boot0828Application {

    public static void main(String[] args) {
        SpringApplication.run(Boot0828Application.class, args);
    }

}
