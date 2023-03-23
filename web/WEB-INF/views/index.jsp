<%--
  Created by IntelliJ IDEA.
  User: sabum
  Date: 2023-03-20
  Time: 오후 1:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link href="/resources/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN"
            crossorigin="anonymous"></script>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.11.2/css/all.min.css">
    <link rel="stylesheet" type="text/css" href="/resources/css/index.css">

<%--    swiper--%>
    <link rel="stylesheet" href="https://unpkg.com/swiper@7/swiper-bundle.min.css" />
    <script src="https://unpkg.com/swiper@7/swiper-bundle.min.js"></script>

    <script defer src="/js/main/index.js"></script>
    <title>인덱스</title>
</head>
<body>
<%@include file="main/header_nav.jsp"%>
<div class="inner">
    <section class="brand">
        <img src="/resources/images/main/brand.png">
    </section>
    <section class="notice">
        <div class="promotion">
            <div class="swiper-container">
                <!-- swiper라이브러리를 사용할려면 필수적으로 swiper-wrapper 클래스를 생성해줘야함 -->
                <div class="swiper-wrapper">
                    <div class="swiper-slide">
                        <img src="/resources/images/main/notice1.png" alt="beom mall 이미지에러" />
                        <a href="javascript:void(0)" class="btn">자세히 보기</a>
                    </div>
                    <div class="swiper-slide">
                        <img src="/resources/images/main/notice2.png" alt="beom mall 이미지에러" />
                        <a href="javascript:void(0)" class="btn">자세히 보기</a>
                    </div>
                    <div class="swiper-slide">
                        <img src="/resources/images/main/notice3.png" alt="beom mall 이미지에러" />
                        <a href="javascript:void(0)" class="btn">자세히 보기</a>
                    </div>
                    <div class="swiper-slide">
                        <img src="/resources/images/main/notice4.png" alt="beom mall 이미지에러" />
                        <a href="javascript:void(0)" class="btn">자세히 보기</a>
                    </div>
                </div>
            </div>
            <div class="swiper-pagination"></div>
            <div class="swiper-prev">
                <div class="material-icons">arrow_back</div>
            </div>
            <div class="swiper-next">
                <div class="material-icons">arrow_forward</div>
            </div>
        </div>
    </section>
</div>

</body>
</html>