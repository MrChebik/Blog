<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: mrchebik
  Date: 14.01.17
  Time: 11:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>The Blog</title>
    <link type="text/css" rel="stylesheet" href="<c:url value="/resources/css/default.css"/>"/>
    <link type="text/css" rel="stylesheet" href="<c:url value="/resources/css/Auth.css"/>"/>
    <link type="text/css" rel="stylesheet" href="<c:url value="/resources/css/Boxes.css"/>"/>
    <script type="text/javascript" src="<c:url value="/resources/js/Auth.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/resources/js/logout.js"/>"></script>
    <c:if test="${principal != null}">
        <link type="text/css" rel="stylesheet" href="<c:url value="/resources/css/Blog.css"/>"/>
        <style type="text/css">
            .loginBox {
                display: none;
            }

            .newsBox {
                margin-top: 25px;
                width: 80%;
            }

            .top {
                display: block !important;
            }

            .topMain {
                display: none !important;
            }
        </style>
    </c:if>
</head>
<body>
<form action="<c:url value="/logout"/>" method="post" id="logoutForm">
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
</form>
    <div class="top" style="display: none">
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
    <div class="top topMain">
        Blog
    </div>
    <div class="center">
        <div class="newsBox">
            <span class="news">News</span>
            <hr>
            <p>
                28.01.17 -- Added ability to create a categories, but not use them.<br>
                26.01.17 -- Added the ability to edit/remove posts, comments.<br>
                24.01.17 -- Added the ability to add comments.<br>
                21.01.17 -- Added the ability to add posts.<br>
                17.01.17 -- Added a password recovery by email.<br>
                16.01.17 -- Added an authorization.<br>
                15.01.17 -- Created a local structure of classes.
            </p>
        </div>
        <c:if test="${principal != null}">
            <div class="postsBox">
                <c:if test="${posts.size() != 0}">
                    <form id="form2" method="get">
                        <c:forEach items="${posts}" var="post" >
                            <div class="postBox">
                                ${post.user.username}
                                <div class="titleBox fake-link" onclick="window.location.href='/blog/${post.user.username}/post/${post.postId}'">
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
                            </div>
                        </c:forEach>
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
                </c:if>
            </div>
        </c:if>
        <div class="loginBox">
            <form id="form1" action="<c:url value="/j_spring_security_check"/>" method="post">
                <c:if test="${param.error != null}">
                    Invalid username or password.
                </c:if>
                <c:if test="${param.logout != null}">
                    You have been logged out.
                </c:if>
                <input id="username" type="text" name="username" required placeholder="Username" oninput="check('username')">
                <input id="password" type="password" name="password" required placeholder="Password" oninput="check('password')">
                <div class="button" onclick="checkError()">
                    Sign in
                </div>
                <a href="<c:url value="/auth/register"/>">Create an account</a> or
                <a href="<c:url value="/auth/forgot"/>">Forgot password</a>
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
