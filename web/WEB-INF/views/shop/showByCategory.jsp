<%--
  Created by IntelliJ IDEA.
  User: sabum
  Date: 2023-03-24
  Time: 오후 3:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <link href="/resources/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN"
            crossorigin="anonymous"></script>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.11.2/css/all.min.css">
    <title>Shop</title>
    <meta charset="utf-8">
    <link rel="stylesheet" href="/resources/css/shop/shop.css">
    <link href="https://fonts.googleapis.com/earlyaccess/notosanskr.css" rel="stylesheet">
</head>
<body>
<%--<div class="navbar">--%>
<%--    <a href="#" id="logo">--%>
<%--        <img src="https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FbelPXk%2Fbtq3htE0CuW%2F20UUE0cydRQEDvD6wlEL1K%2Fimg.png" height="60">--%>
<%--    </a>--%>

<%--    <ul id="menu">--%>
<%--        <li><a href="#"><b>Contact</b></a></li>--%>
<%--        <li><a href="#"><b>Shop</b></a></li>--%>
<%--        <li><a href="#"><b>Cart</b></a></li>--%>
<%--        <li><a href="#"><b>Login</b></a></li>--%>
<%--    </ul>--%>
<%--</div>--%>
<%@include file="../main/header_nav.jsp"%>
<div class="hero-header"></div>

<div class="products">
    <h3>Our New Products</h3>

    <div class="product-list frame">
        <c:forEach items="${productList}" var="item">
            <a href="/shop/showDetail?id=${item.id}" class="product btn-5">
                <img src="${item.img}" width="225">
                <div class="product-name">
                    ${item.title}
                </div>
                <div class="product-price">
                    ${item.price}
                </div>
            </a>
        </c:forEach>
        <a href="#" class="product btn-5">
            <img src="https://bakey-api.codeit.kr/files/629/images/sunglasses.jpg" width="225">
            <div class="product-name">
                Sunglasses
            </div>
            <div class="product-price">
                49,000
            </div>
        </a>


        <a href="#" class="product btn-5">
            <img src="https://bakey-api.codeit.kr/files/629/images/sunglasses.jpg" width="225" height="225px">
            <div class="product-name">
                Sunglasses
            </div>
            <div class="product-price">
                49,000
            </div>
        </a>


        <a href="#" class="product btn-5">
            <img src="https://bakey-api.codeit.kr/files/629/images/sunglasses.jpg" width="225" height="225px">
            <div class="product-name">
                Sunglasses
            </div>
            <div class="product-price">
                49,000
            </div>
        </a>


        <a href="#" class="product btn-5">
            <img src="https://bakey-api.codeit.kr/files/629/images/sunglasses.jpg" width="225" height="225px">
            <div class="product-name">
                Sunglasses
            </div>
            <div class="product-price">
                49,000
            </div>
        </a>


        <a href="#" class="product btn-5">
            <img src="https://bakey-api.codeit.kr/files/629/images/sunglasses.jpg" width="225" height="225px">
            <div class="product-name">
                Sunglasses
            </div>
            <div class="product-price">
                49,000
            </div>
        </a>


        <a href="#" class="product btn-5">
            <img src="https://bakey-api.codeit.kr/files/629/images/sunglasses.jpg" width="225" height="225px">
            <div class="product-name">
                Sunglasses
            </div>
            <div class="product-price">
                49,000
            </div>
        </a>

        <a href="#" class="product btn-5">
            <img src="https://bakey-api.codeit.kr/files/629/images/sunglasses.jpg" width="225" height="225px">
            <div class="product-name">
                Sunglasses
            </div>
            <div class="product-price">
                49,000
            </div>
        </a>

        <a href="#" class="product btn-5">
            <img src="https://bakey-api.codeit.kr/files/629/images/sunglasses.jpg" width="225" height="225px">
            <div class="product-name">
                Sunglasses
            </div>
            <div class="product-price">
                49,000
            </div>
        </a>

        <a href="#" class="product btn-5">
            <img src="https://bakey-api.codeit.kr/files/629/images/sunglasses.jpg" width="225" height="225px">
            <div class="product-name">
                Sunglasses
            </div>
            <div class="product-price">
                49,000
            </div>
        </a>
        <div class="clearfix"></div>
    </div>

    <div class="footer">
        <a href="http://faceboo.com">
            <img src="https://bakey-api.codeit.kr/files/629/images/facebook.png" height="20">
        </a>
        <a href="http://faceboo.com">
            <img src="https://bakey-api.codeit.kr/files/629/images/instagram.png" height="20">
        </a>
        <a href="http://faceboo.com">
            <img src="https://bakey-api.codeit.kr/files/629/images/twitter.png" height="20">
        </a>
    </div>
</div>
</body>
</html>
