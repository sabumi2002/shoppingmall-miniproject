package com.bit.spring.controller;

import com.bit.spring.model.*;
import com.bit.spring.service.*;
import com.google.gson.*;
import com.google.gson.stream.JsonToken;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.TextStyle;
import java.util.*;

@Controller
@RequestMapping("/mypage")
public class MyPageController {
    private UserService userService;
    private CartService cartService;
    private ProductService productService;
    private DeliveryService deliveryService;
    private PurchaseHistoryService purchaseHistoryService;
    private AddressService addressService;
    private PremiumService premiumService;
    private LikeService likeService;

    public MyPageController(LikeService likeService, PremiumService premiumService, AddressService addressService, UserService userService, CartService cartService, PurchaseHistoryService purchaseHistoryService, ProductService productService, DeliveryService deliveryService) {
        this.userService = userService;
        this.cartService = cartService;
        this.purchaseHistoryService = purchaseHistoryService;
        this.productService = productService;
        this.deliveryService = deliveryService;
        this.addressService = addressService;
        this.premiumService = premiumService;
        this.likeService = likeService;
    }

    @RequestMapping("/showMypage")
    public String showMypage(HttpSession session, Model model) {
        UserDTO logIn = (UserDTO) session.getAttribute("logIn");

        List<OrderProductDTO> historyList = purchaseHistoryService.selectAllByLogin(logIn.getId());
        ArrayList<String> entryDateList = new ArrayList<>();
        ArrayList<String> deliDateList = new ArrayList<>();

        for (OrderProductDTO h : historyList) {
            entryDateList.add(entryDate(h.getEntryDate()));
            deliDateList.add(deleveryDate(h.getDeliveryDate()));
        }

        
        model.addAttribute("logIn", logIn);
        // 히스토리
        model.addAttribute("historyList", historyList);
        model.addAttribute("entryDateList", entryDateList);
        model.addAttribute("deliDateList", deliDateList);

        // 좋아요
        List<LikeDTO> likeList = likeService.selectAll(logIn.getId());
        ArrayList<ProductDTO> likeProductList =new ArrayList<>();
        for(LikeDTO like : likeList) {
            ProductDTO p = productService.selectOne(like.getProductId());
            likeProductList.add(p);
        }
        model.addAttribute("likeList", likeList);
        model.addAttribute("likeProductList", likeProductList);
        // 내가등록한상품

        
        return "mypage/mypage";
    }

    @RequestMapping("/showBasket")
    public String showBasket(HttpSession session, Model model) {
        UserDTO logIn = (UserDTO) session.getAttribute("logIn");

        List<OrderProductDTO> orderProductList = cartService.selectAllByLogin(logIn.getId());
        ArrayList<ProductDTO> productList = new ArrayList<>();
        ArrayList<DeliveryDTO> deliveryList = new ArrayList<>();
        ArrayList<String> deliDateList = new ArrayList<>();

        for (OrderProductDTO item : orderProductList) {
            productList.add(productService.selectOne(item.getProductId()));
            DeliveryDTO d = deliveryService.selectOne(productService.selectOne(item.getProductId()).getDeliveryId());
            String deliveryDate = deleveryDate(d.getPeriod());

            deliDateList.add(deliveryDate);
            deliveryList.add(d);
        }


        model.addAttribute("logIn", logIn);
        model.addAttribute("cartList", orderProductList);
        model.addAttribute("productList", productList);
        model.addAttribute("deliveryList", deliveryList);
        model.addAttribute("deliDateList", deliDateList);
        return "mypage/basket";
    }

    @ResponseBody
    @PostMapping("cartCountUpdate")
    public String cartCountUpdate(HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) throws ServletException, IOException {
//        PrintWriter writer = response.getWriter();
        JsonObject result = new JsonObject();
        HttpSession session = request.getSession();

//        int cartId = Integer.parseInt(request.getParameter("cartId"));
//        int count = Integer.parseInt(request.getParameter("count"));
        String[] countList = request.getParameterValues("countList");
        String[] cartIdList = request.getParameterValues("cartIdList");


        try {

            int index = 0;
            for (String cartId : cartIdList) {

                OrderProductDTO cartItem = cartService.selectOne(Integer.parseInt(cartId));
                ProductDTO productDTO = productService.selectOne(cartItem.getProductId());
                DeliveryDTO deliveryDTO = deliveryService.selectOne(productDTO.getDeliveryId());

                if (productDTO.getRemaining() == 0) {
                    cartItem.setCount(productDTO.getRemaining());

                } else if (productDTO.getRemaining() < cartItem.getCount()) {
                    cartItem.setCount(1);
                } else {

                    LocalDateTime now = LocalDateTime.now();
                    now = now.plusDays(deliveryDTO.getPeriod());


                    cartItem.setDeliveryDate(now);
                    cartItem.setCount(Integer.parseInt(countList[index]));

                }

                cartService.update(cartItem);
                index++;
            }


            result.addProperty("status", "success");
        } catch (Exception e) {
            result.addProperty("status", "fail");
        }

//        writer.print(result);
        return result.toString();
    }

    @PostMapping("deleteCart")
    public void deleteCart(HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) throws ServletException, IOException {
        PrintWriter writer = response.getWriter();
        JsonObject result = new JsonObject();


        int cartId = Integer.parseInt(request.getParameter("id"));
        try {
            cartService.delete(cartId);


            result.addProperty("status", "success");
        } catch (Exception e) {
            result.addProperty("status", "fail");
        }

        writer.print(result);
    }


    //, @RequestBody String temp
    //    @ResponseBody

    @ResponseBody
    @PostMapping("/cartPayment")
    public String cartPayment(HttpServletRequest request, HttpServletResponse response, HttpSession session, Model model) throws IOException {
//        PrintWriter writer = response.getWriter();
        JsonObject result = new JsonObject();

        String[] arrStr = request.getParameterValues("cartList");
        ArrayList<OrderProductDTO> list = new ArrayList<>();


        UserDTO logIn = (UserDTO) session.getAttribute("logIn");

        List<OrderProductDTO> initList = cartService.selectAll(logIn.getId());
        for (OrderProductDTO c : initList) {
            c.setState(null);
            cartService.update(c);
        }

        for (String a : arrStr) {
            OrderProductDTO cartItem = cartService.selectOne(Integer.parseInt(a));
            cartItem.setState("buying");
            list.add(cartItem);
            cartService.update(cartItem);

        }
        //이거 하는중
//        cartService.updateMulti(list);

        for (OrderProductDTO o : list) {
            cartService.update(o);
        }


        result.addProperty("status", "success");

//        writer.print(result);

        return result.toString();

    }

    @GetMapping("showCartPayment")
    public String showPayment(HttpSession session, Model model, int totalDeliPrice) {
        UserDTO logIn = (UserDTO) session.getAttribute("logIn");

        AddressDTO addressDTO = addressService.selectOne(logIn.getAddressId());
        List<OrderProductDTO> cartList = cartService.selectPayAll(logIn.getId());
        ArrayList<ProductDTO> productList = new ArrayList<>();
        ArrayList<String> deliDateList = new ArrayList<>();
        ArrayList<String> cartItemSumPrice = new ArrayList<>();
        int totalPrice = 0;
        int totalOriginPrice = 0;
        PremiumDTO premiumDTO = premiumService.selectOne(logIn.getRole());
        int discount = premiumDTO.getDiscount();

        for (OrderProductDTO c : cartList) {
            ProductDTO p = productService.selectOne(c.getProductId());
            productList.add(p);
            totalPrice += c.getFinalPrice() * c.getCount();

            DeliveryDTO d = deliveryService.selectOne(p.getDeliveryId());
            deliDateList.add(payDeleveryDate(d.getPeriod()));
            totalOriginPrice += p.getPrice() * c.getCount();

            cartItemSumPrice.add(Integer.toString(p.getPrice() * c.getCount()));

        }


        model.addAttribute("logIn", logIn);
        model.addAttribute("totalOriginPrice", money(totalOriginPrice));
        model.addAttribute("discount", discount);
        model.addAttribute("cartItemSumPrice", cartItemSumPrice);
        model.addAttribute("deliDateList", deliDateList);
        model.addAttribute("finalPrice", money(totalDeliPrice + totalPrice));
        model.addAttribute("totalDeliPrice", money(totalDeliPrice));
        model.addAttribute("totalPrice", money(totalPrice));
        model.addAttribute("productList", productList);
        model.addAttribute("cartList", cartList);
        model.addAttribute("addressDTO", addressDTO);

        return "mypage/payment";
    }

    @GetMapping("cartPaymentLogic")
    public void cartPaymentLogic(HttpServletRequest request, HttpServletResponse response, HttpSession session, Model model) throws IOException {
        PrintWriter writer = response.getWriter();
        UserDTO logIn = (UserDTO) session.getAttribute("logIn");
        JsonObject result = new JsonObject();

        List<OrderProductDTO> cartList = cartService.selectPayAll(logIn.getId());
        ArrayList<OrderProductDTO> countFailList = new ArrayList<>();
        ArrayList<OrderProductDTO> historyList = new ArrayList<>();


        try {

            for (OrderProductDTO c : cartList) {
                ProductDTO productDTO = productService.selectOne(c.getProductId());

                // 상품이 cartItem 개수보다 적을 때
                if (productDTO.getRemaining() < c.getCount()) {
                    for (OrderProductDTO item : cartList) {
                        item.setState(null);
                        countFailList.add(item);
                    }
                    cartService.updateMulti(countFailList);

                    throw new NullPointerException();
                }
                // 구매가 가능할떄 (수량이 모자르지않을때)
                AddressDTO addressDTO = addressService.selectOne(logIn.getAddressId());
                c.setState("shipping");
                c.setBuyerAddress(addressDTO.getStreetAddress() + ", " + addressDTO.getDetailedAddress());
                c.setProductTitle(productDTO.getTitle());
                c.setImg(productDTO.getImg());

                historyList.add(c);

            }

            for (OrderProductDTO item : historyList) {
                purchaseHistoryService.insert(item);
            }


            for (OrderProductDTO c : cartList) {
                // 상품 남은 수량 구하기
                ProductDTO productDTO = productService.selectOne(c.getProductId());
                int remaining = productDTO.getRemaining() - c.getCount();
                productDTO.setRemaining(remaining);
                productService.update(productDTO);
                // 장바구니 데이터 삭제
                cartService.delete(c.getId());
            }


            result.addProperty("state", "success");

        } catch (NullPointerException e) {
            result.addProperty("state", "lack");
        } catch (Exception e) {
            result.addProperty("state", "fail");
        }


        writer.print(result);
    }

    @PostMapping("mypageCart")
    public void mypageCart(HttpServletRequest request, HttpServletResponse response, HttpSession session, Model model) throws IOException {
        PrintWriter writer = response.getWriter();
        UserDTO logIn = (UserDTO) session.getAttribute("logIn");
        JsonObject result = new JsonObject();

        int id = Integer.parseInt(request.getParameter("id"));

        try {

            OrderProductDTO cart = purchaseHistoryService.selectOne(id);

            if(cartService.selectDup(cart)) {
                throw new Exception();
            }

            cart.setState(null);
            cartService.insert(cart);

            result.addProperty("state", "success");

        } catch (Exception e) {
            result.addProperty("state", "fail");
        }


        writer.print(result);
    }

    @PostMapping("deleteLike")
    public void deleteLike(HttpServletRequest request, HttpServletResponse response, HttpSession session, Model model) throws IOException {
        PrintWriter writer = response.getWriter();
        UserDTO logIn = (UserDTO) session.getAttribute("logIn");
        JsonObject result = new JsonObject();



        try {
            int id = Integer.parseInt(request.getParameter("id"));
            LikeDTO cart = likeService.selectOne(id);



            likeService.delete(id);

            result.addProperty("state", "success");

        } catch (Exception e) {
            result.addProperty("state", "fail");
        }


        writer.print(result);
    }


    private String deleveryDate(int period) {
        SimpleDateFormat sdf = new SimpleDateFormat("(E) MM/yy 도착보장");

        String result = "";
        LocalDateTime now = LocalDateTime.now();
        now = now.plusDays(period);

        int month = now.getMonthValue();
        int day = now.getDayOfMonth();
        String week = now.getDayOfWeek().getDisplayName(TextStyle.SHORT, Locale.KOREA);
        result = month + "/" + day + " (" + week + ") " + "도착 보장";
        return result;
    }

    private String deleveryDate(LocalDateTime date) {

        String result = "";


        int month = date.getMonthValue();
        int day = date.getDayOfMonth();
        String week = date.getDayOfWeek().getDisplayName(TextStyle.SHORT, Locale.KOREA);
        result = month + "/" + day + " (" + week + ") " + "도착";
        return result;
    }

    private String entryDate(LocalDateTime date) {

        String result = "";


        int year = date.getYear();
        int month = date.getMonthValue();
        int day = date.getDayOfMonth();
        String week = date.getDayOfWeek().getDisplayName(TextStyle.SHORT, Locale.KOREA);
        result = year + ". " + month + ". " + day + " 주문";
        return result;
    }

    public String payDeleveryDate(int period) {
        SimpleDateFormat sdf = new SimpleDateFormat("(E) MM/yy 도착 예정");


        String result = "";
        LocalDateTime now = LocalDateTime.now();
        now = now.plusDays(period);

        int month = now.getMonthValue();
        int day = now.getDayOfMonth();
        String week = now.getDayOfWeek().getDisplayName(TextStyle.SHORT, Locale.KOREA);
        result = month + "/" + day + " (" + week + ") " + "도착 예정";
        return result;
    }

    private String money(int money) {
        String temp = Integer.toString(money);

        StringBuffer sb = new StringBuffer();
        sb.append(temp);
        int count = 0;
        for (int i = sb.length(); i > 0; i--) {
            if (count == 3) {
                count = 0;
                sb.insert(i, ",");
            }
            count++;
        }
        return sb.toString();
    }
}
