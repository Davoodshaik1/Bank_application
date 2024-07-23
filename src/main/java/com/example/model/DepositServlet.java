package com.example.model;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Timestamp;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.ResultSet;

@WebServlet("/DepositServlet")
public class DepositServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("customerUser") == null) {
            response.sendRedirect("customerLogin.jsp");
            return;
        }

        String accountNo = (String) session.getAttribute("customerUser");
        double amount = Double.parseDouble(request.getParameter("amount"));

        Connection conn = null;
        PreparedStatement depositStmt = null;
        PreparedStatement transactionStmt = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/gen", "root", "Davood@43");

            conn.setAutoCommit(false);

            String updateQuery = "UPDATE customers SET initial_balance = initial_balance + ? WHERE account_no = ?";
            depositStmt = conn.prepareStatement(updateQuery);
            depositStmt.setDouble(1, amount);
            depositStmt.setString(2, accountNo);
            int rowCount = depositStmt.executeUpdate();

            if (rowCount > 0) {
                String insertQuery = "INSERT INTO transactions (account_no, description, amount, balance, transaction_date) VALUES (?, ?, ?, ?, ?)";
                transactionStmt = conn.prepareStatement(insertQuery);
                transactionStmt.setString(1, accountNo);
                transactionStmt.setString(2, "Deposit");
                transactionStmt.setDouble(3, amount);

                String selectQuery = "SELECT initial_balance FROM customers WHERE account_no = ?";
                PreparedStatement selectStmt = conn.prepareStatement(selectQuery);
                selectStmt.setString(1, accountNo);
                ResultSet rs = selectStmt.executeQuery();
                double balance = 0.0;
                if (rs.next()) {
                    balance = rs.getDouble("initial_balance");
                }
                selectStmt.close();
                transactionStmt.setDouble(4, balance);
                transactionStmt.setTimestamp(5, new Timestamp(System.currentTimeMillis()));

                int transactionRowCount = transactionStmt.executeUpdate();

                conn.commit();

                session.setAttribute("initial_balance", balance);

                response.sendRedirect("customerdashboard.jsp?accountno=" + accountNo);
            } else {
                conn.rollback();
                response.getWriter().println("Deposit failed. Please try again.");
            }

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            try {
                if (conn != null) {
                    conn.rollback();
                }
            } catch (SQLException rollbackEx) {
                rollbackEx.printStackTrace();
            }
            response.getWriter().println("An error occurred: " + e.getMessage());
        } finally {
            try {
                if (depositStmt != null) depositStmt.close();
                if (transactionStmt != null) transactionStmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
                response.getWriter().println("An error occurred while closing resources: " + e.getMessage());
            }
        }
    }
}
