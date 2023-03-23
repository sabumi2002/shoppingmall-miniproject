<%--
  Created by IntelliJ IDEA.
  User: sabum
  Date: 2023-03-21
  Time: 오후 4:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>회원가입</title>
    <link href="/resources/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN"
            crossorigin="anonymous"></script>
</head>
<body>
<div class="container">
    <div class="row h-100 align-items-center">
        <div class="row justify-content-center">
            <div class="col-8 justify-content-center">
                <div class="row">
                    <div class="col-6">
                        <c:if test="${not empty message}">
                            <div class="alert alert-dismissible alert-danger">
                                <h3>${message}</h3>
                            </div>
                        </c:if>
                    </div>
                </div>
                <form action="/user/register" method="post">
                    <div class="row">
                        <div class="col justify-content-center">
                            <label for="input-username">아이디</label>
                            <input type="text" name="username" class="form-control" id="input-username"><br>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col">
                            <label for="input-password">비밀번호: </label>
                            <input type="password" name="password" class="form-control" id="input-password"><br>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col">
                            <label for="input-nickname">닉네임: </label>
                            <input type="text" name="nickname" class="form-control" id="input-nickname"><br>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col">
                            <label for="input-phoneNumber">전화번호: </label>
                            <input type="text" name="nickname" class="form-control" id="input-phoneNumber"><br>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col">
                            <label for="input-address">기본 배송지: </label>
                            <input type="text" name="nickname" class="form-control" id="input-address"><br>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col">
                            <button type="submit" class="btn btn-outline-primary">회원 가입</button>
                        </div>
                    </div>

                </form>

            </div>
        </div>
    </div>
</div>

</body>
</html>
