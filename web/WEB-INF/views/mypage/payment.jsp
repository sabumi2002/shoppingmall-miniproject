<%--
  Created by IntelliJ IDEA.
  User: sabum
  Date: 2023-03-29
  Time: 오후 8:00
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
    <link rel="stylesheet" href="/resources/css/mypage/payment.css">
    <script defer src="/js/mypage/payment.js"></script>

    <title>Title</title>
</head>
<%@include file="../main/header_nav.jsp" %>
<body>
<div class="inner">
    <div class="page-tit four">
        <h1><span>Beom Mall</span> Product <em>Payment</em> Page</h1>
    </div>
    <div class="form-box">
        <div class="delivery-box">
            <h4><span>배송 옵션</span></h4>
            <hr>
            <div class="info">
                <p>닉네임: ${logIn.nickname}</p>
                <p>배송지: ${addressDTO.streetAddress} , ${addressDTO.detailedAddress}</p>
                <p>지번: ${addressDTO.zipCode}</p>
                <p>전화번호: ${logIn.phoneNumber}</p>
            </div>
            <hr>
            <div class="button-box text-center">
                <button class="payButton custom-btn btn-4" onclick="paymentButton()">결제하기</button>
            </div>

        </div>
        <div class="payment-box">
            <div class="total-box">
                <h4><span>결제 정보</span></h4>
                <hr>
                <div class="info">
                    <div class="d-flex">
                        <span class="tit">상품금액</span>

                        <div class="price-box title">
                            <c:if test="${discount ne null}">
                                <span>${discount}%</span>
                                <span class="origin-price">${totalOriginPrice}원</span>
                            </c:if>

                            <p class="total-price">${totalPrice}원</p>
                        </div>

                    </div>
                    <div class="d-flex">
                        <span class="tit">배송비</span>
                        <span class="data">${totalDeliPrice}원</span>
                    </div>
                    <div class="d-flex">
                        <span class="tit">총 결제 금액</span>
                        <span class="finalPrice data">${finalPrice}원</span>
                    </div>
                </div>
            </div>
            <hr>
            <div class="itemList">
                <c:set var="date" value=""/>
                <c:forEach items="${deliDateList}" var="item" varStatus="status">

                    <c:if test="${date ne item}">
                        <div class="itemDateList">
                            <div class="date">
                                <span>${deliDateList[status.index]}</span>

                                <c:forEach items="${cartList}" var="item2" varStatus="status2">
                                    <c:if test="${deliDateList[status2.index] eq item}">
                                        <div class="item">
                                            <div class="info">
                                                <div class="img-box">
                                                    <img src="${productList[status2.index].img}">
                                                </div>
                                                <div class="data-box">
                                                    <p class="tit">${productList[status2.index].title}</p>
                                                    <span>수량: </span>
                                                    <span>${item2.count}</span>
                                                    <span> / </span>
                                                    <span>${productList[status2.index].price}</span>
                                                    <p>${cartItemSumPrice[status2.index]}</p>
                                                </div>
                                            </div>
                                        </div>
                                    </c:if>

                                </c:forEach>
                                <c:set var="date" value="${item}"/>
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
