<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: mrchebik
  Date: 17.01.17
  Time: 0:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Blog - Password recovery</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

    <link type="text/css" rel="stylesheet" href="<c:url value="/resources/css/layout.css"/>"/>
    <link type="text/css" rel="stylesheet" href="<c:url value="/resources/css/logo.css"/>"/>
    <link type="text/css" rel="stylesheet" href="<c:url value="/resources/css/form.css"/>"/>
    <script type="text/javascript" src="<c:url value="/resources/js/Forgot.js"/>"></script>
    <c:if test="${code != null}">
        <style>
            #forgot-form {
                display: none;
            }

            #code-form {
                display: block !important;
            }
        </style>
    </c:if>
    <c:if test="${password != null}">
        <style>
            #forgot-form {
                display: none;
            }

            #password-form {
                display: block !important;
            }
        </style>
    </c:if>
</head>
<body>
<div class="container-fluid">
    <div class="row">
        <div class="col-md-12 logo">
            Blog
        </div>
        <div class="col-md-2 col-md-offset-5">
            <div class="panel panel-default">
                <div class="panel-body">
                    <form id="forgot-form" action="<c:url value="/auth/forgot"/>" method="post">
                        <div class="form-group">
                            <input class="form-control" type="text" id="forgot-email" name="email" placeholder="Email" oninput="check(this.id)">
                        </div>
                        <div class="row">
                            <div class="col-md-6 col-md-offset-3">
                                <button type="button" class="btn btn-success btn-block" onclick="checkError('forgot-form')">
                                    Send email
                                </button>
                            </div>
                        </div>
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                    </form>
                    <form id="code-form" action="<c:url value="/auth/check"/>" method="post" style="display: none">
                        <div class="form-group">
                            <input class="form-control" type="text" name="code" placeholder="Code">
                        </div>
                        <div class="row">
                            <div class="col-md-6 col-md-offset-3">
                                <button type="button" class="btn btn-success btn-block" onclick="checkError('code-form')">
                                    Send code
                                </button>
                            </div>
                        </div>
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                    </form>
                    <form id="password-form" action="/auth/newPassword/${checkedCode}" method="post" style="display: none">
                        <div class="form-group">
                            <input class="form-control" id="password" type="password" name="password" placeholder="Password" oninput="check(this.id)">
                        </div>
                        <div class="form-group">
                            <input class="form-control" id="password-confirm" type="password" name="passwordConfirm" placeholder="Password Confirm" oninput="check(this.id)">
                        </div>
                        <div class="row">
                            <div class="col-md-6 col-md-offset-3">
                                <button type="button" class="btn btn-success btn-block" onclick="checkError('password-form')">
                                    Finish
                                </button>
                            </div>
                        </div>
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                    </form>
                </div>
            </div>
        </div>
    </div>
    <div class="footer navbar-fixed-bottom">
        <hr>
        © 2017 Blog
    </div>
</div>
</body>
</html>
