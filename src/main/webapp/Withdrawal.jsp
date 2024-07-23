<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.HttpSession" %>
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
    <title>Withdrawal</title>
</head>
<body>
    <h2>Withdrawal</h2>
    <form action="WithdrawalServlet" method="post">
        <label for="withdrawal_amount">Withdrawal Amount:</label>
        <input type="number" id="withdrawal_amount" name="withdrawal_amount" step="0.01" min="0" required><br><br>
        
        <input type="submit" value="Withdraw">
    </form>

    <%-- Display withdrawal success or error message --%>
    <%
        String withdrawalSuccess = request.getParameter("withdrawalSuccess");
        String error = request.getParameter("error");
        if (withdrawalSuccess != null && withdrawalSuccess.equals("true")) {
    %>
    <p style="color: green;">Withdrawal successful.</p>
    <%
        } else if (error != null && !error.isEmpty()) {
    %>
    <p style="color: red;"><%= error %></p>
    <%
        }
    %>
</body>
</html>
