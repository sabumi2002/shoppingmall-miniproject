package com.bit.spring.controller;

import com.bit.spring.model.UserDTO;
import com.bit.spring.service.*;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/mypage")
public class MyPageController {
    private UserService userService;
    public MyPageController(UserService userService) {
        this.userService = userService;
    }

    @RequestMapping("/showMypage")
    public String showMypage(HttpSession session, Model model) {
        UserDTO logIn = (UserDTO) session.getAttribute("logIn");

//        List<ProductDTO> productList = productService.selectAll();

        model.addAttribute("logIn", logIn);
//        model.addAttribute("productList", productList);
        return "mypage/mypage";
    }

    @RequestMapping("/showBasket")
    public String showBasket(HttpSession session, Model model) {
        UserDTO logIn = (UserDTO) session.getAttribute("logIn");

//        List<ProductDTO> productList = productService.selectAll();

        model.addAttribute("logIn", logIn);
//        model.addAttribute("productList", productList);
        return "mypage/basket";
    }





}
