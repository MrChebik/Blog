<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: mrchebik
  Date: 20.01.17
  Time: 23:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Blog - Add post</title>
    <link type="text/css" rel="stylesheet" href="<c:url value="/resources/css/default.css"/>"/>
    <link type="text/css" rel="stylesheet" href="<c:url value="/resources/css/Boxes.css"/>"/>
    <link type="text/css" rel="stylesheet" href="<c:url value="/resources/css/Blog.css"/>"/>
    <link type="text/css" rel="stylesheet" href="<c:url value="/resources/css/Add.css"/>"/>
    <script type="text/javascript" src="<c:url value="/resources/js/Title.js"/>"></script>
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
            <li onclick="window.location.href='/blog/news/';"><span>News</span></li>
            <li onclick="window.location.href='/blog/setting/';"><span>Setting</span></li>
            <li onclick="window.location.href='/blog/logout/';"><span>Logout</span></li>
        </ul>
    </div>
</div>
<div class="center">
    <div class="postsBox">
        <div class="postCreateBox">
            <form id="form1" method="post">
                <input id="title" type="text" name="title" oninput="check(this.id)" placeholder="Title">
                <textarea id="text" name="text" placeholder="Text"></textarea>
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
            </form>
        </div>
        <div class="menu">
            <div class="addButton" onclick="checkError()">
                Add post
            </div>
        </div>
    </div>
</div>
<div class="footer">
    <hr class="footer">
    © 2017 Blog
</div>
</body>
</html>
