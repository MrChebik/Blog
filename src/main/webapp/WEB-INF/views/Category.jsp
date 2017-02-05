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
    <link type="text/css" rel="stylesheet" href="<c:url value="/resources/css/default.css"/>"/>
    <link type="text/css" rel="stylesheet" href="<c:url value="/resources/css/Boxes.css"/>"/>
    <link type="text/css" rel="stylesheet" href="<c:url value="/resources/css/Blog.css"/>"/>
    <script type="text/javascript" src="<c:url value="/resources/js/Category.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/resources/js/submit.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/resources/js/logout.js"/>"></script>
    <style>
        td:nth-child(3), td:nth-child(4) {
            width: 3%;
        }

        #save, .text {
            display: none;
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
            <li onclick="window.location.href='/blog/${username}/';"><span>View</span></li>
            <li onclick="window.location.href='/blog/news';"><span>News</span></li>
            <li onclick="window.location.href='/blog/setting/';"><span>Setting</span></li>
            <li onclick="logout()"><span>Logout</span></li>
        </ul>
    </div>
</div>
<div class="center">
    <div class="menu">
        ${name}
        <div class="addButton" onclick="showAdd()">
            Add category
        </div>
        <!--<div class="editButton">
            Edit category
        </div>
        <div class="addButton">
            Remove category
        </div>-->
    </div>
    <div id="label" style="display:none;">
        <form name="form1" action="<c:url value="/blog/categories/add"/>" method="post">
            <input id="categoryName" type="text" name="categoryName" placeholder="Name of category">
            <input id="level" type="hidden" name="level" value="${level}">
            <input id="parentId" type="hidden" name="parentId" value="${parentId}">
            <input id="id" type="hidden" name="id" value="${id}">
            <button type="submit">Save</button>
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
        </form>
    </div>
    <div class="postsBox">
        <c:choose>
            <c:when test="${categories.size() == 0}" >
                <b>You do not have any categories</b>
            </c:when>
            <c:otherwise>
                <form id="form1" method="get">
                    <table>
                        <tr>
                            <th>№</th>
                            <th>Name</th>
                        </tr>
                        <c:forEach items="${categories}" var="category" >
                            <tr>
                                <td>${categories.indexOf(category) + 1}</td>
                                <td><span id="cat${category.categoryId}" class="fake-link" onclick="window.location.href='/blog/categories/${category.categoryId}'">${category.name}</span><input id="text${category.categoryId}" class="text" type="text" placeholder="Name" value="${category.name}" oninput="checkText(this)"></td>
                                <td><span id="edit" class="fake-link" onclick="edit(${category.categoryId})">Edit</span><span id="save" class="fake-link" onclick="saveData(${category.categoryId})">Save</span></td>
                                <td><span class="fake-link" onclick="window.location.href='/blog/categories/delete?id=${category.categoryId}'">Remove</span></td>
                            </tr>
                        </c:forEach>
                    </table>
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
            </c:otherwise>
        </c:choose>
    </div>
</div>
<div class="footer">
    <hr class="footer">
    © 2017 Blog
</div>
</body>
</html>
