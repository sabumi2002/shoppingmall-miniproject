package com.bit.spring.controller;

import com.bit.spring.model.CategoryDTO;
import com.bit.spring.model.UserDTO;
import com.bit.spring.service.AddressService;
import com.bit.spring.service.CategoryService;
import com.bit.spring.service.UserService;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.PrintWriter;
import java.util.List;

@Controller
public class HomeController {

    private CategoryService categoryService;
    public HomeController(CategoryService categoryService) {
        this.categoryService = categoryService;
    }

    @RequestMapping("/")
    public String showIndex(HttpSession session, Model model){

        return "index";
//        return "redirect:/mypage/showBasket";
    }

    @GetMapping("/nav")
    @ResponseBody
    public JsonObject nav(){
        JsonObject result = new JsonObject();

        List<CategoryDTO> categoryList = categoryService.selectAll();

        JsonArray categoryArray = new JsonArray();

        for(CategoryDTO c : categoryList) {
            JsonObject object = new JsonObject();
            object.addProperty("id", c.getId());
            object.addProperty("category", c.getCategory());

            categoryArray.add(object);
        }
        try{
            result.addProperty("result", "success");
            result.addProperty("categoryList", categoryArray.toString());

        }catch (Exception e){
            result.addProperty("result", "fail");
        }

        return result;
    }


}
