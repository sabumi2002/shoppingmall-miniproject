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
    <link rel="stylesheet" href="/resources/css/mypage/basket.css">
    <script defer src="/js/mypage/basket.js"></script>
    <title>Title</title>
</head>
<%@include file="../main/header_nav.jsp" %>
<body>
<div class="inner">
    <div class="myInfo"></div>
    <div class="">
        <h1>장바구니</h1>
    </div>
    <div class="basket-box">
        <table style="width: 100%" class="cartTable"
               summary="장바구니 상품명, 제품가격, 선택한수량, 총결제비용 정보 및 결제 상품으로 선택,해제 및 수량변경, 삭제 기능 제공표">
            <thead>
            <tr class="head">
                <th scope="col" class="all-select-event" style="width: 15px">
                    <div class="cart-checkbox">
                        <input title="모든 상품을 결제상품으로 설정" type="checkbox"
                               class="all-deal-select"/>
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

            <tr class="cart-deal-item ">

                <td class="product-select-event">
                    <div class="cart-checkbox align-content-center justify-content-center align-items-center text-center">
                        <input type="checkbox"
                               value="22537270918" class="dealSelectChk align-content-center"/>
                    </div>

                </td>
                <td>
                    <div class="cart-deal-item__image text-start">

                        <a href="//www.coupang.com/vp/products/6787611877" class="">
                            <img src="//thumbnail10.coupangcdn.com/thumbnails/remote/120x120ex/image/vendor_inventory/9943/9a968040219004cf78a48e72afb7293e227fc094ec267d5deb0c86c4d97a.jpg"
                                 width="78" height="78" class=""
                                 alt="로지텍 G102 2세대 LIGHTSYNC 게이밍 유선 마우스 MU0054 + 마우스 피트 2p"
                                 data-bundle-id="22537270918"/>
                        </a>
                    </div>
                </td>


                <td class="info">
                    <p>로지텍 G102 2세대 LIGHTSYNC 게이밍 유선 마우스 MU0054 + 마우스 피트 2p, 블랙(마우스)</p>
                    <div class="d-flex">
                        <span style="width: 20%">내일 도착 보장</span>
                        <div class="text-end" style="width: 80%">

                            <span class="text-start">26,000원</span>
                            <select class="" id="input-categoryId"
                                    aria-label=".form-select-lg example"
                                    name="categoryId" style="right: 0; ">
                                <option value="1">1</option>
                                <option value="1">2</option>
                                <option value="1">3</option>
                            </select>
                        </div>
                    </div>

                </td>
                <td>
                    <span>26,050원</span>
                </td>
                <td>
                    <span>5,000원</span>
                </td>
            </tr>

            <tr class="cart-deal-item ">

                <td class="product-select-event">
                    <div class="cart-checkbox align-content-center justify-content-center align-items-center text-center">
                        <input type="checkbox"
                               value="22537270918" class="dealSelectChk align-content-center"/>
                    </div>

                </td>
                <td>
                    <div class="cart-deal-item__image text-start">

                        <a href="//www.coupang.com/vp/products/6787611877" class="">
                            <img src="//thumbnail10.coupangcdn.com/thumbnails/remote/120x120ex/image/vendor_inventory/9943/9a968040219004cf78a48e72afb7293e227fc094ec267d5deb0c86c4d97a.jpg"
                                 width="78" height="78" class=""
                                 alt="로지텍 G102 2세대 LIGHTSYNC 게이밍 유선 마우스 MU0054 + 마우스 피트 2p"
                                 data-bundle-id="22537270918"/>
                        </a>
                    </div>
                </td>


                <td class="info">
                    <p>로지텍 G102 2세대 LIGHTSYNC 게이밍 유선 마우스 MU0054 + 마우스 피트 2p, 블랙(마우스)</p>
                    <div class="d-flex">
                        <span style="width: 20%">내일 도착 보장</span>
                        <div class="text-end" style="width: 80%">

                            <span class="text-start">26,000원</span>
                            <select class="" id="input-categoryId"
                                    aria-label=".form-select-lg example"
                                    name="categoryId" style="right: 0; ">
                                <option value="1">1</option>
                                <option value="1">2</option>
                                <option value="1">3</option>
                            </select>
                        </div>
                    </div>

                </td>
                <td>
                    <span>26,050원</span>
                </td>
                <td>
                    <span>5,000원</span>
                </td>
            </tr>
            </tbody>

        </table>
    </div>
</div>
</body>
</html>