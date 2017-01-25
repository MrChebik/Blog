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
    <link type="text/css" rel="stylesheet" href="<c:url value="/resources/css/default.css"/>"/>
    <link type="text/css" rel="stylesheet" href="<c:url value="/resources/css/Boxes.css"/>"/>
    <link type="text/css" rel="stylesheet" href="<c:url value="/resources/css/Blog.css"/>"/>
</head>
<body>
<div class="top">
    <div class="blog">
        Blog
    </div>
    <c:if test="${username != null}">
        <div class="bar">
            <ul id="navbar">
                <li onclick="window.location.href='/blog/';"><span>Home</span></li>
                <li onclick="window.location.href='/blog/{username}/';"><span>View</span></li>
                <li onclick="window.location.href='/blog/news';"><span>News</span></li>
                <li onclick="window.location.href='/blog/setting/';"><span>Setting</span></li>
                <li onclick="window.location.href='/blog/logout/';"><span>Logout</span></li>
            </ul>
        </div>
    </c:if>
</div>
<div class="center">
    <div class="postsBox">
        <c:choose>
            <c:when test="${posts.size() == 0}" >
                <b>This user do not have any posts.</b>
            </c:when>
            <c:otherwise>
                <form id="form1" method="get">
                    <c:forEach items="${posts}" var="post" >
                        <div class="postBox">
                            <div class="categoryBox"></div>
                            <div class="titleBox fake-link" onclick="window.location.href='/blog/${username}/post/${post.postId}'">
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
