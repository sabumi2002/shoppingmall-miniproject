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
                <a href="#"><span>주문목록</span></a><br>
                <a href="#"><span>찜리스트</span></a><br>
                <a href="#"><span>장바구니</span></a><br>
                <a href="#"><span>내가등록한상품</span></a>
            </div>
            <hr>
            <div class="info">
                <a href="#"><span>개인정보확인/수정</span></a><br>
                <a href="#"><span>배송지 관리</span></a>
            </div>


        </div>
        <div class="payment-box">
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
                                                            <button class="cartButton custom-btn btn-4" value="${item.productId}" onclick="">장바구니 담기</button>
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
    </div>
</div>
</body>
</html>
