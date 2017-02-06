<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: mrchebik
  Date: 14.01.17
  Time: 11:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Blog - Setting</title>
    <link type="text/css" rel="stylesheet" href="<c:url value="/resources/css/default.css"/>"/>
    <link type="text/css" rel="stylesheet" href="<c:url value="/resources/css/Boxes.css"/>"/>
    <link type="text/css" rel="stylesheet" href="<c:url value="/resources/css/Blog.css"/>"/>
    <script type="text/javascript" src="<c:url value="/resources/js/Profile.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/resources/js/logout.js"/>"></script>
    <style>
        .editButton {
            position: relative;
        }
    </style>
</head>
<body>
<form action="<c:url value="/logout"/>" method="post" id="logoutForm">
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
</form>
<div class="top">
    <div class="blog">
        Blog
    </div>
    <div class="bar">
        <ul id="navbar">
            <li onclick="window.location.href='/blog/';"><span>Home</span></li>
            <li onclick="window.location.href='/blog/${username}/';"><span>View</span></li>
            <li onclick="window.location.href='/blog/news';"><span>News</span></li>
            <li onclick="window.location.href='/blog/setting/';"><span>Setting</span></li>
            <li onclick="logout()"><span>Logout</span></li>
        </ul>
    </div>
</div>
<div class="center">
    <div class="postsBox">
        <form id="form1" method="post">
            <input type="password" name="oldPasswordUser" placeholder="Old password" oninput="checkSetting(this)">
            <input type="text" name="username" placeholder="Username" oninput="checkSetting(this)">
            <div class="editButton" onclick="checkError('username')">Edit username</div>
            <hr>
            <input type="password" name="oldPassword" placeholder="Old password" oninput="checkSetting(this)">
            <input type="password" name="newPassword" placeholder="New password" oninput="checkSetting(this)">
            <input type="password" name="passwordConfirm" placeholder="Password confirm" oninput="checkSetting(this)">
            <div class="editButton" onclick="checkError('password')">Edit password</div>
            <hr>
            <input type="text" name="email" placeholder="Email" oninput="checkSetting(this)">
            <div class="editButton" onclick="checkError('email')">Edit email</div>
            <input type="hidden" name="type">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
            <hr>
            <span class="fake-link" onclick="window.location.href='/blog/setting/delete'">Delete profile</span>
        </form>
    </div>
</div>
<div class="footer">
    <hr class="footer">
    © 2017 Blog
</div>
</body>
</html>
