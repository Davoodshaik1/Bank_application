package com.example.model;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/WithdrawalServlet")
public class WithdrawalServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve session attribute (account number)
        HttpSession session = request.getSession(false);
        String accountNo = (String) session.getAttribute("account_no");

        // Read parameters
        double withdrawalAmount = Double.parseDouble(request.getParameter("withdrawal_amount"));

        // Database connection parameters
        String url = "jdbc:mysql://localhost:3306/gen";
        String username = "root";
        String dbPassword = "Davood@43";

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            // Establish connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(url, username, dbPassword);

            // Check account balance
            String sqlSelect = "SELECT initial_balance FROM customers WHERE account_no = ?";
            pstmt = conn.prepareStatement(sqlSelect);
            pstmt.setString(1, accountNo);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                double currentBalance = rs.getDouble("initial_balance");

                if (currentBalance >= withdrawalAmount) {
                    // Update balance
                    double newBalance = currentBalance - withdrawalAmount;
                    String sqlUpdate = "UPDATE customers SET initial_balance = ? WHERE account_no = ?";
                    pstmt = conn.prepareStatement(sqlUpdate);
                    pstmt.setDouble(1, newBalance);
                    pstmt.setString(2, accountNo);
                    pstmt.executeUpdate();

                    // Log transaction
                    String sqlInsertTransaction = "INSERT INTO transactions (account_no, description, amount, balance) VALUES (?, ?, ?, ?)";
                    pstmt = conn.prepareStatement(sqlInsertTransaction);
                    pstmt.setString(1, accountNo);
                    pstmt.setString(2, "Withdrawal");
                    pstmt.setDouble(3, withdrawalAmount);
                    pstmt.setDouble(4, newBalance);
                    pstmt.executeUpdate();

                    // Set new balance in session attribute
                    session.setAttribute("initial_balance", newBalance);

                    // Redirect to success page or dashboard
                    response.sendRedirect("customerdashboard.jsp?withdrawalSuccess=true");
                } else {
                    // Insufficient balance
                    response.sendRedirect("Withdrawal.jsp?error=Insufficient balance for withdrawal.");
                }
            } else {
                // Account not found
                response.sendRedirect("Withdrawal.jsp?error=Account not found.");
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            response.sendRedirect("Withdrawal.jsp?error=An error occurred. Please try again.");
        } finally {
            // Close connections
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
