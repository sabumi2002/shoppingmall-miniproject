<%--
  Created by IntelliJ IDEA.
  User: sabum
  Date: 2023-03-23
  Time: 오후 7:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es" dir="ltr">

<head>
    <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0">
    <meta charset="utf-8">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;700;800&display=swap" rel="stylesheet">

    <link rel="stylesheet" type="text/css" href="/resources/css/user/address.css">
    <script defer src="/js/user/address.js"></script>

    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>

    <title>update/delete</title>
</head>
<%@include file="../main/header_nav.jsp" %>
<body>
<input id="state" type="hidden" value="${state}">

<div class="main">
    <div class="container a-container" id="a-container">
        <form class="form" method="post" action="/address/insert">
            <h2 class="form_title title">Address Management</h2>
            <div class="form__icons">
                    <a id="home" class="switch__button button" onclick="location.href='/'">홈으로</a>
            </div>
            <span class="form__span"></span>
            <%--            <div class="align-items-center" id="insert-form">--%>
            <p>
                <input type="text" class="form__input" id="zip-code" name="zipCode" placeholder="우편번호" readonly>
                <input type="button" class="switch__button address-button" onclick="execDaumPostcode()"
                       value="우편번호 찾기">
            </p>

            <input type="text" id="address-1" name="streetAddress" placeholder="도로명주소" class="form__input" readonly>

            <input type="text" id="address-1-1" name="numberAddress" placeholder="지번주소" class="form__input"
                   readonly>

            <input type="text" id="address-2" name="detailedAddress" placeholder="상세주소" class="form__input">
            <%--            </div>--%>
            <%--            <input class="form__input" type="text" placeholder="address" name="address">--%>
            <button type="submit" class="switch__button button">INSERT</button>
        </form>
    </div>
    <div class="container b-container" id="b-container">
        <div class="form">
            <h2 class="switch__description description">선택된 배송지</h2>
            <h2 id="baseAddress" class="switch__description description"></h2>
            <div class="form__icons">
                <button id="base-button" class="switch__button button" onclick="baseButton()">기본배송지로 변경</button>
                <button id="delete-button" class="switch__button button" value="" onclick="deleteButton()">Delete
                </button>
            </div>
            <form id="update-form" class="form" method="post" action="/address/update/31">

                <span class="form__span"></span>
                <p>
                    <input type="text" class="form__input" id="zip-code2" name="zipCode" placeholder="우편번호" readonly>
                    <input type="button" class="switch__button address-button" onclick="execDaumPostcode2()"
                           value="우편번호 찾기">
                </p>

                <input type="text" id="address2-1" name="streetAddress" placeholder="도로명주소" class="form__input"
                       readonly>

                <input type="text" id="address2-1-1" name="numberAddress" placeholder="지번주소" class="form__input"
                       readonly>

                <input type="text" id="address2-2" name="detailedAddress" placeholder="상세주소" class="form__input">

                <button type="submit" class="switch__button button">Update</button>
            </form>
        </div>
    </div>
    <div class="switch" id="switch-cnt">
        <div class="switch__circle"></div>
        <div class="switch__circle switch__circle--t"></div>
        <div class="switch__container" id="switch-c1">
            <h2 class="switch__description description">기본배송지</h2>
            <h2 class="switch__description description">${baseAdr.streetAddress}, ${baseAdr.detailedAddress}</h2>
            <hr>
            <c:forEach items="${list}" var="item">
                <button id="address" class="switch__button button switch-btn"
                        onclick="switchUpdate('${item.id}', '${item.streetAddress}', '${item.detailedAddress}')">${item.streetAddress}, ${item.detailedAddress}</button>
            </c:forEach>
            <p class="switch__description description">수정하시려면 주소지를 클릭해주세요.</p>
        </div>
        <div class="switch__container is-hidden" id="switch-c2">
            <h2 class="switch__title title">뒤로가기</h2>
            <p class="switch__description description">전체 배송지 보기</p>
            <button class="switch__button button switch-btn" onclick="">Back</button>
        </div>
    </div>
</div>
</body>

</html>
