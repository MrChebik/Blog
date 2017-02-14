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
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

    <link type="text/css" rel="stylesheet" href="<c:url value="/resources/css/layout.css"/>"/>
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
            <li class="active"><a href="#">Home</a></li>
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
        <div class="col-md-2 col-md-offset-3">
            <div class="btn-group form-group">
                <a href="<c:url value="/blog/categories/-1"/>" class="btn btn-primary" role="button">Categories</a>
                <a href="<c:url value="/blog/post/add"/>" class="btn btn-primary" role="button">Add post</a>
            </div>
        </div>
        <div class="col-md-8 col-md-offset-2">
            <c:choose>
                <c:when test="${posts.size() == 0}" >
                    <b class="text-warning">You do not have any posts!</b>
                </c:when>
                <c:otherwise>
                    <table class="table table-striped table-hover">
                        <thead>
                        <tr>
                            <th class="col-md-1">№</th>
                            <th class="col-md-3">Title</th>
                            <th class="col-md-6">Text</th>
                            <th class="col-md-2">Date</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${posts}" var="post" >
                            <tr onclick="window.location.href='/blog/${username}/post/${post.postId}'">
                                <td>${posts.indexOf(post) + 1}</td>
                                <td>${post.title}</td>
                                <td>${post.text}</td>
                                <td>${post.date}</td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                    <c:if test="${pages > 1}">
                        <ul class="pagination">
                            <c:if test="${page > 4}">
                                <li><a href="<c:url value="/blog?page=1"/>">1</a> ...</li>
                            </c:if>
                            <c:forEach begin="${page > 4 ? page - 2 : 1}" end="${page + 4 > pages ? pages : page + 2}" var="pageId">
                                <li class="${page == pageId ? "active" : ""}"><a href="<c:url value="/blog?page=${pageId}"/>">${pageId}</a></li>
                            </c:forEach>
                            <c:if test="${page + 4 <= pages}">
                                <li>... <a href="<c:url value="/blog?page=${pages}"/>">${pages}</a></li>
                            </c:if>
                        </ul>
                    </c:if>
                </c:otherwise>
            </c:choose>
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
