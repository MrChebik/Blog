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
    <script type="text/javascript" src="<c:url value="/resources/js/logout.js"/>"></script>
    <style>
        #box0 {
            display: block !important;
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
            <li onclick="window.location.href='/blog/{username}/';"><span>View</span></li>
            <li onclick="window.location.href='/blog/news/';"><span>News</span></li>
            <li onclick="window.location.href='/blog/setting/';"><span>Setting</span></li>
            <li onclick="logout()"><span>Logout</span></li>
        </ul>
    </div>
</div>
<div class="center">
    <div class="postsBox">
        <c:if test="${maxLevel != -2}">
            <c:forEach var="i" begin="0" end="${maxLevel+1}">
                <div id="box${i}" style="display: ${i == 0 ? 'block' : 'none'};">
                    <select id="select${i}" onclick="checkSelects(this, ${i}, ${maxLevel})">
                        <option selected class="space-display"></option>
                        <c:forEach items="${categories}" var="category">
                            <c:if test="${category.level == i-1}">
                                <option id="${category.categoryId}" data-name="${category.parentId}">
                                    ${category.name}
                                </option>
                            </c:if>
                        </c:forEach>
                    </select>
                </div>
            </c:forEach>
        </c:if>
        <div class="postCreateBox">
            <form id="form1" method="post">
                <input id="title" type="text" name="title" oninput="check()" placeholder="Title" value="${post.title}" onload="check()">
                <textarea id="text" name="text" placeholder="Text">${post.text}</textarea>
                <input id="catId" name="catId" type="hidden">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
            </form>
        </div>
        <div class="menu">
            <div class="addButton" onclick="checkError(${maxLevel})">
                <c:choose>
                    <c:when test="${post.title != null}">
                        Save post
                    </c:when>
                    <c:otherwise>
                        Add post
                    </c:otherwise>
                </c:choose>
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
