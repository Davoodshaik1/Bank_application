<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
    <title>Transaction History</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.4.0/jspdf.umd.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.5.13/jspdf.plugin.autotable.min.js"></script>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f2f2f2;
        }
        .transaction-container {
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
        .transaction-list {
            margin-top: 20px;
        }
        .transaction {
            margin-bottom: 20px;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            background-color: #f9f9f9;
        }
        .download-button {
            text-align: center;
            margin-top: 20px;
        }
        .download-button button {
            background-color: #007BFF;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
        }
        .download-button button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="transaction-container">
        <h2>Transaction History</h2>

        <div class="transaction-list">
            <table id="transactionTable">
                <thead>
                    <tr>
                        <th>Transaction ID</th>
                        <th>Date</th>
                        <th>Description</th>
                        <th>Amount</th>
                        <th>Balance</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="transaction" items="${transactionList}">
                        <tr>
                            <td>${transaction.id}</td>
                            <td>${transaction.date}</td>
                            <td>${transaction.description}</td>
                            <td>${transaction.amount}</td>
                            <td>${transaction.balance}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <div class="download-button">
            <button onclick="downloadPDF()">Download Transaction History as PDF</button>
        </div>
    </div>

    <script>
        function downloadPDF() {
            const { jsPDF } = window.jspdf;
            const doc = new jsPDF();
            
            const table = document.getElementById("transactionTable");
            doc.autoTable({ html: table });

            doc.save("transactions.pdf");
        }
    </script>
</body>
</html>
