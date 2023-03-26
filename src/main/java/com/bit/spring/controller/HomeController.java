package com.bit.spring.controller;

import com.bit.spring.model.CategoryDTO;
import com.bit.spring.service.AddressService;
import com.bit.spring.service.CategoryService;
import com.bit.spring.service.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class HomeController {

    private CategoryService categoryService;
    public HomeController(CategoryService categoryService) {
        this.categoryService = categoryService;
    }

    @RequestMapping("/")
    public String showIndex(HttpSession session, Model model){
        List<CategoryDTO> categoryList = categoryService.selectAll();
        session.setAttribute("categoryList", categoryList);

//        return "index";
        return "redirect:/shop/write";
    }


}
