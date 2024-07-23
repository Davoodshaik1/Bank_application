<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
<!DOCTYPE html>
<%
     session = request.getSession(false);
    if (session == null || session.getAttribute("adminUser") == null) {
        response.sendRedirect("adminlogin.jsp");
        return;
    }
%>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f2f2f2;
        }
        .dashboard-container {
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
        .customer-actions {
            text-align: center;
            margin-top: 30px;
        }
        .customer-actions a {
            text-decoration: none;
            color: #007BFF;
            font-size: 18px;
            margin-right: 15px;
            display: inline-block;
            margin-bottom: 10px;
        }
        .customer-actions a:hover {
            text-decoration: underline;
        }
        .logout-container {
            text-align: center;
            margin-top: 20px;
        }
        .logout-container form {
            display: inline-block;
        }
        .logout-container input[type="submit"] {
            background-color: #007BFF;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 4px;
            cursor: pointer;
        }
        .logout-container input[type="submit"]:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="dashboard-container">
        <h2>Admin Dashboard</h2>
        
        <h3>Customer Management</h3>
        <div class="customer-actions">
            <a href="registercustomer.jsp">Register Customer</a>
            <a href="viewcustomers.jsp">View Customers</a>
            <a href="modifycustomers.jsp">Modify Customer</a>
            <a href="deletecustomer.jsp">Delete Customer</a>
        </div>

        <div class="logout-container">
            <form action="AdminLogoutServlet" method="post">
                <input type="submit" value="Logout">
            </form>
        </div>
    </div>
</body>
</html>
