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
    <link type="text/css" rel="stylesheet" href="<c:url value="/resources/css/Add.css"/>"/>
    <style>
        #text {
            height: 100px;
            border: none;
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
        <hr class="date">
        <div class="commentBox">
            <c:choose>
                <c:when test="${comments.size() != 0}">
                    <c:forEach items="${comments}" var="comment" >
                        <div class="comment">
                            <div class="commentUser">
                                ${comment.user.username}
                            </div>
                            <div class="commentText">
                                ${comment.text}
                            </div>
                            <div class="commentDate">
                                ${comment.date}
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
            </c:choose>
            <c:if test="${user != null && (pages == 0 || page == pages)}">
                <div class="comment">
                    <div class="commentText">
                        <form id="form1" method="post">
                            <textarea id="text" name="text" required placeholder="Text"></textarea>
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                        </form>
                    </div>
                    <div class="addButton" onclick="document.getElementById('form1').submit()">
                        Add comment
                    </div>
                </div>
            </c:if>
            <c:if test="${comments.size() != 0}">
                <form id="form2" method="get">
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
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                </form>
            </c:if>
        </div>
    </div>
</div>
<div class="footer">
    © 2017 Blog
</div>
</body>
</html>
