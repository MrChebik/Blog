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
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

    <link type="text/css" rel="stylesheet" href="<c:url value="/resources/css/layout.css"/>"/>
    <link type="text/css" rel="stylesheet" href="<c:url value="/resources/css/textarea.css"/>"/>
    <link type="text/css" rel="stylesheet" href="<c:url value="/resources/css/form.css"/>"/>
    <link type="text/css" rel="stylesheet" href="<c:url value="/resources/css/panel-body.css"/>"/>
    <script type="text/javascript" src="<c:url value="/resources/js/Post.js"/>"></script>
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
        <c:if test="${user.username == username0}">
            <div class="col-md-2 col-md-offset-4">
                <div class="form-group">
                    <a href="/blog/post/${post.postId}/edit" class="btn btn-info btn-block" role="button">
                        Edit post
                    </a>
                </div>
            </div>
            <div class="col-md-2">
                <div class="form-group">
                    <a href="/blog/post/${post.postId}/remove" class="btn btn-danger btn-block" role="button">
                        Delete post
                    </a>
                </div>
            </div>
        </c:if>
        <div class="col-md-8 col-md-offset-2">
            <div class="panel panel-primary">
                <div class="panel-heading">
                    ${post.title}<br>
                    ${categoryPath}
                </div>
                <div class="panel-body">
                    ${post.text}
                </div>
                <div class="panel-footer">
                    ${post.date}
                </div>
            </div>
        </div>
        <c:choose>
            <c:when test="${commentEdit != null}">
                <div class="col-md-8 col-md-offset-2">
                    <div class="panel panel-warning">
                        <div class="panel-heading">
                            <form id="comment-edit-form" action="/blog/post/${post.postId}/comment/edit?id=${commentEdit.commentId}&username=${post.user.username}" method="post">
                                <textarea class="form-control" id="textComment" name="text" rows="15" oninput="check(this.id)" placeholder="Text">${commentEdit.text}</textarea>
                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                            </form>
                        </div>
                        <div class="panel-footer">
                            <div class="row">
                                <div class="col-md-2 col-md-offset-5">
                                    <button class="btn btn-success btn-block" onclick="checkError('comment-edit-form')">
                                        Save comment
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <c:if test="${comments.size() != 0}">
                    <c:forEach items="${comments}" var="comment" >
                        <div class="col-md-${user.username == comment.user.username || user.username == username0 || user.username == comment.user.username ? '7' : '8'} col-md-offset-2">
                            <div class="panel panel-info">
                                <div class="panel-heading">
                                    ${comment.user.username}
                                </div>
                                <div class="panel-body">
                                    ${comment.text}
                                </div>
                                <div class="panel-footer">
                                    ${comment.date}
                                </div>
                            </div>
                        </div>
                        <c:if test="${user.username == comment.user.username || user.username == username0 || user.username == comment.user.username}">
                            <div class="col-md-1">
                                <div class="row">
                                    <c:if test="${user.username == comment.user.username}">
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <a href="/blog/post/${post.postId}/comment/edit?id=${comment.commentId}" class="btn btn-info btn-block" role="button">
                                                    Edit
                                                </a>
                                            </div>
                                        </div>
                                    </c:if>
                                    <c:if test="${user.username == username0 || user.username == comment.user.username}">
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <a href="/blog/post/${post.postId}/comment/remove?id=${comment.commentId}&username=${username}" class="btn btn-danger btn-block" role="button">
                                                    Remove
                                                </a>
                                            </div>
                                        </div>
                                    </c:if>
                                </div>
                            </div>
                        </c:if>
                    </c:forEach>
                </c:if>
                <c:if test="${user != null && (pages == 0 || page == pages)}">
                    <div class="col-md-8 col-md-offset-2">
                        <div class="panel panel-warning">
                            <div class="panel-heading">
                                <form id="comment-add-form" action="/blog/${post.user.username}/post/${post.postId}?page=${page}" method="post">
                                    <textarea class="form-control" id="text" name="text" rows="15" placeholder="Text" oninput="check(this.id)"></textarea>
                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                                </form>
                            </div>
                            <div class="panel-footer">
                                <div class="row">
                                    <div class="col-md-2 col-md-offset-5">
                                        <button class="btn btn-success btn-block" onclick="checkError('comment-add-form')">
                                            Add comment
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:if>
                <div class="col-md-8 col-md-offset-2">
                    <c:if test="${pages > 1}">
                        <ul class="pagination">
                            <c:if test="${page > 4}">
                                <li><a href="<c:url value="/blog/${post.user.username}/post/${post.postId}?page=1"/>">1</a> ...</li>
                            </c:if>
                            <c:forEach begin="${page > 4 ? page - 2 : 1}" end="${page + 4 > pages ? pages : page + 2}" var="pageId">
                                <li class="${page == pageId ? "active" : ""}"><a href="<c:url value="/blog/${post.user.username}/post/${post.postId}?page=${pageId}"/>">${pageId}</a></li>
                            </c:forEach>
                            <c:if test="${page + 4 <= pages}">
                                <li>... <a href="<c:url value="/blog/${post.user.username}/post/${post.postId}?page=${pages}"/>">${pages}</a></li>
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
