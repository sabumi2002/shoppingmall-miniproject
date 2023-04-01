<%--
  Created by IntelliJ IDEA.
  User: sabum
  Date: 2023-03-26
  Time: 오후 10:31
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

    <link rel="stylesheet"
          href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200"/>
    <link href="https://fonts.googleapis.com/css?family=Playfair+Display:400,400i,700,700i|Raleway:300,300i,400,400i,500,500i,600,600i,700,700i"
          rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Raleway:ital,wght@1,100&display=swap" rel="stylesheet">

    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
    <link rel="stylesheet" href="/resources/css/shop/detail.css">
    <script defer src="/js/shop/detail.js"></script>
    <title>Title</title>
</head>
<%@include file="../main/header_nav.jsp" %>
<body>
<div class="inner">
    <div class="category-box">
        <span>BeomMall Home > ${category}</span>
    </div>
    <button style="width: 100px; height: 50px" onclick= location.href="/shop/update?id=${productDTO.id}">update</button>
    <div class="product-box">
        <div class="img-box">
            <img src="${productDTO.img}">
        </div>
        <div class="info-box">
            <div class="two">
                <span>${productDTO.brand}</span>
                <h1>${productDTO.title}
                    <%--                    <span>Beom Mall Store</span>--%>

                </h1>
                <div class="product-like" style="margin-top: 10px">
                    <div style="" class="like-box text-end d-flex">
                        <button  class="likeButton text-end" value="${productDTO.id}">
                            <img class="likeImg" src="/resources/images/product/free-icon-heart-void.png"
                                 alt="icon_like"/>
                        </button>
                    </div>
                </div>

                <hr class="hr-3">
                <div class="info">
                    <div class="title">
                        <c:if test="${discount ne null}">
                            <span>${discount}%</span>
                            <span class="origin-price">${originPrice}원</span>
                        </c:if>

                        <p class="total-price">${totalPrice}원</p>
                    </div>
                </div>
                <hr class="hr-3">
                <div class="info">
                    <div class="tit">
                        <span>배송비</span>
                    </div>
                    <div class="data">
                        <span>${deliveryPrice}원</span>
                        <span>${deliveryDTO.name}</span>
                    </div>

                </div>
                <div class="info">
                    <div class="tit">
                        <span>배송 기간</span>
                    </div>
                    <div class="data">
                        <span class="deliveryDate">${deliveryDate}</span>
                    </div>

                </div>
                <hr class="hr-3">
                <div class="info">
                    <div class="tit">
                        <span>판매자</span>
                    </div>
                    <div class="data">
                        <span>${seller.nickname}</span>
                    </div>

                </div>
                <div class="info">
                    <div class="tit">
                        <span>판매자 평가</span>
                    </div>
                    <div class="data">
                        <span>89%</span>
                    </div>

                </div>
                <hr class="hr-3">


            </div>
            <div class="util-box">
                <div class="count-wrap _count">
                    <input type="hidden" id="productCount" value="${productDTO.remaining}">
                    <input type="text" class="inp form-control" value="1"/>
                    <div class="count-button-box">
                        <button type="button" class="plus material-symbols-outlined form-control">expand_less</button>
                        <button type="button" class="minus material-symbols-outlined form-control">expand_more</button>
                    </div>
                </div>
                <button class="custom-btn btn-7" onclick="cartButton()"><span>장바구니 담기</span></button>
                <button class="custom-btn btn-7"><span>바로구매 ></span></button>


            </div>
        </div>
    </div>
    <hr class="hr-3">
    <div class="product-util-box">
        <button class="button button--itzel button--text-thick"><i class="button__icon icon icon-cart"></i><span>상품상세</span></button>
        <button class="button button--itzel button--text-thick"><i class="button__icon icon icon-envelope"></i><span>상품평</span></button>
        <button class="button button--itzel button--text-thick"><i class="button__icon icon icon-trash"></i><span>상품문의</span></button>
    </div>
    <div class="content-box">
        ${productDTO.content}
    </div>
</div>
</body>
</html>
