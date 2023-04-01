<%--
  Created by IntelliJ IDEA.
  User: sabum
  Date: 2023-03-28
  Time: 오후 9:11
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

    <%--    <link rel="stylesheet"--%>
    <%--          href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200"/>--%>
    <%--    <link href="https://fonts.googleapis.com/css?family=Playfair+Display:400,400i,700,700i|Raleway:300,300i,400,400i,500,500i,600,600i,700,700i"--%>
    <%--          rel="stylesheet">--%>
    <%--    <link href="https://fonts.googleapis.com/css2?family=Raleway:ital,wght@1,100&display=swap" rel="stylesheet">--%>

    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
    <link rel="stylesheet" href="/resources/css/mypage/basket.css">
    <script defer src="/js/mypage/basket.js"></script>
    <title>Title</title>
</head>
<%@include file="../main/header_nav.jsp" %>
<body>
<div class="inner">
    <div class="myInfo"></div>
    <div class="cart-title align-items-center">
        <img src="/resources/images/main/shopping_cart.png">
        <span class="">장바구니</span>
    </div>
    <div class="basket-box">
        <table style="width: 100%" class="cartTable"
               summary="장바구니 상품명, 제품가격, 선택한수량, 총결제비용 정보 및 결제 상품으로 선택,해제 및 수량변경, 삭제 기능 제공표">
            <thead>
            <tr class="head">
                <th scope="col" class="all-select-event" style="width: 15px">
                    <div class="cart-checkbox">
                        <input title="모든 상품을 결제상품으로 설정" type="checkbox" name="cart-check"
                               class="all-deal-select" onclick='selectAll(this)'/>
                    </div>
                </th>
                <th style="width: 80px; text-align: left">
                    <span>&nbsp;&nbsp;전체선택</span>
                </th>

                <th scope="colgroup" id="th-product-box" style="">상품정보</th>
                <th scope="col" id="th-unit-total-price" style="width: 80px">상품금액</th>
                <th scope="col" id="th-delivery-fee" style="width: 80px">배송비</th>
            </tr>
            </thead>


            <tbody id="cartTable-sku">


            <tr>
                <td colspan="5" class="cart-bundle-title text-start">
                    <span class="rocket-delivery-info">
                        <span class="rocket-free">무료배송</span>
                        (19,800원 이상 구매시)
                    </span>
                    <div id="lateRocketWowOverNightMessage" class="late-dawn-delivery-message"
                         style="display: none"></div>
                </td>
            </tr>

            <c:forEach items="${cartList}" var="item" varStatus="status">
                <c:set var="index" value="${status.index}"/>
                <tr class="cart-item" style="height: 77px;">
                    <td class="product-select-event">
                        <div class="cart-checkbox align-content-center justify-content-center align-items-center text-center">
                            <input type="checkbox" name="cart-check"
                                   value="22537270918" class="cart-check dealSelectChk align-content-center"/>
                        </div>
                    </td>
                    <td>
                        <div class="cart-deal-item__image text-start">

                            <a href="/shop/showDetail?id=${item.productId}" class="">
                                <img src="${productList[status.index].img}"
                                     width="78" height="78" class=""
                                     alt="${productList[status.index].title}"
                                     data-bundle-id="22537270918"/>
                            </a>
                        </div>
                    </td>
                    <td class="info">

                        <div style="width:100%;display: flex; margin-bottom: 5px">
                            <span style="width: 100%">${productList[status.index].title}</span>
                            <div style=""class="like-box text-end d-flex">
                                <button class="likeButton text-end" value="${productList[status.index].id}">
                                    <img class="likeImg" src="/resources/images/product/free-icon-heart-void.png"
                                         alt="icon_like"/>
                                </button>
                                <button onclick="deleteCart(${item.id})" class="likeButton text-end" value="">
                                    <img src="/resources/images/product/trash.png"
                                         alt="icon_like"/>
                                </button>
                            </div>



                        </div>
                        <div class="d-flex">
                            <span style="width: 60%">${deliDateList[index]}</span>
                            <div class="text-end" style="width: 40%">

                                <span class="item-price">${item.finalPrice}</span>
                                <input class="cartId" type="hidden" value="${item.id}">
                                <input type="hidden" class="productCount" value="${productList[index].remaining}">
                                <select class="input-count"
                                        aria-label=".form-select-lg example"
                                        name="count" style="right: 0; ">
                                    <c:choose>
                                        <c:when test="${productList[status.index].remaining lt 10}">
                                            <c:forEach begin="1" end="${productList[status.index].remaining}" step="1"
                                                       varStatus="status">
                                                <c:choose>

                                                    <c:when test="${item.count eq status.index}">
                                                        <option value="${status.index}" selected>${status.index}</option>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <option value="${status.index}">${status.index}</option>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <c:forEach begin="1" end="10" step="1" varStatus="status">
                                                <c:choose>

                                                    <c:when test="${item.count eq status.index}">
                                                        <option value="${status.index}" selected>${status.index}</option>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <option value="${status.index}">${status.index}</option>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:forEach>
                                        </c:otherwise>
                                    </c:choose>

                                </select>
                            </div>
                        </div>
                    </td>
                    <td>
                        <span class="cart-price">${item.finalPrice}원</span>
                    </td>
                    <td>
                        <span class="cart-delivery-price">${deliveryList.get(index).price}원</span>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
    <div class="total-info-box">
        <hr>
        <div class="total-info">
            <span>총 상품가격</span> <span class="final-productPrice">0</span>
            <span class="tit">총 배송비</span> <span class="final-deliPrice">0</span>
            <span class="tit">총 주문금액</span> <span class="final-price title">0</span>
        </div>
        <hr>
        <div class="cart-util-box text-center">
            <button class="btn btn-outline-primary" onclick="location.href='/shop/showAll'">계속 쇼핑하기</button>
            <button class="btn btn-outline-primary" onclick="cartCountUpdate()">구매하기</button>
        </div>
    </div>
</div>
</body>
</html>