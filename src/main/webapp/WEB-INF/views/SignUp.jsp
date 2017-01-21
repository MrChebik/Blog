<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
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
    <title>Blog - Register</title>
    <link type="text/css" rel="stylesheet" href="<c:url value="/resources/css/default.css"/>"/>
    <link type="text/css" rel="stylesheet" href="<c:url value="/resources/css/Auth.css"/>"/>
    <link type="text/css" rel="stylesheet" href="<c:url value="/resources/css/Boxes.css"/>"/>
    <script type="text/javascript" src="<c:url value="/resources/js/Auth.js"/>"></script>
</head>
<body>
    <div class="top">
        Blog <span class="header">Register</span>
    </div>
    <div class="center">
        <div class="centerBox">
            <form:form id="form1" modelAttribute="userForm" method="post">
                <c:if test="${error != null}">
                    Duplicate user.
                </c:if>
                <spring:bind path="email">
                    <input id="email" type="text" name="email" required placeholder="Email" oninput="check('email')">
                </spring:bind>
                <spring:bind path="username">
                    <input id="username" type="text" name="username" required placeholder="Username" oninput="check('username')">
                </spring:bind>
                <spring:bind path="password">
                    <input id="password" type="password" name="password" required placeholder="Password" oninput="check('password')">
                </spring:bind>
                <input id="passwordConfirm" type="password" name="passwordConfirm" required placeholder="Password Confirm" oninput="check('passwordConfirm')">
                <div class="button" onclick="checkError()">
                    Sign up
                </div>
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
            </form:form>
        </div>
    </div>
    <div class="footer">
        © 2017 Blog
    </div>
</body>
</html>
