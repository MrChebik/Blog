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
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

    <link type="text/css" rel="stylesheet" href="<c:url value="/resources/css/layout.css"/>"/>
    <link type="text/css" rel="stylesheet" href="<c:url value="/resources/css/textarea.css"/>"/>
    <script type="text/javascript" src="<c:url value="/resources/js/AddPost.js"/>"></script>
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
            <li><a href="<c:url value="/blog/setting/"/>">Setting</a></li>
        </ul>
        <ul class="nav navbar-nav navbar-right">
            <li><a onclick="logout()"><span class="glyphicon glyphicon-log-out"></span> Logout</a></li>
        </ul>
    </div>
</nav>
<div class="container-fluid">
    <div class="row">
        <c:if test="${categories != '[]'}">
            <div class="col-md-4 col-md-offset-1">
                <div class="form-group">
                    <select multiple class="form-control" name="categories" id="categories">
                        <c:forEach items="${categories}" var="category">
                            <option id="${category.categoryId}">
                                ${category.name}
                            </option>
                        </c:forEach>
                    </select>
                </div>
            </div>
        </c:if>
        <form id="post-form" method="post">
            <div class="col-md-${categories != '[]' ? '6' : '10 col-md-offset-1'}">
                <div class="form-group">
                    <input class="form-control" id="title" type="text" name="title" oninput="check()" placeholder="Title" value="${post.title}" onload="check()">
                </div>
            </div>
            <div class="col-md-10 col-md-offset-1">
                <div class="form-group">
                    <textarea class="form-control" id="text" name="text" rows="30" placeholder="Text">${post.text}</textarea>
                </div>
            </div>
            <div class="col-md-2 col-md-offset-5">
                <div class="form-group">
                    <button type="button" class="btn btn-success btn-block" onclick="checkError()">
                        ${post.title != null ? "Save post" : "Add post"}
                    </button>
                </div>
            </div>
            <input type="hidden" name="categoriesId">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
        </form>
    </div>
</div>
<footer class="footer">
    <div class="container">
        <p class="text-muted">@ 2017 Blog</p>
    </div>
</footer>
</body>
</html>
