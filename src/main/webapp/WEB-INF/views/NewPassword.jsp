<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: mrchebik
  Date: 17.01.17
  Time: 19:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link type="text/css" rel="stylesheet" href="<c:url value="/resources/css/default.css"/>"/>
    <link type="text/css" rel="stylesheet" href="<c:url value="/resources/css/Auth.css"/>"/>
    <link type="text/css" rel="stylesheet" href="<c:url value="/resources/css/Boxes.css"/>"/>
    <script type="text/javascript" src="<c:url value="/resources/js/Auth.js"/>"></script>
</head>
<body>
<div class="top">
    Blog <span class="header">New Password</span>
</div>
<div class="center">
    <div class="centerBox">
        <form id="form1" method="post">
            <input id="password" type="password" name="password" required placeholder="Password" oninput="check('password')">
            <input id="passwordConfirm" type="password" name="passwordConfirm" required placeholder="Password Confirm" oninput="check('passwordConfirm')">
            <div class="button" onclick="checkError()">
                Send
            </div>
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
        </form>
    </div>
</div>
<div class="footer">
    <hr class="footer">
    © 2017 Blog
</div>
</body>
</html>
