<%--
  Created by IntelliJ IDEA.
  User: sabum
  Date: 2023-03-28
  Time: 오후 5:41
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

    <link rel="stylesheet" href="/resources/css/mypage/mypage.css">
    <script defer src="/js/mypage/mypage.js"></script>
    <title>Title</title>
</head>
<%@include file="../main/header_nav.jsp" %>
<body>
<div class="inner">
    <div class="page-tit four">
        <h1><span>Beom Mall</span> My <em>Info</em> Page</h1>
    </div>
    <div class="form-box">
        <div class="delivery-box">
            <h4><span>MY Page</span></h4>
            <hr>
            <div class="info">
                <a onclick="hsitoryButton()"><span>주문목록</span></a><br>
                <a onclick="likeButton()"><span>찜리스트</span></a><br>
                <a onclick="myStoreButton()"><span>내가등록한상품</span></a><br>
                <a href="/mypage/showBasket"><span>장바구니</span></a><br>
            </div>
            <hr>
            <div class="info">
                <a href="/user/updateDelete"><span>개인정보확인/수정</span></a><br>
                <a href="/address/manager"><span>배송지 관리</span></a>
            </div>


        </div>
        <div class="history-box payment-box">
            <h4><span>주문목록</span></h4>
            <hr>
            <div class="itemList">
                <c:set var="date" value=""/>
                <c:forEach items="${entryDateList}" var="entryDate" varStatus="status">

                    <c:if test="${date ne entryDate}">
                        <div class="itemDateList">
                            <div class="date">
                                <span>${entryDateList[status.index]}</span>

                                <c:forEach items="${historyList}" var="item" varStatus="status2">
                                    <c:if test="${entryDateList[status2.index] eq entryDate}">
                                        <div class="item">
                                            <span>${item.state}</span><span> ${deliDateList[status2.index]}</span>
                                            <div class="info">
                                                <div class="img-box">
                                                    <img src="${item.img}">
                                                </div>
                                                <div class="data-box">
                                                    <p class="tit">${item.productTitle}</p>
                                                    <div class="info align-items-center">
                                                        <span>${item.finalPrice}</span>
                                                        <span style="width: 50px; text-align: center">${item.count} 개</span>
                                                        <div class='cartButton-box'>
                                                            <button class="cartButton custom-btn btn-4"
                                                                    value="${item.productId}"
                                                                    onclick="cartButton(${item.id})">장바구니 담기
                                                            </button>
                                                        </div>

                                                    </div>

                                                </div>
                                            </div>
                                        </div>
                                    </c:if>

                                </c:forEach>
                                <c:set var="date" value="${entryDate}"/>
                            </div>
                        </div>
                    </c:if>
                </c:forEach>


            </div>
        </div>

        <div class="like-box payment-box">
            <h4><span>찜리스트</span></h4>
            <div class="itemList">
                <c:forEach items="${likeList}" var="like" varStatus="status">

                    <div class="item" style="display: block">
                        <div class="info">
                            <div class="img-box">
                                <img src="${likeProductList[status.index].img}">
                            </div>
                            <div class="data-box">
                                <p class="tit">${likeProductList[status.index].title}</p>
                                <div class="info align-items-center">
                                    <span style="width: 100%">${likeProductList[status.index].price}원</span>
                                    <div class='text-end d-flex'>
                                            <%--                                    <div style=""class="like-util-box text-end d-flex">--%>
                                        <button class="likeButton text-end" value="${productList[status.index].id}"
                                                onclick="location.href='shop/showDetail?id=${productList[status.index].id}'">
                                            <img class="likeImg" src="/resources/images/main/shopping_cart.png"
                                                 alt="icon_like"/>
                                        </button>
                                        <button onclick="deleteLike(${like.id})" class="likeButton text-end" value="">
                                            <img src="/resources/images/product/trash.png"
                                                 alt="icon_like"/>
                                        </button>
                                            <%--                                    </div>--%>
                                    </div>

                                </div>

                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>


        <div class="myStore payment-box">
            <h4><span>내가등록한상품</span></h4>
            <div class="itemList">
                <div class="category-box dropdown">
                    <a class="nav-link dropdown-toggle" data-bs-toggle="dropdown" href="#" role="button"
                       aria-haspopup="true" aria-expanded="false">카테고리</a>
                    <div class="dropdown-menu">
                        <a class="dropdown-item" href="#">패션</a>
                        <a class="dropdown-item" href="#">it</a>
                        <a class="dropdown-item" href="#">식품</a>
                        <a class="dropdown-item" href="#">유아</a>
                        <a class="dropdown-item" href="#">뷰티</a>

                        <%--                                <a class="dropdown-item" href="#">Something else here</a>--%>
                        <%--                                <div class="dropdown-divider"></div>--%>
                        <%--                                <a class="dropdown-item" href="#"></a>--%>
                    </div>
                </div>

                    <div class="item" style="display: block">
                        <div class="info">
                            <div class="img-box">
                                <img class="product-img" src="">
                            </div>
                            <div class="data-box">
                                <span class="brand">브랜드</span>
                                <span class="title tit">선글라스</span>
                                <div class="info align-items-center">
                                    <span class="price" style="width: 100px">99,000원</span>
                                    <span class="remaining" style="width: 100%">1 개</span>
                                    <div class='text-end d-flex'>
                                            <%--                                    <div style=""class="like-util-box text-end d-flex">--%>
                                        <button class="likeButton text-end" value=""
                                                onclick="">
                                            <img class="likeImg" src="/resources/images/product/changes.png"
                                                 alt="icon_like"/>
                                        </button>
                                        <button onclick="" class="likeButton text-end" value="">
                                            <img src="/resources/images/product/trash.png"
                                                 alt="icon_like"/>
                                        </button>
                                            <%--                                    </div>--%>
                                    </div>

                                </div>

                            </div>
                        </div>
                    </div>
            </div>
        </div>

    </div>
</div>
</body>
</html>
