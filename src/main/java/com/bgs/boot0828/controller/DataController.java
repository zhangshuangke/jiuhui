package com.bgs.boot0828.controller;

import com.bgs.boot0828.pojo.ActiveData;
import com.bgs.boot0828.pojo.Forecast;
import com.bgs.boot0828.pojo.Gallery;
import com.bgs.boot0828.pojo.User;
import com.bgs.boot0828.service.DataService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("data")
public class DataController {
    @Autowired
    private DataService dataService;
    @Value("${path}")
    private String path;

    @RequestMapping("addPlan")
    @ResponseBody
    public int addPlan(Forecast forecast){
        return dataService.addPlan(forecast);
    }

    @RequestMapping("findPlanAll")
    @ResponseBody
    public List<Forecast> findPlanAll(){
        return dataService.findPlanAll();
    }

    @RequestMapping("addActiveData")
    @ResponseBody
    public int addActiveData(ActiveData activeData,HttpSession session){

        int i= dataService.addActiveData(activeData);
        if(i>0){
            session.setAttribute("activeId",activeData.getId());
        }
        return i;
    }

    @RequestMapping("addPicture")
    @ResponseBody
    public Map<String,Object> addPicture(MultipartFile goodsImg, HttpSession session) throws IOException {

        Map<String, Object> map = new HashMap<>();
        User user = (User) session.getAttribute("user");
        Integer activeId=(Integer)session.getAttribute("activeId");
        if (user != null) {
            String fileName = String.valueOf(System.currentTimeMillis());
            String target = path+File.separator+"active" +File.separator+fileName + ".jpg";
            Gallery gallery=new Gallery();
            gallery.setActiveId(activeId);
            gallery.setName(fileName);
            gallery.setUrl(path+File.separator+"active" +File.separator);
            File temp = new File(target);
            //把图片写入磁盘中
            goodsImg.transferTo(temp);
            int i = dataService.addPicture(gallery);
            if (i > 0) {
                map.put("state", true);
                map.put("Image", fileName);
            } else {
                map.put("state", false);
            }
        } else {
            map.put("state", false);
        }
        return map;
    }
}
