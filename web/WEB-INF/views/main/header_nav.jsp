<%@ page import="com.bit.spring.model.UserDTO" %>
<%@ page import="java.util.List" %>
<%@ page import="com.bit.spring.model.CategoryDTO" %><%--<%@ page import="model.UserDTO" %>&lt;%&ndash;--%>
<%--  Created by IntelliJ IDEA.--%>
<%--  User: Sabeom--%>
<%--  Date: 2023-02-21--%>
<%--  Time: 오전 11:09--%>
<%--  To change this template use File | Settings | File Templates.--%>
<%--&ndash;%&gt;--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<head>
    <%
        pageContext.setAttribute("logIn", (UserDTO) session.getAttribute("logIn"));
    %>
    <link href="/resources/css/main/nav.css" rel="stylesheet">


    <script defer src="/js/main/nav.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
    <%--    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"--%>
    <%--            integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN"--%>
    <%--            crossorigin="anonymous"></script>--%>
</head>

<%--onload="initNav()"--%>
<body onload="initNav()">
<header class="navbar-light bg-light">
    <div class="container">
        <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <div style="flex-wrap: nowrap;" class="container-fluid">
                <div style="display: flex; flex-wrap: nowrap;" class="align-items-center">
                    <button style="display: inline-block" class="navbar-toggler h-50" type="button" data-bs-toggle="collapse"
                            data-bs-target="#navbarHeader"
                            aria-controls="navbarHeader" aria-expanded="false" aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <a href="/" class="navbar-brand">
                        <%--                <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" aria-hidden="true" class="me-2" viewBox="0 0 24 24"><path d="M23 19a2 2 0 0 1-2 2H3a2 2 0 0 1-2-2V8a2 2 0 0 1 2-2h4l2-3h6l2 3h4a2 2 0 0 1 2 2z"/><circle cx="12" cy="13" r="4"/></svg>--%>
                        <img src="/resources/images/main/logo.png" alt="logo"/>
                    </a>
                </div>
                <%--            <a class="navbar-brand" href="#">Navbar</a>--%>

                <form class="search d-flex justify-content-end align-items-center" action="" method="get">
                    <input class="form-control h-50" type="search" placeholder="Search" name="keyword">
                    <button class="h-50" type="submit">Search</button>
                </form>

                <div class="d-flex">
                    <c:choose>
                        <c:when test="${logIn eq null}">
                            <button class="navbar-login"
                                    onclick="location.href='/user/login'">
                                <svg xmlns="http://www.w3.org/2000/svg" width="40" height="40" fill="currentColor"
                                     class="bi bi-person-fill" viewBox="0 0 16 16">
                                    <path d="M3 14s-1 0-1-1 1-4 6-4 6 3 6 4-1 1-1 1H3Zm5-6a3 3 0 1 0 0-6 3 3 0 0 0 0 6Z"/>
                                </svg>
                            </button>

                        </c:when>
                        <c:otherwise>
                            <ul id="logout" class="navbar-nav">
                                <li class="nav-item dropdown">
                                    <a class="nav-link dropdown-toggle" data-bs-toggle="dropdown" href="#" role="button"
                                       aria-haspopup="true" aria-expanded="false">${logIn.nickname}</a>
                                    <div class="dropdown-menu">
                                        <a class="dropdown-item" href="/user/logOut">로그아웃</a>
                                        <a class="dropdown-item" href="/mypage/showMypage">마이페이지</a>
                                        <a class="dropdown-item" href="/user/updateDelete">개인정보수정</a>
                                        <a class="dropdown-item" href="/address/manager">배송지 관리</a>
                                        <a class="dropdown-item" href="/shop/write">상품 등록</a>

                                            <%--                                <a class="dropdown-item" href="#">Something else here</a>--%>
                                            <%--                                <div class="dropdown-divider"></div>--%>
                                            <%--                                <a class="dropdown-item" href="#"></a>--%>
                                    </div>
                                </li>
                            </ul>
                        </c:otherwise>
                    </c:choose>
                    <button class="navbar-cart"
                            onclick="location.href='/mypage/showBasket'">
                        <img src="/resources/images/main/shopping_cart.png">
                    </button>
                </div>
                <%--                </div>--%>
            </div>
        </nav>
        <div class="collapse navbar-light bg-light" id="navbarHeader">
            <div class="container">
                <div class="row">
                    <ul id="hederMenu" class="headerMenu">
                        <li class="current">
                            <a href="/shop/showAll">전체</a>
                        </li>
                        <c:forEach items="${categoryList}" var="item">
                            <li class="current">
                                <a href="/shop/showAll?id=${item.id}">${item.category}</a>
                            </li>
                        </c:forEach>

                    </ul>
                </div>
            </div>
        </div>
    </div>
</header>
</body>
