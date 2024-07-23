<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.*, java.sql.*" %>
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
    <title>Deposit Money</title>
</head>
<body>
    <h2>Deposit Money</h2>
    <form action="DepositServlet" method="post">
        <label for="amount">Amount:</label>
        <input type="number" id="amount" name="amount" step="0.01" min="0.01" required><br><br>
        
        <input type="submit" value="Deposit">
    </form>
</body>
</html>
