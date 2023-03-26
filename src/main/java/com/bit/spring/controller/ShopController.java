package com.bit.spring.controller;

import com.bit.spring.model.AddressDTO;
import com.bit.spring.model.ProductDTO;
import com.bit.spring.model.UserDTO;
import com.bit.spring.service.AddressService;
import com.bit.spring.service.ProductService;
import com.bit.spring.service.UserService;
import com.google.gson.JsonObject;
import com.sun.net.httpserver.Request;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.UUID;


//@MultipartConfig(
//        location = "",
//        maxFileSize = 1024 * 1024 * 5,
//        maxRequestSize = 1024 * 1024 * 50
//
//
//)
@Controller
@RequestMapping("/shop")
public class ShopController {
    private ProductService productService;

    public ShopController(ProductService productService, AddressService addressService) {
        this.productService = productService;
//        this.addressService = addressService;
    }

    @RequestMapping("/showAll")
    public String showAll(HttpSession session, Model model) {
        UserDTO logIn = (UserDTO) session.getAttribute("logIn");

//        model.addAttribute("logIn", logIn);
//        model.addAttribute("baseAdr", baseAddress);
//        model.addAttribute("list", list);
        return "shop/showAll";
    }

    @RequestMapping("/write")
    public String write(HttpSession session, Model model) {
        UserDTO logIn = (UserDTO) session.getAttribute("logIn");


        return "shop/write";
    }
///MultipartFile[] uploadFile

    //    @RequestMapping(value = "/writeLogic", method = { RequestMethod.POST })
    @PostMapping("/writeLogic")
    public void writeLogic(@RequestParam("file") MultipartFile file, MultipartHttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PrintWriter writer = response.getWriter();
        JsonObject object = new JsonObject();
        HttpSession session = request.getSession();

        System.out.println("연결");
        System.out.println("하이");
        System.out.println("fdfs");
        System.out.println(file);
        System.out.println(request.getPart("file"));

        System.out.println(request.getParameter("title"));


        try {


            String title = request.getParameter("title");
            String brand = request.getParameter("brand");
            String price = request.getParameter("price");
            String content = request.getParameter("content");
            String remaining = request.getParameter("remaining");
            int deliveryId = Integer.parseInt(request.getParameter("deliveryId"));

            System.out.println(title);


            // 파일 값 받기
            MultipartFile multipartFile = request.getFile("file");
            /* 파일 이름 변경 */
            UUID uuid = UUID.randomUUID();
            String filename = uuid + "_" + multipartFile.getOriginalFilename();


            Path dir = Paths.get(request.getSession().getServletContext().getRealPath("/resources/upload"));

            File f = new File(dir.toRealPath() + "\\" + filename);


            System.out.println(filename);
            System.out.println(f.getPath());
            f.deleteOnExit();
            f.createNewFile();

            multipartFile.transferTo(f);
            /* 실제 폴더에 파일 업로드 */


//            ConnectionMaker connectionMaker = new MySqlConnectionMaker();
//            MovieController movieController = new MovieController(connectionMaker);
//            MovieDTO m = movieController.selectOne(movieId);


//            m.setTitle(titleName);
//            m.setContent(fileDescription);
//            m.setRank(fileRank);
//            m.setRelease(fileRelease);
//            m.setLength(fileLength);
//            m.setImg("/upload/"+fileName);

//            movieController.update(m);


//
            object.addProperty("status", "success");
        } catch (Exception e) {
            object.addProperty("status", "fail");
            e.printStackTrace();
        }
        writer.print(object);


    }






}