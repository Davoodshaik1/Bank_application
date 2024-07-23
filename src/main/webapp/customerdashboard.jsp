<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%
      session = request.getSession(false);
    if (session == null || session.getAttribute("customerUser") == null) {
        response.sendRedirect("customerLogin.jsp");
        return;
    }
    String accountNo = (String) session.getAttribute("account_no");
    Double initialBalance = (Double) session.getAttribute("initial_balance");
    System.out.println("Account Number retrieved from session: " + accountNo);
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Customer Dashboard</title>
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
        .account-info {
            text-align: center;
            margin-top: 20px;
        }
        .account-info p {
            font-size: 18px;
        }
    </style>
</head>
<body>
    <div class="dashboard-container">
        <h2>Customer Dashboard</h2>
        
        <div class="account-info">
            <p>Account Number: <%= accountNo %></p>
            <p>Balance: $<%= initialBalance %></p>
        </div>

        <h3>Account Management</h3>
        <div class="customer-actions">
            <a href="ViewTransactionsServlet">View Transactions</a>
            <a href="depositMoney.jsp">Deposit Money</a>
            <a href="Withdrawal.jsp">Withdraw Money</a>
            <a href="closeAccount.jsp">Close Account</a>
            <a href="changePassword.jsp">Change Password</a>
        </div>

        <div class="logout-container">
            <form action="CustomerLogoutServlet" method="post">
                <input type="submit" value="Logout">
            </form>
        </div>
    </div>
</body>
</html>
