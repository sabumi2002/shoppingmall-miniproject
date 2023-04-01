package com.bit.spring.controller;

import com.bit.spring.model.*;
import com.bit.spring.service.*;
import com.google.gson.JsonObject;
import com.sun.net.httpserver.Request;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpRequest;
import org.springframework.lang.Nullable;
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
import java.io.EOFException;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeFormatterBuilder;
import java.time.format.TextStyle;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
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
    private UserService userService;
    private ProductService productService;
    private CategoryService categoryService;
    private DeliveryService deliveryService;
    private PremiumService premiumService;
    private CartService cartService;
    private LikeService likeService;

    public ShopController(UserService userService, ProductService productService, CategoryService categoryService, DeliveryService deliveryService, PremiumService premiumService, CartService cartService, LikeService likeService) {
        this.productService = productService;
        this.categoryService = categoryService;
        this.deliveryService = deliveryService;
        this.userService = userService;
        this.premiumService = premiumService;
        this.cartService = cartService;
        this.likeService = likeService;
    }

    @RequestMapping("/showAll")
    public String showAll(HttpSession session, Model model) {
        UserDTO logIn = (UserDTO) session.getAttribute("logIn");

        List<ProductDTO> productList = productService.selectAll();
        ArrayList<String> originPriceList = new ArrayList<>();
        ArrayList<String> deliveryDateList = new ArrayList<>();
        ArrayList<String> totalPriceList = new ArrayList<>();
        int discount= 0;
        if(logIn != null) {
            PremiumDTO loginPremium = premiumService.selectOne(logIn.getRole());
            discount = loginPremium.getDiscount();
            model.addAttribute("discount", discount);
        }

        for (ProductDTO item : productList){
            String totalPrice = money(item.getPrice());

            if(logIn != null) {

                totalPrice = money(discount(item.getPrice(), discount));
                originPriceList.add(money(item.getPrice()));

            }
            totalPriceList.add(totalPrice);
            DeliveryDTO deliveryDTO = deliveryService.selectOne(item.getDeliveryId());

            deliveryDateList.add(deleveryDate(deliveryDTO.getPeriod()));
        }

        if(logIn != null) {
            model.addAttribute("originPriceList", originPriceList);
        }





        model.addAttribute("totalPriceList", totalPriceList);
        model.addAttribute("deliveryDateList", deliveryDateList);
        model.addAttribute("productList", productList);
        model.addAttribute("logIn", logIn);
        return "shop/showAll";
    }
    @RequestMapping("/showByCategory")
    public String showByCategory(HttpSession session, Model model, int id) {
        UserDTO logIn = (UserDTO) session.getAttribute("logIn");

        List<ProductDTO> productList = productService.selectAllByCategory(id);
        ArrayList<String> originPriceList = new ArrayList<>();
        ArrayList<String> deliveryDateList = new ArrayList<>();
        ArrayList<String> totalPriceList = new ArrayList<>();
        int discount= 0;
        if(logIn != null) {
            PremiumDTO loginPremium = premiumService.selectOne(logIn.getRole());
            discount = loginPremium.getDiscount();
            model.addAttribute("discount", discount);
        }

        for (ProductDTO item : productList){
            String totalPrice = money(item.getPrice());

            if(logIn != null) {

                totalPrice = money(discount(item.getPrice(), discount));
                originPriceList.add(money(item.getPrice()));

            }
            totalPriceList.add(totalPrice);
            DeliveryDTO deliveryDTO = deliveryService.selectOne(item.getDeliveryId());

            deliveryDateList.add(deleveryDate(deliveryDTO.getPeriod()));
        }

        if(logIn != null) {
            model.addAttribute("originPriceList", originPriceList);
        }





        model.addAttribute("totalPriceList", totalPriceList);
        model.addAttribute("deliveryDateList", deliveryDateList);
        model.addAttribute("productList", productList);
        model.addAttribute("logIn", logIn);
        return "shop/showAll";
    }

    @RequestMapping(value="showDetail",method = RequestMethod.GET)
    public String showDetail(HttpSession session, Model model, int id) {
        UserDTO logIn = (UserDTO) session.getAttribute("logIn");


        ProductDTO productDTO = productService.selectOne(id);
        int sellerId = productDTO.getSellerId();
        UserDTO seller = userService.selectOne(sellerId);
        DeliveryDTO deliveryDTO = deliveryService.selectOne(productDTO.getDeliveryId());
        CategoryDTO categoryDTO = categoryService.selectOne(productDTO.getCategoryId());

        String deliveryDate = deleveryDate(deliveryDTO.getPeriod());

        int totalPrice = productDTO.getPrice();

        if(logIn != null) {
            PremiumDTO loginPremium = premiumService.selectOne(logIn.getRole());



            int discount = loginPremium.getDiscount();
            model.addAttribute("discount", discount);
            totalPrice = discount(productDTO.getPrice(), discount);
            model.addAttribute("originPrice", money(productDTO.getPrice()));
        }

        model.addAttribute("totalPrice", money(totalPrice));


        model.addAttribute("category", categoryDTO.getCategory());
        model.addAttribute("deliveryPrice", money(deliveryDTO.getPrice()));
        model.addAttribute("deliveryDate", deliveryDate);
        model.addAttribute("deliveryDTO", deliveryDTO);
        model.addAttribute("seller", seller);
        model.addAttribute("productDTO", productDTO);
        model.addAttribute("logIn", logIn);
        return "shop/showDetail";
    }

    @GetMapping("update")
    public String update(HttpSession session, Model model, int id) {
        UserDTO logIn = (UserDTO) session.getAttribute("logIn");

        List<CategoryDTO> categoryList = categoryService.selectAll();
        List<DeliveryDTO> deliveryList = deliveryService.selectAll();
        ProductDTO productDTO = productService.selectOne(id);


        model.addAttribute("productDTO", productDTO);
        model.addAttribute("categoryList", categoryList);
        model.addAttribute("deliveryList", deliveryList);

        return "shop/upsert";
    }
    @GetMapping("/write")
    public String write(HttpSession session, Model model) {
        UserDTO logIn = (UserDTO) session.getAttribute("logIn");

        List<CategoryDTO> categoryList = categoryService.selectAll();
        List<DeliveryDTO> deliveryList = deliveryService.selectAll();


        model.addAttribute("categoryList", categoryList);
        model.addAttribute("deliveryList", deliveryList);

        return "shop/upsert";
    }


///MultipartFile[] uploadFile



    //    @RequestMapping(value = "/writeLogic", method = { RequestMethod.POST })
    @PostMapping("/upsert")
    public void upsert(MultipartHttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PrintWriter writer = response.getWriter();
        JsonObject object = new JsonObject();
        HttpSession session = request.getSession();

        UserDTO logIn = (UserDTO) session.getAttribute("logIn");


        try {


            String title = request.getParameter("title");
            String brand = request.getParameter("brand");
            int price = Integer.parseInt(request.getParameter("price"));
            int categoryId = Integer.parseInt(request.getParameter("categoryId"));
            String content = request.getParameter("content");
            int remaining = Integer.parseInt(request.getParameter("remaining"));
            int deliveryId = Integer.parseInt(request.getParameter("deliveryId"));
            int sellerId = logIn.getId();
            String id = request.getParameter("id");

            // write, update 할 DTO
            ProductDTO productDTO = new ProductDTO();
            productDTO.setTitle(title);
            productDTO.setBrand(brand);
            productDTO.setPrice(price);
            productDTO.setCategoryId(categoryId);
            productDTO.setDeliveryId(deliveryId);
            productDTO.setSellerId(sellerId);
            productDTO.setContent(content);
            productDTO.setRemaining(remaining);

            if(id.matches("^\\d+$") && request.getFile("file")==null){
                ProductDTO updateDTO = productService.selectOne(Integer.parseInt(id));
                productDTO.setImg(updateDTO.getImg());
            } else {

                // 파일 값 받기
                MultipartFile multipartFile = request.getFile("file");
                /* 파일 이름 변경 */
                UUID uuid = UUID.randomUUID();
                String filename = uuid + "_" + multipartFile.getOriginalFilename();


                Path dir = Paths.get(request.getSession().getServletContext().getRealPath("/resources/upload"));

                File f = new File(dir.toRealPath() + "\\" + filename);


//            System.out.println(filename);
//            System.out.println(f.getPath());
                f.deleteOnExit();
                f.createNewFile();

                multipartFile.transferTo(f);
                /* 실제 폴더에 파일 업로드 */
                productDTO.setImg("/resources/upload/"+filename);
            }


            if(id.matches("^\\d+$")){
                productDTO.setId(Integer.parseInt(id));
                productService.update(productDTO);
            } else {
                productService.insert(productDTO);
            }


            object.addProperty("status", "success");
        } catch (Exception e) {
            object.addProperty("status", "fail");
            e.printStackTrace();
        }
        writer.print(object);

    }
    @PostMapping("cart")
    public void cart(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PrintWriter writer = response.getWriter();
        JsonObject result = new JsonObject();
        HttpSession session = request.getSession();


        try {
            if (session.getAttribute("logIn") == null){
                throw new NullPointerException();
            }


            UserDTO logIn = (UserDTO) session.getAttribute("logIn");

            int buyId = logIn.getId();
            int productId = Integer.parseInt(request.getParameter("id"));
            int finalPrice = Integer.parseInt(request.getParameter("finalPrice"));
            int itemCount = Integer.parseInt(request.getParameter("itemCount"));


            OrderProductDTO cartItem = new OrderProductDTO();
            cartItem.setBuyerId(buyId);
            cartItem.setProductId(productId);
            cartItem.setFinalPrice(finalPrice);
            cartItem.setCount(itemCount);


            if (cartService.selectDup(cartItem)) {
                throw new IOException();
            }


            cartService.insert(cartItem);


            result.addProperty("status", "success");
        } catch (NullPointerException ne){
            result.addProperty("status", "loginNull");
        } catch (Exception e){
            result.addProperty("status", "fail");
        }

        writer.print(result);

    }

    @PostMapping("like")
    public void like(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PrintWriter writer = response.getWriter();
        JsonObject result = new JsonObject();
        HttpSession session = request.getSession();


        try {
            if (session.getAttribute("logIn") == null) {
                throw new Exception();
            }
            UserDTO logIn = (UserDTO) session.getAttribute("logIn");

            int productId = Integer.parseInt(request.getParameter("id"));


            if (likeService.selectAuth(logIn.getId(), productId) == null){
                LikeDTO like = new LikeDTO();
                like.setUserId(logIn.getId());
                like.setProductId(productId);


                likeService.insert(like);
                result.addProperty("status", "likeOn");
            }else {

                LikeDTO like = likeService.selectAuth(logIn.getId(), productId);
                likeService.delete(like.getId());
                result.addProperty("status", "likeOff");
            }

        }catch (Exception e){
            result.addProperty("status", "fail");
        }

        writer.print(result);

    }

    @PostMapping("likeAll")
    public void likeAll(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PrintWriter writer = response.getWriter();
        JsonObject result = new JsonObject();
        HttpSession session = request.getSession();
        try {
            if (session.getAttribute("logIn") == null) {
                throw new Exception();
            }
            UserDTO logIn = (UserDTO) session.getAttribute("logIn");

            int productId = Integer.parseInt(request.getParameter("id"));


            if (likeService.selectAuth(logIn.getId(), productId) == null){

                result.addProperty("status", "likeOff");
            }else {


                result.addProperty("status", "likeOn");
            }

        }catch (Exception e){
            result.addProperty("status", "likeOff");
        }

        writer.print(result);

    }




    private int discount(int originPrice, int discount){
        int totalPrice = (int) (originPrice * (100-discount)* 0.01);

        return totalPrice;
    }


    private String deleveryDate(int period){
        SimpleDateFormat sdf = new SimpleDateFormat("(E) MM/yy 도착보장");



        String result = "";
        LocalDateTime now = LocalDateTime.now();
        now = now.plusDays(period);

        int month = now.getMonthValue();
        int day = now.getDayOfMonth();
        String week = now.getDayOfWeek().getDisplayName(TextStyle.SHORT, Locale.KOREA);
        result= month+"/"+day+" ("+week+") "+"도착 보장";
        return result;
    }

    private String money(int money){
        String temp = Integer.toString(money);

        StringBuffer sb = new StringBuffer();
        sb.append(temp);
        int count= 0;
        for(int i = sb.length(); i>0 ; i--){
            if(count ==3){
                count=0;
                sb.insert(i, ",");
            }
            count++;
        }
        return sb.toString();
    }





}