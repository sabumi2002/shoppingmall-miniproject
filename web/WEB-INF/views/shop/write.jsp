<%--
  Created by IntelliJ IDEA.
  User: sabum
  Date: 2023-03-24
  Time: 오후 7:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <script src="/resources/js_library/build/ckeditor.js"></script>
  <script defer src="/js/shop/write.js"></script>
  <link href="/resources/css/bootstrap.min.css" rel="stylesheet">
  <link href="/resources/css/shop/write.css" rel="stylesheet">

<%--  sweetalert2--%>
  <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<%--  jquery--%>
  <script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
  <style>
    .ck-editor__editable{
      height:500px;
      color:black;
    }
  </style>
    <title>Title</title>
</head>
<%@include file="../main/header_nav.jsp"%>
<body>
<div>
  <div class="inner">
    <div class="img_box">
      <img id="previewImg" width="700" alt="이미지 영역"/>
    </div>
    <form enctype="multipart/form-data" action="/shop/writeLogic" method="post" class="data_box">
      <div class="input-group mb-3">
        <span class="input-group-text">상품 이름:</span>
        <input type="text" id="input-title" name="title" class="form-control"
               aria-label="Sizing example input"
               aria-describedby="inputGroup-sizing-default">
      </div>
      <div class="input-group mb-3">
        <span class="input-group-text">브랜드:</span>
        <input type="text" id="input-brand" name="brand" class="form-control"
               aria-label="Sizing example input"
               aria-describedby="inputGroup-sizing-default">
      </div>
      <div class="input-group mb-3">
        <span class="input-group-text">가격:</span>
        <input type="text" id="input-price" name="price" class="form-control"
               aria-label="Sizing example input"
               aria-describedby="inputGroup-sizing-default">
      </div>

      <p>배송사 : <select class="form-select form-select-lg mb-3" id="input-deliveryId"
                       aria-label=".form-select-lg example"
                       name="deliveryId">
        <option value="1" selected>cj</option>
        <option value="2">롯데</option>
        <option value="3">한진</option>
        <option value="4">우체국</option>
      </select>

      <div class="input-group mb-3">
        <span class="input-group-text">남은수량:</span>
        <input type="text" id="input-remaining" name="remaining" class="form-control"
               aria-label="Sizing example input"
               aria-describedby="inputGroup-sizing-default">
      </div>


      <div class="input-group mb-3">
        <input type="file" id="input-file" class="form-control" name="file">
        <label class="input-group-text" for="input-file">Upload</label>
      </div>

      <td colspan="2">
        <textarea id="editor" name="content"></textarea>
      </td>


      <div class="util">
        <button type="button" class="cancel" onclick="location.href='/shop/showAll'">
          취소
        </button>
<%--        <button type="submit" class="check" onclick="fileUpload()">--%>
        <button type="submit" class="check">
          확인
        </button>
      </div>
    </form>

  </div>
</div>
</body>
<script>
  ClassicEditor.create(document.querySelector('#editor'), {
    style: {
      height: 100
    }
  }).catch(error => {
    console.log(error);
  });
</script>
</html>
