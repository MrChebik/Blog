<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
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
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

    <link type="text/css" rel="stylesheet" href="<c:url value="/resources/css/News.css"/>"/>
    <script type="text/javascript" src="<c:url value="/resources/js/logout.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/resources/js/News.js"/>"></script>
    <c:if test="${principal != null}">
        <link type="text/css" rel="stylesheet" href="<c:url value="/resources/css/Blog.css"/>"/>
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
                <li onclick="window.location.href='/blog/${username}/';"><span>View</span></li>
                <li onclick="window.location.href='/blog/news';"><span>News</span></li>
                <li onclick="window.location.href='/blog/setting/';"><span>Setting</span></li>
                <li onclick="logout()"><span>Logout</span></li>
            </ul>
        </div>
    </div>
<div class="container-fluid">
    <div class="row">
        <div class="col-md-12 logo">
            Blog
        </div>
        <div class="col-md-8 col-md-offset-1">
            <div class="panel panel-default">
                <div class="panel-body">
                    <div class="panel panel-info">
                        <div class="panel-heading">News</div>
                        <div class="panel-body">
                            <b>05.02.17</b> — Added ability to add many categories to the post.<br>
                            <b>04.02.17</b> — Added ability to subscribe to the other user and see their posts in the news page, notify about new posts from writers, logout.<br>
                            <b>03.02.17</b> — Added ability to edit your profile.<br>
                            <b>02.02.17</b> — Added ability to delete and edit categories.<br>
                            <b>01.02.17</b> — Added ability to use categories.<br>
                            <b>28.01.17</b> — Added ability to create a categories, but not use them.<br>
                            <b>26.01.17</b> — Added the ability to edit/remove posts, comments.<br>
                            <b>24.01.17</b> — Added the ability to add comments.<br>
                            <b>21.01.17</b> — Added the ability to add posts.<br>
                            <b>17.01.17</b> — Added a password recovery by email.<br>
                            <b>16.01.17</b> — Added an authorization.<br>
                            <b>15.01.17</b> — Created a local structure of classes.
                        </div>
                    </div>
                </div>
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
                            <c:choose>
                                <c:when test="${pages > 1}">
                                    <br>
                                    <ul class="pagination">
                                        <input id="007" type="hidden" name="hide" value="${page}">
                                        <c:choose>
                                            <c:when test="${page > 4}">
                                                <li><span class="fake-link" id="${1}" onclick="submitData(this.id, '007')">${1}</span> ...</li>
                                            </c:when>
                                        </c:choose>
                                        <c:forEach begin="${page > 4 ? page - 2 : 1}" end="${page + 4 > pages ? pages : page + 2}" var="pageId">
                                            <c:choose>
                                                <c:when test="${page == pageId}">
                                                    <li><span class="fake-link currentPage" id="${pageId}" onclick="submitData(this.id, '007')">${pageId}</span></li>
                                                </c:when>
                                                <c:otherwise>
                                                    <li><span class="fake-link" id="${pageId}" onclick="submitData(this.id, '007')">${pageId}</span></li>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:forEach>
                                        <c:choose>
                                            <c:when test="${page + 4 <= pages}">
                                                <li>... <span class="fake-link" id="${pages}" onclick="submitData(this.id, '007')">${pages}</span></li>
                                            </c:when>
                                        </c:choose>
                                    </ul>
                                </c:when>
                            </c:choose>
                        </form>
                    </c:if>
                </div>
            </c:if>
        </div>
        <div class="col-md-2">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <div class="row">
                        <div class="col-md-6">
                            <a href="#" class="active" id="login-form-link">Login</a>
                        </div>
                        <div class="col-md-6">
                            <a href="#" id="register-form-link">Register</a>
                        </div>
                    </div>
                </div>
                <div class="panel-body">
                    <form id="login-form" action="<c:url value="/j_spring_security_check"/>" method="post">
                        <c:if test="${param.error != null}">
                            <span class="text-danger">
                                Invalid username or password.
                            </span>
                        </c:if>
                        <c:if test="${param.logout != null}">
                            <div class="alert alert-success">
                                <strong>Success!</strong> You have been logged out.
                            </div>
                        </c:if>
                        <div class="form-group">
                            <input class="form-control" type="text" id="login-username" name="username" placeholder="Username" oninput="check(this.id)">
                        </div>
                        <div class="form-group">
                            <input class="form-control" type="password" id="login-password" name="password" placeholder="Password" oninput="check(this.id)">
                        </div>
                        <div class="form-group">
                            <div class="row">
                                <div class="col-md-6 col-md-offset-3">
                                    <button type="button" class="btn btn-success btn-block" onclick="checkError('login-form')">
                                        Sign in
                                    </button>
                                </div>
                            </div>
                        </div>
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                        <div class="form-group no-margin-bottom">
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="text-center">
                                        <a href="<c:url value="/auth/forgot"/>" class="btn btn-link" role="button">
                                            Forgot password
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </form>
                    <form:form id="register-form" action="/auth/register" method="post" modelAttribute="userForm" style="display: none">
                        <c:if test="${param.errorReg != null}">
                            <div class="alert alert-danger">
                                <strong>Error!</strong> Duplicate user.
                            </div>
                        </c:if>
                        <div class="form-group">
                            <spring:bind path="email">
                                <input class="form-control" id="register-email" type="text" name="email" placeholder="Email" oninput="check(this.id)">
                            </spring:bind>
                        </div>
                        <div class="form-group">
                            <spring:bind path="username">
                                <input class="form-control" id="register-username" type="text" name="username" placeholder="Username" oninput="check(this.id)">
                            </spring:bind>
                        </div>
                        <div class="form-group">
                            <spring:bind path="password">
                                <input class="form-control" id="register-password" type="password" name="password" placeholder="Password" oninput="check(this.id)">
                            </spring:bind>
                        </div>
                        <div class="form-group">
                            <input class="form-control" id="register-passwordConfirm" type="password" name="passwordConfirm" placeholder="Password Confirm" oninput="check(this.id)">
                        </div>
                        <div class="form-group no-margin-bottom">
                            <div class="row">
                                <div class="col-md-6 col-md-offset-3">
                                    <button type="button" class="btn btn-success btn-block" onclick="checkError('register-form')">
                                        Sign up
                                    </button>
                                </div>
                            </div>
                        </div>
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                    </form:form>
                </div>
            </div>
        </div>
    </div>
    <div class="footer navbar-fixed-bottom">
        <hr>
        © 2017 Blog
    </div>
</div>
</body>
</html>
