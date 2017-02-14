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
    <title>Blog - Categories</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

    <link type="text/css" rel="stylesheet" href="<c:url value="/resources/css/layout.css"/>"/>
    <link type="text/css" rel="stylesheet" href="<c:url value="/resources/css/Category.css"/>"/>
    <script type="text/javascript" src="<c:url value="/resources/js/Category.js"/>"></script>
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
        <div class="col-md-4 col-md-offset-2">
            <div class="well well-sm">
                ${name}
            </div>
        </div>
        <form id="category-form" action="<c:url value="/blog/categories/add"/>" method="post">
            <div class="col-md-2">
                <div class="form-group">
                    <input class="form-control" id="categoryName" type="text" name="categoryName" placeholder="Name of category" oninput="checkText(this)">
                    <input id="level" type="hidden" name="level" value="${level}">
                    <input id="parentId" type="hidden" name="parentId" value="${parentId}">
                    <input id="id" type="hidden" name="id" value="${id}">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                </div>
            </div>
            <div class="col-md-2">
                <div class="form-group">
                    <button type="button" class="btn btn-primary btn-block" onclick="checkError('category-form')">
                        Add category
                    </button>
                </div>
            </div>
        </form>
        <div class="col-md-8 col-md-offset-2">
            <c:choose>
                <c:when test="${categories.size() == 0}" >
                    <b class="text-warning">You do not have any categories.</b>
                </c:when>
                <c:otherwise>
                    <form id="cat-form" method="get">
                        <table class="table table-striped table-hover">
                            <thead>
                            <tr>
                                <th class="col-md-1">№</th>
                                <th class="col-md-9">Name</th>
                                <th class="col-md-1"></th>
                                <th class="col-md-1"></th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${categories}" var="category" >
                                <tr>
                                    <td>${categories.indexOf(category) + 1}</td>
                                    <td><a id="cat${category.categoryId}" href="/blog/categories/${category.categoryId}" class="btn btn-link">${category.name}</a><input id="text${category.categoryId}" class="text form-control" type="text" placeholder="Name" value="${category.name}" oninput="checkText(this)"></td>
                                    <td>
                                        <button type="button" class="btn btn-info" id="edit${category.categoryId}" onclick="edit(${category.categoryId})">Edit</button>
                                        <button type="button" class="btn btn-success save" id="save${category.categoryId}" onclick="saveData(${category.categoryId})">Save</button>
                                    </td>
                                    <td><a href="<c:url value="/blog/categories/delete?id=${category.categoryId}"/>" class="btn btn-danger" role="button">Remove</a></td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                        <c:if test="${pages > 1}">
                            <ul class="pagination">
                                <c:if test="${page > 4}">
                                    <li><a href="<c:url value="/blog/categories/${id}?page=1"/>">1</a> ...</li>
                                </c:if>
                                <c:forEach begin="${page > 4 ? page - 2 : 1}" end="${page + 4 > pages ? pages : page + 2}" var="pageId">
                                    <li class="${page == pageId ? "active" : ""}"><a href="<c:url value="/blog/categories/${id}?page=${pageId}"/>">${pageId}</a></li>
                                </c:forEach>
                                <c:if test="${page + 4 <= pages}">
                                    <li>... <a href="<c:url value="/blog/categories/${id}?page=${pages}"/>">${pages}</a></li>
                                </c:if>
                            </ul>
                        </c:if>
                    </form>
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
