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
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

    <link type="text/css" rel="stylesheet" href="<c:url value="/resources/css/layout.css"/>"/>
    <script type="text/javascript" src="<c:url value="/resources/js/Profile.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/resources/js/logout.js"/>"></script>
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
            <li><a href="<c:url value="/blog/news"/>">News</a></li>
            <li class="active"><a href="<c:url value="/blog/setting/"/>">Setting</a></li>
        </ul>
        <ul class="nav navbar-nav navbar-right">
            <li><a onclick="logout()"><span class="glyphicon glyphicon-log-out"></span> Logout</a></li>
        </ul>
    </div>
</nav>
<div class="container-fluid">
    <div class="row">
        <div class="col-md-4 col-md-offset-4">
            <div class="well">
                <h2>
                    Username
                </h2>
                <form id="username-form" action="<c:url value="/blog/setting/rename"/>" method="post">
                    <div class="form-group">
                        <input class="form-control" id="username" type="text" name="username" placeholder="Username" oninput="checkSetting(this.id)">
                    </div>
                    <div class="row">
                        <div class="col-md-6 col-md-offset-3">
                            <button class="btn btn-success btn-block" onclick="checkError('username-form')">
                                Edit username
                            </button>
                        </div>
                    </div>
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                </form>
            </div>
        </div>
        <div class="col-md-4 col-md-offset-4">
            <div class="well">
                <h2>
                    Password
                </h2>
                <form id="password-form" action="<c:url value="/blog/setting/password"/>" method="post">
                    <div class="form-group">
                        <input class="form-control" id="oldPassword" type="password" name="oldPassword" placeholder="Old password" oninput="checkSetting(this.id)">
                    </div>
                    <div class="form-group">
                        <input class="form-control" id="newPassword" type="password" name="newPassword" placeholder="New password" oninput="checkSetting(this.id)">
                    </div>
                    <div class="form-group">
                        <input class="form-control" id="passwordConfirm" type="password" name="passwordConfirm" placeholder="Password confirm" oninput="checkSetting(this.id)">
                    </div>
                    <div class="row">
                        <div class="col-md-6 col-md-offset-3">
                            <button class="btn btn-success btn-block" onclick="checkError('password-form')">
                                Edit password
                            </button>
                        </div>
                    </div>
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                </form>
            </div>
        </div>
        <div class="col-md-4 col-md-offset-4">
            <div class="well">
                <h2>
                    Email
                </h2>
                <form id="email-form" action="<c:url value="/blog/setting/email"/>" method="post">
                    <div class="form-group">
                        <input class="form-control" id="newEmail" type="text" name="newEmail" placeholder="Email" oninput="checkSetting(this.id)">
                    </div>
                    <div class="row">
                        <div class="col-md-6 col-md-offset-3">
                            <button class="btn btn-success btn-block" onclick="checkError('email-form')">
                                Edit email
                            </button>
                        </div>
                    </div>
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                </form>
            </div>
        </div>
        <div class="col-md-4 col-md-offset-4">
            <a href="<c:url value="/blog/setting/delete"/>" class="btn btn-danger btn-block" role="button">
                Delete profile
            </a>
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
