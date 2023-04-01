package com.bit.spring.controller;

import com.bit.spring.model.AddressDTO;
import com.bit.spring.model.UserDTO;
import com.bit.spring.service.AddressService;
import com.bit.spring.service.UserService;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/user")
public class UserController {
    private UserService userService;
    private AddressService addressService;

    public UserController(UserService userService, AddressService addressService) {
        this.userService = userService;
        this.addressService = addressService;
    }

    @GetMapping("/auth")
    public String auth(HttpSession session, RedirectAttributes redirectAttributes, UserDTO attempt) {
        UserDTO logIn = (UserDTO) session.getAttribute("logIn");
        if (logIn != null) {
            return "redirect:/";
        } else {
            redirectAttributes.addFlashAttribute("loginMsg", "인증실패! 로그인정보를 확인해주세요.");
            redirectAttributes.addFlashAttribute("state", "loginFail");
            return "redirect:/user/login";
        }
    }


    @PostMapping("register")
    public String register(UserDTO attempt, AddressDTO addressDTO , RedirectAttributes redirectAttributes) {

        if(addressDTO.getZipCode().equals("") || addressDTO.getDetailedAddress().equals("")){
            redirectAttributes.addFlashAttribute("registerMsg", "주소지를 입력해주세요.");
            redirectAttributes.addFlashAttribute("state", "registerFail");
            return "redirect:/user/login";
        }
        if (userService.register(attempt)) {
            UserDTO userDTO = userService.selectByUsername(attempt.getUsername());
            addressDTO.setUserId(userDTO.getId());
            addressService.insert(addressDTO);
            addressDTO = addressService.selectAll(userDTO.getId()).get(0);
            userDTO.setAddressId(addressDTO.getId());
            System.out.println(userDTO);
            userService.addressUpdate(userDTO);

            redirectAttributes.addFlashAttribute("state", "registerSuccess");
            return "redirect:/user/login";
        } else {
            redirectAttributes.addFlashAttribute("registerMsg", "중복된 아이디로 가입하실 수 없습니다.");
            redirectAttributes.addFlashAttribute("state", "registerFail");
            return "redirect:/user/login";
        }

    }

    @RequestMapping("/updateDelete")
    public String updateDelete(HttpSession session, Model model) {
        UserDTO logIn = (UserDTO) session.getAttribute("logIn");
        if (model.getAttribute("updateMsg") == null) {
            model.addAttribute("updateMsg", "수정하실 정보를 입력해주세요.");
        }
        if (model.getAttribute("deleteMsg") == null) {
            model.addAttribute("deleteMsg", "정말로 삭제하시겠습니까?");
        }
        model.addAttribute("logIn", logIn);
        return "user/update";
    }

    @PostMapping("/update")
    public String update(HttpSession session, UserDTO attempt, RedirectAttributes redirectAttributes) {
        UserDTO logIn = (UserDTO) session.getAttribute("logIn");
        attempt.setId(logIn.getId());
        userService.update(attempt);
        logIn = userService.selectOne(logIn.getId());
        logIn.setPassword(null);
        session.setAttribute("logIn", logIn);
        redirectAttributes.addFlashAttribute("state", "updateSuccess");
        return "redirect:/";
    }

    @GetMapping("/delete/{id}")
    public String delete(HttpSession session, RedirectAttributes redirectAttributes, @PathVariable int id) {
        UserDTO logIn = (UserDTO) session.getAttribute("logIn");

        if (logIn.getId() != id) {
            return "redirect:/user/updateDelete";
        }
        userService.delete(id);
        session.removeAttribute("logIn");
        return "redirect:/user/logOut";

    }




    @RequestMapping("/login")
    public String showLogin(Model model) {

        if (model.getAttribute("loginMsg") == null) {
            model.addAttribute("loginMsg", "로그인 정보를 입력해주세요.");
        }
        if (model.getAttribute("registerMsg") == null) {
            model.addAttribute("registerMsg", "beomMall에 오신것을 환영합니다.");
        }
        return "user/login";
    }
}
