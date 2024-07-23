<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<!DOCTYPE html>
<%
     session = request.getSession(false);
    if (session == null || session.getAttribute("customerUser") == null) {
        response.sendRedirect("customerLogin.jsp");
        return;
    }
%>
<html>
<head>
    <meta charset="UTF-8">
    <title>Change Password</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f2f2f2;
        }
        .change-password-container {
            background-color: #ffffff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            max-width: 800px;
            margin: 0 auto;
        }
        h2 {
            text-align: center;
        }
        .form-group {
            margin-bottom: 15px;
        }
        label {
            display: block;
            margin-bottom: 5px;
        }
        input[type="password"] {
            width: 100%;
            padding: 10px;
            border-radius: 4px;
            border: 1px solid #ccc;
        }
        input[type="submit"] {
            background-color: #007BFF;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 4px;
            cursor: pointer;
            display: block;
            width: 100%;
            margin-top: 20px;
        }
        input[type="submit"]:hover {
            background-color: #0056b3;
        }
        .message {
            text-align: center;
            color: red;
        }
    </style>
</head>
<body>
    <div class="change-password-container">
        <h2>Change Password</h2>
        <form action="ChangePasswordServlet" method="post">
            <div class="form-group">
                <label>Current Password:</label>
                <input type="password" name="currentPassword" required>
            </div>
            <div class="form-group">
                <label>New Password:</label>
                <input type="password" name="newPassword" required>
            </div>
            <input type="submit" value="Change Password">
        </form>
        <div class="message">
            <c:if test="${not empty param.error}">
                <p>${param.error}</p>
            </c:if>
            <c:if test="${not empty param.success}">
                <p style="color: green;">${param.success}</p>
            </c:if>
        </div>
    </div>
</body>
</html>
