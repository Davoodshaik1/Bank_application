<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<%
     session = request.getSession(false);
    if (session == null || session.getAttribute("customerUser") == null) {
        response.sendRedirect("customerLogin.jsp");
        return;
    }
%>
<head>
    <meta charset="UTF-8">
    <title>Close Account</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f2f2f2;
        }
        .close-account-container {
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
        input[type="submit"] {
            background-color: #007BFF;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 4px;
            cursor: pointer;
            display: block;
            width: 100%;
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
    <div class="close-account-container">
        <h2>Close Account</h2>
        <form action="CloseAccountServlet" method="post">
            <div class="form-group">
                <label>Account Number:</label>
                <p><%= session.getAttribute("customerUser") %></p>
            </div>
            <div class="form-group">
                <label>Balance:</label>
                <p>$<%= session.getAttribute("initial_balance") %></p>
            </div>
            <input type="submit" value="Close Account">
        </form>
        <div class="message">
            <c:if test="${not empty param.error}">
                <p>${param.error}</p>
            </c:if>
        </div>
    </div>
</body>
</html>
