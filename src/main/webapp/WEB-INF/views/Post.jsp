<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: mrchebik
  Date: 14.01.17
  Time: 11:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Blog - ${username}</title>
    <link type="text/css" rel="stylesheet" href="<c:url value="/resources/css/default.css"/>"/>
    <link type="text/css" rel="stylesheet" href="<c:url value="/resources/css/Boxes.css"/>"/>
    <link type="text/css" rel="stylesheet" href="<c:url value="/resources/css/Blog.css"/>"/>
</head>
<body>
<div class="top">
    <div class="blog">
        Blog
    </div>
    <div class="bar">
        <ul id="navbar">
            <li onclick="window.location.href='/blog/';"><span>Home</span></li>
            <li onclick="window.location.href='/blog/{username}/';"><span>View</span></li>
            <li onclick="window.location.href='/blog/news';"><span>News</span></li>
            <li onclick="window.location.href='/blog/setting/';"><span>Setting</span></li>
            <li onclick="window.location.href='/blog/logout/';"><span>Logout</span></li>
        </ul>
    </div>
</div>
<div class="center">
    <div class="postBox">
        <div class="categoryBox"></div>
        <div class="titleBox">
            ${post.title}
        </div>
        <hr>
        <div class="textBox">
            ${post.text}
        </div>
        <hr class="date">
        <div class="dateBox">
            ${post.date}
        </div>
        <div class="commentBox"></div>
    </div>
</div>
<div class="footer">
    © 2017 Blog
</div>
</body>
</html>
