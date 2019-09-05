package com.bgs.boot0828.controller;

import com.bgs.boot0828.pojo.User;
import com.bgs.boot0828.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;


@Controller
@RequestMapping("user")
public class UserController {
    @Autowired
    private UserService userService;

    //登录
    @RequestMapping("login")
    @ResponseBody
    public Map<String,Object> login(String usercode, String password, HttpSession session){
        //获取session中的验证码
        //String verCode=(String) session.getAttribute("verCode");
        Map<String,Object> map=new HashMap<String,Object>();
        User user=userService.login(usercode,password);

        if(user!=null) {
                session.setAttribute("user", user);
                map.put("flag", true);
        }else{
            map.put("flag", false);
            map.put("msg","用户名不存在或密码错误!");
        }
        return map;
    }

    @RequestMapping("logout")
    public String logout(HttpSession session) {

        session.removeAttribute("user");
        session.invalidate();
        return "redirect:/jsps/login.jsp";
    }


}
