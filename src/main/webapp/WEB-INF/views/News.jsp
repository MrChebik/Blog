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

    <link type="text/css" rel="stylesheet" href="<c:url value="/resources/css/layout.css"/>"/>
    <link type="text/css" rel="stylesheet" href="<c:url value="/resources/css/logo.css"/>"/>
    <link type="text/css" rel="stylesheet" href="<c:url value="/resources/css/form.css"/>"/>
    <link type="text/css" rel="stylesheet" href="<c:url value="/resources/css/News.css"/>"/>
    <script type="text/javascript" src="<c:url value="/resources/js/News.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/resources/js/logout.js"/>"></script>
    <c:if test="${principal == null}">
        <style>
            nav {
                display: none;
            }

            body {
                padding-top: 0;
            }
        </style>
    </c:if>
    <c:if test="${principal != null}">
        <style>
            .logo {
                display: none;
            }

            .form {
                display: none;
            }
        </style>
    </c:if>
</head>
<body>
<form action="<c:url value="/logout"/>" method="post" id="logoutForm">
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
</form>
<nav class="navbar navbar-default navbar-fixed-top">
    <div class="container">
        <div class="navbar-header">
            <a class="navbar-brand" href="<c:url value="/blog"/>">Blog</a>
        </div>
        <ul class="nav navbar-nav">
            <li><a href="<c:url value="/blog"/>">Home</a></li>
            <li><a href="/blog/${username}">Global View</a></li>
            <li class="active"><a href="#">News</a></li>
            <li><a href="<c:url value="/blog/setting/"/>">Setting</a></li>
        </ul>
        <ul class="nav navbar-nav navbar-right">
            <li><a onclick="logout()"><span class="glyphicon glyphicon-log-out"></span> Logout</a></li>
        </ul>
    </div>
</nav>
<div class="container-fluid">
    <div class="row">
        <div class="col-md-12 logo">
            Blog
        </div>
        <div class="col-md-8 col-md-offset-${principal == null ? "1" : "2"}">
            <div class="panel panel-default">
                <div class="panel-body">
                    <div class="panel panel-info">
                        <div class="panel-heading">News</div>
                        <div class="panel-body">
                            <b>25.02.17</b> — Added cache.<br>
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
        </div>
        <c:if test="${principal != null}">
            <c:if test="${posts.size() != 0}">
                <c:forEach items="${posts}" var="post" >
                    <div class="col-md-8 col-md-offset-2">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                ${post.user.username}<br>
                                <a href="/blog/${post.user.username}/post/${post.postId}" class="btn btn-link" role="button">${post.title}</a><br>
                                ${categoriesPath.get(post.postId)}
                            </div>
                            <div class="panel-body">
                                ${post.text}
                            </div>
                            <div class="panel-footer">
                                ${post.date}
                            </div>
                        </div>
                    </div>
                </c:forEach>
                <div class="col-md-8 col-md-offset-2">
                    <c:if test="${pages > 1}">
                        <ul class="pagination">
                            <c:if test="${page > 4}">
                                <li><a href="<c:url value="/blog/news?page=1"/>">1</a> ...</li>
                            </c:if>
                            <c:forEach begin="${page > 4 ? page - 2 : 1}" end="${page + 4 > pages ? pages : page + 2}" var="pageId">
                                <li class="${page == pageId ? "active" : ""}"><a href="<c:url value="/blog/news?page=${pageId}"/>">${pageId}</a></li>
                            </c:forEach>
                            <c:if test="${page + 4 <= pages}">
                                <li>... <a href="<c:url value="/blog/news?page=${pages}"/>">${pages}</a></li>
                            </c:if>
                        </ul>
                    </c:if>
                </div>
            </c:if>
        </c:if>
        <div class="col-md-2 form">
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
                                You have been logged out.
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
                        <div class="row">
                            <div class="col-md-12">
                                <div class="text-center">
                                    <a href="<c:url value="/auth/forgot"/>" class="btn btn-link" role="button">
                                        Forgot password
                                    </a>
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
                        <div class="row">
                            <div class="col-md-6 col-md-offset-3">
                                <button type="button" class="btn btn-success btn-block" onclick="checkError('register-form')">
                                    Sign up
                                </button>
                            </div>
                        </div>
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                    </form:form>
                </div>
            </div>
        </div>
    </div>
</div>
<footer class="footer">
    <div class="container">
        <p class="text-muted">@ 2017 Blog</p>
    </div>
</footer>
</body>
</html>
