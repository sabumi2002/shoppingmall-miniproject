package com.bit.spring.controller;

import com.bit.spring.model.AddressDTO;
import com.bit.spring.model.UserDTO;
import com.bit.spring.service.AddressService;
import com.bit.spring.service.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/address")
public class AddressController {
    private UserService userService;
    private AddressService addressService;

    public AddressController(UserService userService, AddressService addressService) {
        this.userService = userService;
        this.addressService = addressService;
    }

    @RequestMapping("/manager")
    public String manager(HttpSession session, Model model) {
        UserDTO logIn = (UserDTO) session.getAttribute("logIn");

        AddressDTO baseAddress = addressService.selectOne(logIn.getAddressId());
        List<AddressDTO> list = addressService.selectAll(logIn.getId());


        model.addAttribute("logIn", logIn);
        model.addAttribute("baseAdr", baseAddress);
        model.addAttribute("list", list);
        return "user/address";
    }
    @PostMapping("/insert")
    public String insert(HttpSession session, AddressDTO attempt){
        UserDTO logIn = (UserDTO) session.getAttribute("logIn");
        attempt.setUserId(logIn.getId());
        addressService.insert(attempt);

        return "redirect:/address/manager";
    }

    @PostMapping("/update/{id}")
    public String update(HttpSession session, AddressDTO attempt, RedirectAttributes redirectAttributes, @PathVariable int id){

        if(attempt.getZipCode().equals("") || attempt.getDetailedAddress().equals("")){
            redirectAttributes.addFlashAttribute("state", "updateFail");
            return "redirect:/address/manager";
        }

        attempt.setId(id);
        addressService.update(attempt);


        return "redirect:/address/manager";
    }
    @GetMapping("/delete/{id}")
    public String delete(HttpSession session, RedirectAttributes redirectAttributes, @PathVariable int id) {
        UserDTO logIn = (UserDTO) session.getAttribute("logIn");
        if(logIn.getAddressId() == id){
            redirectAttributes.addFlashAttribute("state", "deleteFail");
            return "redirect:/address/manager";
        }
        addressService.delete(id);
        redirectAttributes.addFlashAttribute("state", "deleteSuccess");
        return "redirect:/address/manager";
    }

    @GetMapping("/baseChange/{id}")
    public String baseChange(HttpSession session, RedirectAttributes redirectAttributes, @PathVariable int id) {
        UserDTO logIn = (UserDTO) session.getAttribute("logIn");

        logIn.setAddressId(id);

        userService.addressUpdate(logIn);

        return "redirect:/address/manager";
    }







}
