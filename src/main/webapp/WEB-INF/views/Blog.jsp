<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
    <title>The Blog</title>
    <link type="text/css" rel="stylesheet" href="<c:url value="/resources/css/default.css"/>"/>
    <link type="text/css" rel="stylesheet" href="<c:url value="/resources/css/Boxes.css"/>"/>
    <link type="text/css" rel="stylesheet" href="<c:url value="/resources/css/Blog.css"/>"/>
    <style type="text/css">
        .postsBox {
            width: 80%;
        }
    </style>
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
    <div class="menu">
        <div class="addButton" onclick="window.location.href='/blog/add'">
            Add post
        </div>
    </div>
    <div class="postsBox">
        <c:choose>
            <c:when test="${posts.size() == 0}" >
                <b>You do not have any posts</b>
            </c:when>
            <c:otherwise>
                <form id="form1" method="get">
                    <table>
                        <tr>
                            <th>№</th>
                            <th>Title</th>
                            <th>Text</th>
                            <th>Date</th>
                        </tr>
                        <c:forEach items="${posts}" var="post" >
                            <tr onclick="window.location.href='/blog/post/${post.postId}'">
                                <td>${posts.indexOf(post) + 1}</td>
                                <td>${post.title}</td>
                                <td>${post.text}</td>
                                <td>${post.date}</td>
                            </tr>
                        </c:forEach>
                    </table>
                    <input id="0071" type="hidden" name="hideId">
                    <c:choose>
                        <c:when test="${pages > 1}">
                            <br>
                            <input id="007" type="hidden" name="hide" value="${page}">
                            <c:choose>
                                <c:when test="${page > 4}">
                                    <span class="fake-link" id="${1}" onclick="submitData(this.id, '007')">${1}</span> ...
                                </c:when>
                            </c:choose>
                            <c:forEach begin="${page > 4 ? page - 2 : 1}" end="${page + 4 > pages ? pages : page + 2}" var="pageId">
                                <c:choose>
                                    <c:when test="${page == pageId}">
                                        <span class="fake-link currentPage" id="${pageId}" onclick="submitData(this.id, '007')">${pageId}</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="fake-link" id="${pageId}" onclick="submitData(this.id, '007')">${pageId}</span>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>
                            <c:choose>
                                <c:when test="${page + 4 <= pages}">
                                    ... <span class="fake-link" id="${pages}" onclick="submitData(this.id, '007')">${pages}</span>
                                </c:when>
                            </c:choose>
                        </c:when>
                    </c:choose>
                </form>
            </c:otherwise>
        </c:choose>
    </div>
</div>
<div class="footer">
    © 2017 Blog
</div>
</body>
</html>
