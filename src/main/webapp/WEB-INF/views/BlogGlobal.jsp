<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: mrchebik
  Date: 22.01.17
  Time: 11:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Blog - ${userBlog}</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

    <link type="text/css" rel="stylesheet" href="<c:url value="/resources/css/layout.css"/>"/>
    <link type="text/css" rel="stylesheet" href="<c:url value="/resources/css/panel-body.css"/>"/>
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
            <li class="active"><a href="/blog/${username}">Global View</a></li>
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
        <c:if test="${userBlog != username}">
            <div class="col-md-4 col-md-offset-4">
                <div class="form-group">
                    <c:choose>
                        <c:when test="${!subscribe}">
                            <a href="/blog/${userBlog}/subscribe" class="btn btn-info btn-block" role="button">Subscribe</a>
                        </c:when>
                        <c:otherwise>
                            <a href="/blog/${userBlog}/unsubscribe" class="btn btn-info btn-block" role="button">Unsubscribe</a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </c:if>
        <c:choose>
            <c:when test="${posts.size() == 0}">
                <div class="col-md-2 col-md-offset-2">
                    <b class="text-warning">You do not have any posts!</b>
                </div>
            </c:when>
            <c:otherwise>
                <c:forEach items="${posts}" var="post" >
                    <div class="col-md-8 col-md-offset-2">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <a href="/blog/${username}/post/${post.postId}" class="btn btn-link" role="button">${post.title}</a><br>
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
                                <li><a href="<c:url value="/blog/${userBlog}?page=1"/>">1</a> ...</li>
                            </c:if>
                            <c:forEach begin="${page > 4 ? page - 2 : 1}" end="${page + 4 > pages ? pages : page + 2}" var="pageId">
                                <li class="${page == pageId ? "active" : ""}"><a href="<c:url value="/blog/${userBlog}?page=${pageId}"/>">${pageId}</a></li>
                            </c:forEach>
                            <c:if test="${page + 4 <= pages}">
                                <li>... <a href="<c:url value="/blog/${userBlog}?page=${pages}"/>">${pages}</a></li>
                            </c:if>
                        </ul>
                    </c:if>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>
<footer class="footer">
    <div class="container">
        <p class="text-muted">@ 2017 Blog</p>
    </div>
</footer>
</body>
</html>
