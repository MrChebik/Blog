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
    <title>Title</title>
</head>
<body>
<h1>Blog</h1>
<div class="center">
    <div class="topBox">
        Profile | Logout
    </div>
    <div class="centerBox">
        <c:choose>
            <c:when test="${posts.size() == 0}" >
                <b>You do not have any posts</b>
            </c:when>
            <c:otherwise>
                <form id="form1" method="get">
                    <table>
                        <tr>
                            <th>Title</th>
                            <th>Text</th>
                        </tr>
                        <c:forEach items="${notes}" var="note" >
                            <tr>
                                <td>${note.title}</td>
                                <td>${note.text}</td>
                                <td><span class="fake-link" id="${note.id}" onclick="submitData(this.id, '0071')">Remove</span></td>
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
</body>
</html>
