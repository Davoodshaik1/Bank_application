package com.example.model;

import java.io.IOException;
import java.math.BigDecimal;
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

@WebServlet("/CloseAccountServlet")
public class CloseAccountServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect("customerdashboard.jsp");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("customerUser") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String accountNo = (String) session.getAttribute("customerUser");

        Connection conn = null;
        PreparedStatement pstCheckBalance = null;
        PreparedStatement pstDelete = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/gen", "root", "Davood@43");

            // Check account balance
            String checkBalanceSql = "SELECT initial_balance FROM customers WHERE account_no = ?";
            pstCheckBalance = conn.prepareStatement(checkBalanceSql);
            pstCheckBalance.setLong(1, Long.parseLong(accountNo));
            rs = pstCheckBalance.executeQuery();

            if (rs.next()) {
                BigDecimal balance = rs.getBigDecimal("initial_balance");

                // If balance is zero, proceed to close account
                if (balance.compareTo(BigDecimal.ZERO) == 0) {
                    // Close the account
                    String deleteSql = "DELETE FROM customers WHERE account_no = ?";
                    pstDelete = conn.prepareStatement(deleteSql);
                    pstDelete.setLong(1, Long.parseLong(accountNo));
                    pstDelete.executeUpdate();

                    // Invalidate session and redirect to logout
                    session.invalidate();
                    response.sendRedirect("logout.jsp");
                } else {
                    // Redirect to dashboard with an error message
                    response.sendRedirect("closeAccount.jsp?error=Please%20withdraw%20all%20money%20before%20closing%20the%20account");
                }
            } else {
                // Account not found scenario (shouldn't happen in ideal case handling)
                response.sendRedirect("customerdashboard.jsp?error=Account%20not%20found");
            }

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            response.sendRedirect("customerdashboard.jsp?error=An%20error%20occurred");
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstCheckBalance != null) pstCheckBalance.close();
                if (pstDelete != null) pstDelete.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
