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
    <title>Blog - ${post.title}</title>
    <link type="text/css" rel="stylesheet" href="<c:url value="/resources/css/default.css"/>"/>
    <link type="text/css" rel="stylesheet" href="<c:url value="/resources/css/Boxes.css"/>"/>
    <link type="text/css" rel="stylesheet" href="<c:url value="/resources/css/Blog.css"/>"/>
    <link type="text/css" rel="stylesheet" href="<c:url value="/resources/css/Add.css"/>"/>
    <script type="text/javascript" src="<c:url value="/resources/js/submit.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/resources/js/logout.js"/>"></script>
    <style>
        #text, #textComment {
            height: 100px;
            border: none;
        }

        .addButton {
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
            <li onclick="window.location.href='/blog/{username}/';"><span>View</span></li>
            <li onclick="window.location.href='/blog/news';"><span>News</span></li>
            <li onclick="window.location.href='/blog/setting/';"><span>Setting</span></li>
            <li onclick="logout()"><span>Logout</span></li>
        </ul>
    </div>
</div>
<div class="center">
    <c:if test="${user.username == username}">
        <div class="menu">
            <div class="editButton" onclick="window.location.href='/blog/post/${post.postId}/edit'">
                Edit post
            </div>
            <div class="removeButton" onclick="window.location.href='/blog/post/${post.postId}/remove'">
                Remove post
            </div>
        </div>
    </c:if>
    <div class="postsBox">
        <div class="postBox">
            <div class="titleBox">
                ${post.title}
            </div>
            <hr>
            <div class="categoryBox">
                ${categoryPath}
            </div>
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
                    <c:when test="${commentText != null}">
                        <div class="comment">
                            <div class="commentText">
                                <form id="form3" method="post">
                                    <textarea id="textComment" name="text" required placeholder="Text">${commentText}</textarea>
                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                                </form>
                            </div>
                        </div>
                    </c:when>
                    <c:otherwise>
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
                                        <c:if test="${user.username == comment.user.username}">
                                            <div class="edit fake-link" onclick="window.location.href='/blog/post/${post.postId}/comment/${comment.commentId}/edit'">
                                                Edit
                                            </div>
                                        </c:if>
                                        <c:if test="${user.username == username || user.username == comment.user.username}">
                                            <div class="remove fake-link" onclick="window.location.href='/blog/post/${post.postId}/comment/${comment.commentId}/remove'">
                                                Remove
                                            </div>
                                        </c:if>
                                    </div>
                                </c:forEach>
                            </c:when>
                        </c:choose>
                        <c:if test="${user != null && (pages == 0 || page == pages)}">
                            <div class="comment">
                                <div class="commentText">
                                    <form id="form1" method="post">
                                        <textarea id="text" name="text" required placeholder="Text"></textarea>
                                        <input id="0072" type="hidden" name="hide" value="${page}">
                                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                                    </form>
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
                    </c:otherwise>
                </c:choose>
            </div>
            <c:choose>
                <c:when test="${user != null && (pages == 0 || page == pages) && commentText == null}">
                    <div class="addButton" onclick="document.getElementById('form1').submit()">
                        Add comment
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="addButton" onclick="document.getElementById('form3').submit()">
                        Save comment
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>
<div class="footer">
    <hr class="footer">
    © 2017 Blog
</div>
</body>
</html>
